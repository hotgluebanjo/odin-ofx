package invert

import "../ofx"

PLUGIN_GROUP        :: "Odin Example OFX Plugins"
PLUGIN_NAME         :: "Invert"
PLUGIN_VERSION      :: "0.1.0"
PLUGIN_DESCRIPTION  :: "Inverts ya stuff."

host:   ^ofx.OfxHost
effect: ^ofx.OfxImageEffectSuiteV1
prop:   ^ofx.OfxPropertySuiteV1

load :: proc() -> ofx.OfxStatus {
    if host == nil {
        return ofx.kOfxStatErrMissingHostFeature
    }

    effect = cast(^ofx.OfxImageEffectSuiteV1) host.fetchSuite(host.host, ofx.kOfxImageEffectSuite, 1)
    prop   = cast(^ofx.OfxPropertySuiteV1)    host.fetchSuite(host.host, ofx.kOfxPropertySuite,    1)

    if effect == nil || prop == nil {
        return ofx.kOfxStatErrMissingHostFeature
    }

    return ofx.kOfxStatOK
}

unload :: proc() -> ofx.OfxStatus {
    return ofx.kOfxStatOK
}

describe :: proc(descriptor: ofx.OfxImageEffectHandle) -> ofx.OfxStatus {
    properties: ofx.OfxPropertySetHandle
    effect.getPropertySet(descriptor, &properties)

    // Labels
    prop.propSetString(properties, ofx.kOfxPropLabel, 0, PLUGIN_NAME)
    prop.propSetString(properties, ofx.kOfxImageEffectPluginPropGrouping, 0, PLUGIN_GROUP)
    prop.propSetString(properties, ofx.kOfxPropPluginDescription, 0, PLUGIN_DESCRIPTION)
    prop.propSetString(properties, ofx.kOfxPropVersionLabel, 0, PLUGIN_VERSION)

    // Context
    prop.propSetString(properties, ofx.kOfxImageEffectPropSupportedContexts, 0, ofx.kOfxImageEffectContextFilter)

    // Bit depths
    prop.propSetInt(properties, ofx.kOfxImageEffectPropSupportsMultipleClipDepths, 0, 0)
    prop.propSetString(properties, ofx.kOfxImageEffectPropSupportedPixelDepths, 0, ofx.kOfxBitDepthFloat)

    return ofx.kOfxStatOK
}

describe_in_context :: proc(descriptor: ofx.OfxImageEffectHandle) -> ofx.OfxStatus {
    properties: ofx.OfxPropertySetHandle

    effect.clipDefine(descriptor, ofx.kOfxImageEffectOutputClipName, &properties)
    prop.propSetString(properties, ofx.kOfxImageEffectPropSupportedComponents, 0, ofx.kOfxImageComponentRGBA)

    effect.clipDefine(descriptor, ofx.kOfxImageEffectSimpleSourceClipName, &properties)
    prop.propSetString(properties, ofx.kOfxImageEffectPropSupportedComponents, 0, ofx.kOfxImageComponentRGBA)

    return ofx.kOfxStatOK
}

create_instance :: proc() -> ofx.OfxStatus {
    return ofx.kOfxStatOK
}

destroy_instance :: proc() -> ofx.OfxStatus {
    return ofx.kOfxStatOK
}

render :: proc(instance: ofx.OfxImageEffectHandle, in_args: ofx.OfxPropertySetHandle) -> ofx.OfxStatus {
    status := ofx.kOfxStatOK

    time: ofx.OfxTime
    prop.propGetDouble(in_args, ofx.kOfxPropTime, 0, &time)

    render_bounds: ofx.OfxRectI
    prop.propGetIntN(in_args, ofx.kOfxImageEffectPropRenderWindow, 4, &render_bounds.x1)

    // Image
    out_img: ofx.OfxPropertySetHandle
    dst_row_bytes: i32
    dst_bounds: ofx.OfxRectI
    dst_ptr: rawptr
    {
        out_clip: ofx.OfxImageClipHandle
        effect.clipGetHandle(instance, ofx.kOfxImageEffectOutputClipName, &out_clip, nil)

        if effect.clipGetImage(out_clip, time, nil, &out_img) != ofx.kOfxStatOK {
            // if we were interrupted, the failed fetch is fine, just return
            // kOfxStatOK. otherwise, something weird happened
            if cast(bool)effect.abort(instance) {
                return status
            } else {
                return ofx.kOfxStatFailed
            }
        }

        prop.propGetInt(out_img, ofx.kOfxImagePropRowBytes, 0, &dst_row_bytes)
        prop.propGetIntN(out_img, ofx.kOfxImagePropBounds, 4, &dst_bounds.x1)
        prop.propGetInt(out_img, ofx.kOfxImagePropRowBytes, 0, &dst_row_bytes)
        prop.propGetPointer(out_img, ofx.kOfxImagePropData, 0, &dst_ptr)
    }

    // Image
    src_img: ofx.OfxPropertySetHandle
    src_row_bytes: i32
    src_bounds: ofx.OfxRectI
    src_ptr: rawptr
    {
        src_clip: ofx.OfxImageClipHandle
        effect.clipGetHandle(instance, ofx.kOfxImageEffectSimpleSourceClipName, &src_clip, nil)

        if effect.clipGetImage(src_clip, time, nil, &src_img) != ofx.kOfxStatOK {
            if cast(bool)effect.abort(instance) {
                return status
            } else {
                return ofx.kOfxStatFailed
            }
        }

        prop.propGetInt(src_img, ofx.kOfxImagePropRowBytes, 0, &src_row_bytes)
        prop.propGetIntN(src_img, ofx.kOfxImagePropBounds, 4, &src_bounds.x1)
        prop.propGetInt(src_img, ofx.kOfxImagePropRowBytes, 0, &src_row_bytes)
        prop.propGetPointer(src_img, ofx.kOfxImagePropData, 0, &src_ptr)
    }

    pixel_address :: proc(
        start_address: rawptr,
        bounds: ofx.OfxRectI,
        row_bytes: i32,
        x, y: i32,
    ) -> ^ofx.OfxRGBAColourF {
        if x < bounds.x1 || x >= bounds.x2 || y < bounds.y1 || y >= bounds.y2 {
            return nil
        }

        y_offset := y - bounds.y1
        x_offset := x - bounds.x1

        bytes := cast([^]byte)start_address
        row_start := cast([^]ofx.OfxRGBAColourF)(&bytes[y_offset * row_bytes])

        return &row_start[x_offset]
    }

    for y: i32 = render_bounds.y1; y < render_bounds.y2; y += 1 {
        if cast(bool)effect.abort(instance) {
            break
        }

        for x: i32 = render_bounds.x1; x < render_bounds.x2; x += 1 {
            src_pix := pixel_address(src_ptr, src_bounds, src_row_bytes, x, y)
            dst_pix := pixel_address(dst_ptr, dst_bounds, dst_row_bytes, x, y)

            if src_pix != nil {
                dst_pix.r = 1.0 - src_pix.r
                dst_pix.g = 1.0 - src_pix.g
                dst_pix.b = 1.0 - src_pix.b
                dst_pix.a = src_pix.a
            } else {
                dst_pix.r = 0.0
                dst_pix.g = 0.0
                dst_pix.b = 0.0
                dst_pix.a = 0.0
            }
        }
    }

    if src_img != nil {
        effect.clipReleaseImage(src_img)
    }

    if out_img != nil {
        effect.clipReleaseImage(out_img)
    }

    return status
}

plugin_main :: proc(
    action: cstring,
    handle: rawptr,
    in_args: ofx.OfxPropertySetHandle,
    out_args: ofx.OfxPropertySetHandle
) -> ofx.OfxStatus {
    descriptor := ofx.OfxImageEffectHandle(handle);

    switch action {
    case ofx.kOfxActionLoad:
        return load()
    case ofx.kOfxActionUnload:
        return unload()
    case ofx.kOfxActionDescribe:
        return describe(descriptor)
    case ofx.kOfxImageEffectActionDescribeInContext:
        return describe_in_context(descriptor)
    case ofx.kOfxActionCreateInstance:
        return create_instance()
    case ofx.kOfxActionDestroyInstance:
        return destroy_instance()
    case ofx.kOfxImageEffectActionRender:
        return render(descriptor, in_args)
    }

    return ofx.kOfxStatReplyDefault
}

set_host :: proc(_host: ^ofx.OfxHost) {
    host = _host
}

PLUGIN := ofx.OfxPlugin{
    pluginApi               = ofx.kOfxImageEffectPluginApi,
    apiVersion              = 1,
    pluginIdentifier        = "ExampleOFX.Invert",
    pluginVersionMajor      = 0,
    pluginVersionMinor      = 1,
    setHost                 = set_host,
    mainEntry               = plugin_main
}

@export
OfxGetPlugin :: proc(nth: i32) -> ^ofx.OfxPlugin {
    if (nth == 0) {
        return &PLUGIN
    }
    return nil
}

@export
OfxGetNumberOfPlugins :: proc() -> i32 {
    return 1
}
