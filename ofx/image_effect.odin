package ofx

kOfxImageEffectPluginApi : cstring : "OfxImageEffectPluginAPI"
kOfxImageEffectPluginApiVersion : i32 : 1

OfxImageEffectStruct :: struct {}
OfxImageEffectHandle :: ^OfxImageEffectStruct;

OfxImageClipStruct :: struct {}
OfxImageClipHandle :: ^OfxImageClipStruct

OfxImageMemoryStruct :: struct {}
OfxImageMemoryHandle :: ^OfxImageMemoryStruct

kOfxImageComponentNone                              : cstring : "OfxImageComponentNone"
kOfxImageComponentRGBA                              : cstring : "OfxImageComponentRGBA"
kOfxImageComponentRGB                               : cstring : "OfxImageComponentRGB"
kOfxImageComponentAlpha                             : cstring : "OfxImageComponentAlpha"
kOfxImageEffectContextGenerator                     : cstring : "OfxImageEffectContextGenerator"
kOfxImageEffectContextFilter                        : cstring : "OfxImageEffectContextFilter"
kOfxImageEffectContextTransition                    : cstring : "OfxImageEffectContextTransition"
kOfxImageEffectContextPaint                         : cstring : "OfxImageEffectContextPaint"
kOfxImageEffectContextGeneral                       : cstring : "OfxImageEffectContextGeneral"
kOfxImageEffectContextRetimer                       : cstring : "OfxImageEffectContextRetimer"
kOfxTypeImageEffectHost                             : cstring : "OfxTypeImageEffectHost"
kOfxTypeImageEffect                                 : cstring : "OfxTypeImageEffect"
kOfxTypeImageEffectInstance                         : cstring : "OfxTypeImageEffectInstance"
kOfxTypeClip                                        : cstring : "OfxTypeClip"
kOfxTypeImage                                       : cstring : "OfxTypeImage"
kOfxImageEffectActionGetRegionOfDefinition          : cstring : "OfxImageEffectActionGetRegionOfDefinition"
kOfxImageEffectActionGetRegionsOfInterest           : cstring : "OfxImageEffectActionGetRegionsOfInterest"
kOfxImageEffectActionGetTimeDomain                  : cstring : "OfxImageEffectActionGetTimeDomain"
kOfxImageEffectActionGetFramesNeeded                : cstring : "OfxImageEffectActionGetFramesNeeded"
kOfxImageEffectActionGetClipPreferences             : cstring : "OfxImageEffectActionGetClipPreferences"
kOfxImageEffectActionIsIdentity                     : cstring : "OfxImageEffectActionIsIdentity"
kOfxImageEffectActionRender                         : cstring : "OfxImageEffectActionRender"
kOfxImageEffectActionBeginSequenceRender            : cstring : "OfxImageEffectActionBeginSequenceRender"
kOfxImageEffectActionEndSequenceRender              : cstring : "OfxImageEffectActionEndSequenceRender"
kOfxImageEffectActionDescribeInContext              : cstring : "OfxImageEffectActionDescribeInContext"
kOfxImageEffectPropSupportedContexts                : cstring : "OfxImageEffectPropSupportedContexts"
kOfxImageEffectPropPluginHandle                     : cstring : "OfxImageEffectPropPluginHandle"
kOfxImageEffectHostPropIsBackground                 : cstring : "OfxImageEffectHostPropIsBackground"
kOfxImageEffectPluginPropSingleInstance             : cstring : "OfxImageEffectPluginPropSingleInstance"
kOfxImageEffectPluginRenderThreadSafety             : cstring : "OfxImageEffectPluginRenderThreadSafety"
kOfxImageEffectRenderUnsafe                         : cstring : "OfxImageEffectRenderUnsafe"
kOfxImageEffectRenderInstanceSafe                   : cstring : "OfxImageEffectRenderInstanceSafe"
kOfxImageEffectRenderFullySafe                      : cstring : "OfxImageEffectRenderFullySafe"
kOfxImageEffectPluginPropHostFrameThreading         : cstring : "OfxImageEffectPluginPropHostFrameThreading"
kOfxImageEffectPropSupportsMultipleClipDepths       : cstring : "OfxImageEffectPropMultipleClipDepths"
kOfxImageEffectPropSupportsMultipleClipPARs         : cstring : "OfxImageEffectPropSupportsMultipleClipPARs"
kOfxImageEffectPropClipPreferencesSlaveParam        : cstring : "OfxImageEffectPropClipPreferencesSlaveParam"
kOfxImageEffectPropSetableFrameRate                 : cstring : "OfxImageEffectPropSetableFrameRate"
kOfxImageEffectPropSetableFielding                  : cstring : "OfxImageEffectPropSetableFielding"
kOfxImageEffectInstancePropSequentialRender         : cstring : "OfxImageEffectInstancePropSequentialRender"
kOfxImageEffectPropSequentialRenderStatus           : cstring : "OfxImageEffectPropSequentialRenderStatus"
kOfxHostNativeOriginBottomLeft                      : cstring : "kOfxImageEffectHostPropNativeOriginBottomLeft"
kOfxHostNativeOriginTopLeft                         : cstring : "kOfxImageEffectHostPropNativeOriginTopLeft"
kOfxHostNativeOriginCenter                          : cstring : "kOfxImageEffectHostPropNativeOriginCenter"
kOfxImageEffectHostPropNativeOrigin                 : cstring : "OfxImageEffectHostPropNativeOrigin"
kOfxImageEffectPropInteractiveRenderStatus          : cstring : "OfxImageEffectPropInteractiveRenderStatus"
kOfxImageEffectPluginPropGrouping                   : cstring : "OfxImageEffectPluginPropGrouping"
kOfxImageEffectPropSupportsOverlays                 : cstring : "OfxImageEffectPropSupportsOverlays"
kOfxImageEffectPluginPropOverlayInteractV1          : cstring : "OfxImageEffectPluginPropOverlayInteractV1"
kOfxImageEffectPropSupportsMultiResolution          : cstring : "OfxImageEffectPropSupportsMultiResolution"
kOfxImageEffectPropSupportsTiles                    : cstring : "OfxImageEffectPropSupportsTiles"
kOfxImageEffectPropTemporalClipAccess               : cstring : "OfxImageEffectPropTemporalClipAccess"
kOfxImageEffectPropContext                          : cstring : "OfxImageEffectPropContext"
kOfxImageEffectPropPixelDepth                       : cstring : "OfxImageEffectPropPixelDepth"
kOfxImageEffectPropComponents                       : cstring : "OfxImageEffectPropComponents"
kOfxImagePropUniqueIdentifier                       : cstring : "OfxImagePropUniqueIdentifier"
kOfxImageClipPropContinuousSamples                  : cstring : "OfxImageClipPropContinuousSamples"
kOfxImageClipPropUnmappedPixelDepth                 : cstring : "OfxImageClipPropUnmappedPixelDepth"
kOfxImageClipPropUnmappedComponents                 : cstring : "OfxImageClipPropUnmappedComponents"
kOfxImageEffectPropPreMultiplication                : cstring : "OfxImageEffectPropPreMultiplication"
kOfxImageOpaque                                     : cstring : "OfxImageOpaque"
kOfxImagePreMultiplied                              : cstring : "OfxImageAlphaPremultiplied"
kOfxImageUnPreMultiplied                            : cstring : "OfxImageAlphaUnPremultiplied"
kOfxImageEffectPropSupportedPixelDepths             : cstring : "OfxImageEffectPropSupportedPixelDepths"
kOfxImageEffectPropSupportedComponents              : cstring : "OfxImageEffectPropSupportedComponents"
kOfxImageClipPropOptional                           : cstring : "OfxImageClipPropOptional"
kOfxImageClipPropIsMask                             : cstring : "OfxImageClipPropIsMask"
kOfxImagePropPixelAspectRatio                       : cstring : "OfxImagePropPixelAspectRatio"
kOfxImageEffectPropFrameRate                        : cstring : "OfxImageEffectPropFrameRate"
kOfxImageEffectPropUnmappedFrameRate                : cstring : "OfxImageEffectPropUnmappedFrameRate"
kOfxImageEffectPropFrameStep                        : cstring : "OfxImageEffectPropFrameStep"
kOfxImageEffectPropFrameRange                       : cstring : "OfxImageEffectPropFrameRange"
kOfxImageEffectPropUnmappedFrameRange               : cstring : "OfxImageEffectPropUnmappedFrameRange"
kOfxImageClipPropConnected                          : cstring : "OfxImageClipPropConnected"
kOfxImageEffectFrameVarying                         : cstring : "OfxImageEffectFrameVarying"
kOfxImageEffectPropRenderScale                      : cstring : "OfxImageEffectPropRenderScale"
kOfxImageEffectPropRenderQualityDraft               : cstring : "OfxImageEffectPropRenderQualityDraft"
kOfxImageEffectPropProjectExtent                    : cstring : "OfxImageEffectPropProjectExtent"
kOfxImageEffectPropProjectSize                      : cstring : "OfxImageEffectPropProjectSize"
kOfxImageEffectPropProjectOffset                    : cstring : "OfxImageEffectPropProjectOffset"
kOfxImageEffectPropProjectPixelAspectRatio          : cstring : "OfxImageEffectPropPixelAspectRatio"
kOfxImageEffectInstancePropEffectDuration           : cstring : "OfxImageEffectInstancePropEffectDuration"
kOfxImageClipPropFieldOrder                         : cstring : "OfxImageClipPropFieldOrder"
kOfxImagePropData                                   : cstring : "OfxImagePropData"
kOfxImagePropBounds                                 : cstring : "OfxImagePropBounds"
kOfxImagePropRegionOfDefinition                     : cstring : "OfxImagePropRegionOfDefinition"
kOfxImagePropRowBytes                               : cstring : "OfxImagePropRowBytes"
kOfxImagePropField                                  : cstring : "OfxImagePropField"
kOfxImageEffectPluginPropFieldRenderTwiceAlways     : cstring : "OfxImageEffectPluginPropFieldRenderTwiceAlways"
kOfxImageClipPropFieldExtraction                    : cstring : "OfxImageClipPropFieldExtraction"
kOfxImageEffectPropFieldToRender                    : cstring : "OfxImageEffectPropFieldToRender"
kOfxImageEffectPropRegionOfDefinition               : cstring : "OfxImageEffectPropRegionOfDefinition"
kOfxImageEffectPropRegionOfInterest                 : cstring : "OfxImageEffectPropRegionOfInterest"
kOfxImageEffectPropRenderWindow                     : cstring : "OfxImageEffectPropRenderWindow"
kOfxImageFieldNone                                  : cstring : "OfxFieldNone"
kOfxImageFieldLower                                 : cstring : "OfxFieldLower"
kOfxImageFieldUpper                                 : cstring : "OfxFieldUpper"
kOfxImageFieldBoth                                  : cstring : "OfxFieldBoth"
kOfxImageFieldSingle                                : cstring : "OfxFieldSingle"
kOfxImageFieldDoubled                               : cstring : "OfxFieldDoubled"
kOfxImageEffectOutputClipName                       : cstring : "Output"
kOfxImageEffectSimpleSourceClipName                 : cstring : "Source"
kOfxImageEffectTransitionSourceFromClipName         : cstring : "SourceFrom"
kOfxImageEffectTransitionSourceToClipName           : cstring : "SourceTo"
kOfxImageEffectTransitionParamName                  : cstring : "Transition"
kOfxImageEffectRetimerParamName                     : cstring : "SourceTime"
kOfxImageEffectSuite                                : cstring : "OfxImageEffectSuite"

OfxImageEffectSuiteV1 :: struct {
    getPropertySet:             proc(imageEffect: OfxImageEffectHandle, propHandle: ^OfxPropertySetHandle) -> OfxStatus,
    getParamSet:                proc(imageEffect: OfxImageEffectHandle, paramSet: ^OfxParamSetHandle) -> OfxStatus,
    clipDefine:                 proc(imageEffect: OfxImageEffectHandle, name: cstring, propertySet: ^OfxPropertySetHandle) -> OfxStatus,
    clipGetHandle:              proc(imageEffect: OfxImageEffectHandle, name: cstring, clip: ^OfxImageClipHandle, propertySet: ^OfxPropertySetHandle) -> OfxStatus,
    clipGetPropertySet:         proc(clip: OfxImageClipHandle, propHandle: ^OfxPropertySetHandle) -> OfxStatus,
    clipGetImage:               proc(clip: OfxImageClipHandle, time: OfxTime, region: ^OfxRectD, imageHandle: ^OfxPropertySetHandle) -> OfxStatus,
    clipReleaseImage:           proc(imageHandle: OfxPropertySetHandle) -> OfxStatus,
    clipGetRegionOfDefinition:  proc(clip: OfxImageClipHandle, time: OfxTime, bounds: ^OfxRectD) -> OfxStatus,
    abort:                      proc(imageEffect: OfxImageEffectHandle) -> i32,
    imageMemoryAlloc:           proc(instanceHandle: OfxImageEffectHandle, nBytes: uint, memoryHandle: ^OfxImageMemoryHandle) -> OfxStatus,
    imageMemoryFree:            proc(memoryHandle: OfxImageMemoryHandle) -> OfxStatus,
    imageMemoryLock:            proc(memoryHandle: OfxImageMemoryHandle, returnedPtr: ^rawptr) -> OfxStatus,
    imageMemoryUnlock:          proc(memoryHandle: OfxImageMemoryHandle) -> OfxStatus,
}

kOfxStatErrImageFormat : i32 : 1000
