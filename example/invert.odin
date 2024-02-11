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
    prop.propSetString(properties, ofx.kOfxPropLabel, 0, PLUGIN_NAME);
    prop.propSetString(properties, ofx.kOfxImageEffectPluginPropGrouping, 0, PLUGIN_GROUP);
    prop.propSetString(properties, ofx.kOfxPropPluginDescription, 0, PLUGIN_DESCRIPTION);
    prop.propSetString(properties, ofx.kOfxPropVersionLabel, 0, PLUGIN_VERSION);

    // Context
    prop.propSetString(properties, ofx.kOfxImageEffectPropSupportedContexts, 0, ofx.kOfxImageEffectContextFilter);

    // Bit depths
    prop.propSetInt(properties, ofx.kOfxImageEffectPropSupportsMultipleClipDepths, 0, 0);
    prop.propSetString(properties, ofx.kOfxImageEffectPropSupportedPixelDepths, 0, ofx.kOfxBitDepthFloat);

    return ofx.kOfxStatOK;
}

describe_in_context :: proc(descriptor: ofx.OfxImageEffectHandle) -> ofx.OfxStatus {
    properties: ofx.OfxPropertySetHandle

    effect.clipDefine(descriptor, ofx.kOfxImageEffectOutputClipName, &properties);
    prop.propSetString(properties, ofx.kOfxImageEffectPropSupportedComponents, 0, ofx.kOfxImageComponentRGBA);

    effect.clipDefine(descriptor, ofx.kOfxImageEffectSimpleSourceClipName, &properties);
    prop.propSetString(properties, ofx.kOfxImageEffectPropSupportedComponents, 0, ofx.kOfxImageComponentRGBA);

    return ofx.kOfxStatOK;
}

create_instance :: proc() -> ofx.OfxStatus {
    return ofx.kOfxStatOK
}

destroy_instance :: proc() -> ofx.OfxStatus {
    return ofx.kOfxStatOK
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
        return load();
    case ofx.kOfxActionUnload:
        return unload();
    case ofx.kOfxActionDescribe:
        return describe(descriptor);
    case ofx.kOfxImageEffectActionDescribeInContext:
        return describe_in_context(descriptor);
    case ofx.kOfxActionCreateInstance:
        return create_instance();
    case ofx.kOfxActionDestroyInstance:
        return destroy_instance();
    case ofx.kOfxImageEffectActionRender:
        // return render(descriptor, in_args);
        return ofx.kOfxStatOK;
    }

    return ofx.kOfxStatReplyDefault;
}

set_host :: proc(_host: ^ofx.OfxHost) {
    host = _host;
}

PLUGIN := ofx.OfxPlugin{
    pluginApi               = ofx.kOfxImageEffectPluginApi,
    apiVersion              = 1,
    pluginIdentifier        = "ExampleOFX.Invert",
    pluginVersionMajor      = 0,
    pluginVersionMinor      = 1,
    setHost                 = set_host,
    mainEntry               = plugin_main
};

@export
OfxGetPlugin :: proc(nth: i32) -> ^ofx.OfxPlugin {
    if (nth == 0) {
        return &PLUGIN;
    }
    return nil;
}

@export
OfxGetNumberOfPlugins :: proc() -> i32 {
    return 1;
}
