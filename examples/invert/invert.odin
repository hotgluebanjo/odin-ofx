package invert

import "base:runtime"

import "../../ofx"

PLUGIN_GROUP       :: "Odin Example OFX Plugins"
PLUGIN_NAME        :: "Invert"
PLUGIN_VERSION     :: "0.1.0"
PLUGIN_DESCRIPTION :: "Inverts via 100% - pixel."

host:   ^ofx.Host
effect: ^ofx.ImageEffectSuiteV1
prop:   ^ofx.PropertySuiteV1

Image :: struct {
    properties: ofx.PropertySetHandle,
    ptr: rawptr,
    bounds: ofx.RectI,
    row_bytes: i32,
}

get_image :: proc(
    instance: ofx.ImageEffectHandle,
    clip: ofx.ImageClipHandle,
    time: ofx.Time,
) -> (img: Image, stat: ofx.Status) {
    stat = effect.clipGetImage(clip, time, nil, &img.properties)
    if stat != ofx.StatOK {
        return img, stat
    }

    prop.propGetPointer(img.properties, ofx.ImagePropData, 0, &img.ptr)
    prop.propGetIntN(img.properties, ofx.ImagePropBounds, 4, &img.bounds.x1)
    prop.propGetInt(img.properties, ofx.ImagePropRowBytes, 0, &img.row_bytes)

    return img, ofx.StatOK
}

release_image :: proc(img: Image) {
    if img.properties != nil {
        effect.clipReleaseImage(img.properties)
    }
}

get_pixel_ptr :: proc(img: Image, x, y: i32) -> ^ofx.RGBAColourF {
    if x < img.bounds.x1 || x >= img.bounds.x2 || y < img.bounds.y1 || y >= img.bounds.y2 {
        return nil
    }

    y_offset := y - img.bounds.y1
    x_offset := x - img.bounds.x1

    bytes := cast([^]byte)img.ptr
    row_start := cast([^]ofx.RGBAColourF)&bytes[y_offset * img.row_bytes]

    return &row_start[x_offset]
}

load :: proc() -> ofx.Status {
    if host == nil {
        return ofx.StatErrMissingHostFeature
    }

    effect = cast(^ofx.ImageEffectSuiteV1)host.fetchSuite(host.host, ofx.ImageEffectSuite, 1)
    prop = cast(^ofx.PropertySuiteV1)host.fetchSuite(host.host, ofx.PropertySuite, 1)

    if effect == nil || prop == nil {
        return ofx.StatErrMissingHostFeature
    }

    return ofx.StatOK
}

describe :: proc(descriptor: ofx.ImageEffectHandle) -> ofx.Status {
    properties: ofx.PropertySetHandle
    effect.getPropertySet(descriptor, &properties)

    // Labels
    prop.propSetString(properties, ofx.PropLabel, 0, PLUGIN_NAME)
    prop.propSetString(properties, ofx.ImageEffectPluginPropGrouping, 0, PLUGIN_GROUP)
    prop.propSetString(properties, ofx.PropPluginDescription, 0, PLUGIN_DESCRIPTION)
    prop.propSetString(properties, ofx.PropVersionLabel, 0, PLUGIN_VERSION)

    // Context
    prop.propSetString(properties, ofx.ImageEffectPropSupportedContexts, 0, ofx.ImageEffectContextFilter)

    // Bit depths
    prop.propSetInt(properties, ofx.ImageEffectPropSupportsMultipleClipDepths, 0, 0)
    prop.propSetString(properties, ofx.ImageEffectPropSupportedPixelDepths, 0, ofx.BitDepthFloat)

    return ofx.StatOK
}

describe_in_context :: proc(descriptor: ofx.ImageEffectHandle) -> ofx.Status {
    properties: ofx.PropertySetHandle

    effect.clipDefine(descriptor, ofx.ImageEffectSimpleSourceClipName, &properties)
    prop.propSetString(properties, ofx.ImageEffectPropSupportedComponents, 0, ofx.ImageComponentRGBA)

    effect.clipDefine(descriptor, ofx.ImageEffectOutputClipName, &properties)
    prop.propSetString(properties, ofx.ImageEffectPropSupportedComponents, 0, ofx.ImageComponentRGBA)

    return ofx.StatOK
}

render :: proc(instance: ofx.ImageEffectHandle, in_args: ofx.PropertySetHandle) -> ofx.Status {
    time: ofx.Time
    prop.propGetDouble(in_args, ofx.PropTime, 0, &time)

    render_bounds: ofx.RectI
    prop.propGetIntN(in_args, ofx.ImageEffectPropRenderWindow, 4, &render_bounds.x1)

    src_clip, dst_clip: ofx.ImageClipHandle
    effect.clipGetHandle(instance, ofx.ImageEffectSimpleSourceClipName, &src_clip, nil)
    effect.clipGetHandle(instance, ofx.ImageEffectOutputClipName, &dst_clip, nil)

    src, src_stat := get_image(instance, src_clip, time)
    if src_stat != ofx.StatOK {
        return src_stat
    }
    defer release_image(src)

    dst, dst_stat := get_image(instance, dst_clip, time)
    if dst_stat != ofx.StatOK {
        return dst_stat
    }
    defer release_image(dst)

    for y in render_bounds.y1..<render_bounds.y2 {
        if bool(effect.abort(instance)) {
            break
        }
        for x in render_bounds.x1..<render_bounds.x2 {
            input := get_pixel_ptr(src, x, y)
            output := get_pixel_ptr(dst, x, y)

            if input != nil {
                output.rgb = 1.0 - input.rgb
                output.a = input.a
            } else {
                output^ = {0.0, 0.0, 0.0, 0.0}
            }
        }
    }

    return ofx.StatOK
}

plugin_main :: proc "c" (
    action: cstring,
    handle: rawptr,
    in_args: ofx.PropertySetHandle,
    out_args: ofx.PropertySetHandle
) -> ofx.Status {
    context = runtime.default_context()

    effect_handle := ofx.ImageEffectHandle(handle)

    switch action {
    case ofx.ActionLoad:
        return load()
    case ofx.ActionUnload, ofx.ActionCreateInstance, ofx.ActionDestroyInstance:
        return ofx.StatOK
    case ofx.ActionDescribe:
        return describe(effect_handle)
    case ofx.ImageEffectActionDescribeInContext:
        return describe_in_context(effect_handle)
    case ofx.ImageEffectActionRender:
        return render(effect_handle, in_args)
    }

    return ofx.StatReplyDefault
}

set_host :: proc "c" (_host: ^ofx.Host) {
    host = _host
}

PLUGIN := ofx.Plugin{
    pluginApi               = ofx.ImageEffectPluginApi,
    apiVersion              = 1,
    pluginIdentifier        = "ExampleOFX.Invert",
    pluginVersionMajor      = 0,
    pluginVersionMinor      = 1,
    setHost                 = set_host,
    mainEntry               = plugin_main
}

@export
OfxGetPlugin :: proc "c" (nth: i32) -> ^ofx.Plugin {
    if (nth == 0) {
        return &PLUGIN
    }
    return nil
}

@export
OfxGetNumberOfPlugins :: proc "c" () -> i32 {
    return 1
}
