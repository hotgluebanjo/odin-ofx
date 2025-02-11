// Core OpenFX API.
package ofx

import "core:c"

// NOTE: There is a `k` prefix in some string constants. This is not an error.

Status :: i32

Time :: f64

RGBAColourB :: [4]byte
RGBAColourS :: [4]u16
RGBAColourF :: [4]f32
RGBAColourD :: [4]f64

RGBColourB :: [3]byte
RGBColourS :: [3]u16
RGBColourF :: [3]f32
RGBColourD :: [3]f64

PointI :: [2]i32
PointD :: [2]f64

RangeI :: struct {
    min, max: i32,
}

RangeD :: struct {
    min, max: f64,
}

RectI :: struct {
    x1, y1, x2, y2: i32,
}

RectD :: struct {
    x1, y1, x2, y2: f64,
}

YUVAColourB :: struct {
    y, u, v, a: byte,
}

YUVAColourS :: struct {
    y, u, v, a: u16,
}

YUVAColourF :: struct {
    y, u, v, a: f32,
}

PropertySetHandle :: distinct rawptr
DrawContextHandle :: distinct rawptr
ImageEffectHandle :: distinct rawptr
ImageClipHandle   :: distinct rawptr
ImageMemoryHandle :: distinct rawptr
InteractHandle    :: distinct rawptr
ParamHandle       :: distinct rawptr
ParamSetHandle    :: distinct rawptr
MutexHandle       :: distinct rawptr

PluginEntryPoint        :: #type proc "c" (action: cstring, handle: rawptr, inArgs: PropertySetHandle, outArgs: PropertySetHandle) -> Status
ThreadFunctionV1        :: #type proc "c" (threadIndex: u32, threadMax: u32, customArg: rawptr)
CustomParamInterpFuncV1 :: #type proc "c" (instance: ParamSetHandle, inArgs: PropertySetHandle, outArgs: PropertySetHandle) -> Status

Host :: struct {
    host: PropertySetHandle,
    fetchSuite: proc "c" (host: PropertySetHandle, suiteName: cstring, suiteVersion: i32) -> rawptr,
}

Plugin :: struct {
    pluginApi: cstring,
    apiVersion: i32,
    pluginIdentifier: cstring,
    pluginVersionMajor: u32,
    pluginVersionMinor: u32,
    setHost: proc "c" (host: ^Host),
    mainEntry: PluginEntryPoint,
}

DialogSuiteV1 :: struct {
    RequestDialog: proc "c" (user_data: rawptr) -> Status,
    NotifyRedrawPending: proc "c" () -> Status,
}

DrawSuiteV1 :: struct {
    getColour:      proc "c" (ctx: DrawContextHandle, std_colour: StandardColour, colour: ^RGBAColourF) -> Status,
    setColour:      proc "c" (ctx: DrawContextHandle, colour: ^RGBAColourF) -> Status,

    setLineWidth:   proc "c" (ctx: DrawContextHandle, width: f32) -> Status,
    setLineStipple: proc "c" (ctx: DrawContextHandle, pattern: DrawLineStipplePattern) -> Status,

    draw:           proc "c" (ctx: DrawContextHandle, primitive: DrawPrimitive, points: ^PointD, point_count: i32) -> Status,
    drawText:       proc "c" (ctx: DrawContextHandle, text: cstring, pos: ^PointD, alignment: i32) -> Status,
}

ImageEffectOpenGLRenderSuiteV1 :: struct {
    clipLoadTexture: proc "c" (clip: ImageClipHandle, time: Time, format: cstring, region: ^RectD, textureHandle: ^PropertySetHandle) -> Status,
    clipFreeTexture: proc "c" (textureHandle: PropertySetHandle) -> Status,
    flushResources: proc "c" () -> Status,
}

ImageEffectSuiteV1 :: struct {
    getPropertySet:            proc "c" (imageEffect: ImageEffectHandle, propHandle: ^PropertySetHandle) -> Status,
    getParamSet:               proc "c" (imageEffect: ImageEffectHandle, paramSet: ^ParamSetHandle) -> Status,

    clipDefine:                proc "c" (imageEffect: ImageEffectHandle, name: cstring, propertySet: ^PropertySetHandle) -> Status,
    clipGetHandle:             proc "c" (imageEffect: ImageEffectHandle, name: cstring, clip: ^ImageClipHandle, propertySet: ^PropertySetHandle) -> Status,
    clipGetPropertySet:        proc "c" (clip: ImageClipHandle, propHandle: ^PropertySetHandle) -> Status,
    clipGetImage:              proc "c" (clip: ImageClipHandle, time: Time, region: ^RectD, imageHandle: ^PropertySetHandle) -> Status,
    clipReleaseImage:          proc "c" (imageHandle: PropertySetHandle) -> Status,
    clipGetRegionOfDefinition: proc "c" (clip: ImageClipHandle, time: Time, bounds: ^RectD) -> Status,

    abort:                     proc "c" (imageEffect: ImageEffectHandle) -> i32,

    imageMemoryAlloc:          proc "c" (instanceHandle: ImageEffectHandle, nBytes: uint, memoryHandle: ^ImageMemoryHandle) -> Status,
    imageMemoryFree:           proc "c" (memoryHandle: ImageMemoryHandle) -> Status,
    imageMemoryLock:           proc "c" (memoryHandle: ImageMemoryHandle, returnedPtr: ^rawptr) -> Status,
    imageMemoryUnlock:         proc "c" (memoryHandle: ImageMemoryHandle) -> Status,
}

InteractSuiteV1 :: struct {
    interactSwapBuffers:    proc "c" (interactInstance: InteractHandle) -> Status,
    interactRedraw:         proc "c" (interactInstance: InteractHandle) -> Status,
    interactGetPropertySet: proc "c" (interactInstance: InteractHandle, property: ^PropertySetHandle) -> Status,
}

MemorySuiteV1 :: struct {
    memoryAlloc: proc "c" (handle: rawptr, nBytes: uint, allocatedData: ^rawptr) -> Status,
    memoryFree: proc "c" (allocatedData: rawptr) -> Status,
}

MessageSuiteV1 :: struct {
    message: proc "c" (handle: rawptr, messageType: cstring, messageId: cstring, format: cstring, #c_vararg args: ..any) -> Status,
}

MessageSuiteV2 :: struct {
    message:                proc "c" (handle: rawptr, messageType: cstring, messageId: cstring, format: cstring, #c_vararg args: ..any) -> Status,
    setPersistentMessage:   proc "c" (handle: rawptr, messageType: cstring, messageId: cstring, format: cstring, #c_vararg args: ..any) -> Status,
    clearPersistentMessage: proc "c" (handle: rawptr) -> Status,
}

MultiThreadSuiteV1 :: struct {
    multiThread: proc "c" (func: ThreadFunctionV1, nThreads: u32, customArg: rawptr) -> Status,
    multiThreadNumCPUs: proc "c" (nCPUs: ^u32) -> Status,

    multiThreadIndex: proc "c" (threadIndex: ^u32) -> Status,
    multiThreadIsSpawnedThread: proc "c" () -> i32,

    mutexCreate: proc "c" (mutex: ^MutexHandle, lockCount: i32) -> Status,
    mutexDestroy: proc "c" (mutex: MutexHandle) -> Status,
    mutexLock:    proc "c" (mutex: MutexHandle) -> Status,
    mutexUnLock:  proc "c" (mutex: MutexHandle) -> Status,
    mutexTryLock: proc "c" (mutex: MutexHandle) -> Status,
}

ParameterSuiteV1 :: struct {
    paramDefine:            proc "c" (paramSet: ParamSetHandle, paramType: cstring, name: cstring, propertySet: ^PropertySetHandle) -> Status,
    paramGetHandle:         proc "c" (paramSet: ParamSetHandle, name: cstring, param: ^ParamHandle, propertySet: ^PropertySetHandle) -> Status,
    paramSetGetPropertySet: proc "c" (paramSet: ParamSetHandle, propHandle: ^PropertySetHandle) -> Status,

    paramGetPropertySet:    proc "c" (param: ParamHandle, propHandle: ^PropertySetHandle) -> Status,

    paramGetValue:          proc "c" (paramHandle: ParamHandle, #c_vararg args: ..any) -> Status,
    paramGetValueAtTime:    proc "c" (paramHandle: ParamHandle, time: Time, #c_vararg args: ..any) -> Status,
    paramGetDerivative:     proc "c" (paramHandle: ParamHandle, time: Time, #c_vararg args: ..any) -> Status,
    paramGetIntegral:       proc "c" (paramHandle: ParamHandle, time1: Time, time2: Time, #c_vararg args: ..any) -> Status,

    paramSetValue:          proc "c" (paramHandle: ParamHandle, #c_vararg args: ..any) -> Status,
    paramSetValueAtTime:    proc "c" (paramHandle: ParamHandle, time: Time, #c_vararg args: ..any) -> Status,

    paramGetNumKeys:        proc "c" (paramHandle: ParamHandle, numberOfKeys: ^u32) -> Status,
    paramGetKeyTime:        proc "c" (paramHandle: ParamHandle, nthKey: u32, time: ^Time) -> Status,
    paramGetKeyIndex:       proc "c" (paramHandle: ParamHandle, time: Time, direction: i32, index: ^i32) -> Status,

    paramDeleteKey:         proc "c" (paramHandle: ParamHandle, time: Time) -> Status,
    paramDeleteAllKeys:     proc "c" (paramHandle: ParamHandle) -> Status,

    paramCopy:              proc "c" (paramTo: ParamHandle, paramFrom: ParamHandle, dstOffset: Time, frameRange: ^RangeD) -> Status,

    paramEditBegin:         proc "c" (paramSet: ParamSetHandle, name: cstring) -> Status,
    paramEditEnd:           proc "c" (paramSet: ParamSetHandle) -> Status,
}

ParametricParameterSuiteV1 :: struct {
    parametricParamGetValue:               proc "c" (param: ParamHandle, curveIndex: i32, time: Time, parametricPosition: f64, returnValue: ^f64) -> Status,
    parametricParamGetNControlPoints:      proc "c" (param: ParamHandle, curveIndex: i32, time: f64, returnValue: ^i32) -> Status,
    parametricParamGetNthControlPoint:     proc "c" (param: ParamHandle, curveIndex: i32, time: f64, nthCtl: i32, key: ^f64, value: ^f64) -> Status,

    parametricParamSetNthControlPoint:     proc "c" (param: ParamHandle, curveIndex: i32, time: f64, nthCtl: i32, key: f64, value: f64, addAnimationKey: bool) -> Status,

    parametricParamAddControlPoint:        proc "c" (param: ParamHandle, curveIndex: i32, time: f64, key: f64, value: f64, addAnimationKey: bool) -> Status,

    parametricParamDeleteControlPoint:     proc "c" (param: ParamHandle, curveIndex: i32, nthCtl: i32) -> Status,
    parametricParamDeleteAllControlPoints: proc "c" (param: ParamHandle, curveIndex: i32) -> Status,
}

ProgressSuiteV1 :: struct {
    progressStart:  proc "c" (effectInstance: rawptr, label: cstring) -> Status,
    progressUpdate: proc "c" (effectInstance: rawptr, progress: f64) -> Status,
    progressEnd:    proc "c" (effectInstance: rawptr) -> Status,
}

ProgressSuiteV2 :: struct {
    progressStart:  proc "c" (effectInstance: rawptr, message: cstring, messageid: cstring) -> Status,
    progressUpdate: proc "c" (effectInstance: rawptr, progress: f64) -> Status,
    progressEnd:    proc "c" (effectInstance: rawptr) -> Status,
}

PropertySuiteV1 :: struct {
    propSetPointer:   proc "c" (properties: PropertySetHandle, property: cstring, index: i32, value: rawptr) -> Status,
    propSetString:    proc "c" (properties: PropertySetHandle, property: cstring, index: i32, value: cstring) -> Status,
    propSetDouble:    proc "c" (properties: PropertySetHandle, property: cstring, index: i32, value: f64) -> Status,
    propSetInt:       proc "c" (properties: PropertySetHandle, property: cstring, index: i32, value: i32) -> Status,

    propSetPointerN:  proc "c" (properties: PropertySetHandle, property: cstring, count: i32, value: ^rawptr) -> Status,
    propSetStringN:   proc "c" (properties: PropertySetHandle, property: cstring, count: i32, value: ^cstring) -> Status,
    propSetDoubleN:   proc "c" (properties: PropertySetHandle, property: cstring, count: i32, value: ^f64) -> Status,
    propSetIntN:      proc "c" (properties: PropertySetHandle, property: cstring, count: i32, value: ^i32) -> Status,

    propGetPointer:   proc "c" (properties: PropertySetHandle, property: cstring, index: i32, value: ^rawptr) -> Status,
    propGetString:    proc "c" (properties: PropertySetHandle, property: cstring, index: i32, value: ^cstring) -> Status,
    propGetDouble:    proc "c" (properties: PropertySetHandle, property: cstring, index: i32, value: ^f64) -> Status,
    propGetInt:       proc "c" (properties: PropertySetHandle, property: cstring, index: i32, value: ^i32) -> Status,

    propGetPointerN:  proc "c" (properties: PropertySetHandle, property: cstring, count: i32, value: ^rawptr) -> Status,
    propGetStringN:   proc "c" (properties: PropertySetHandle, property: cstring, count: i32, value: ^cstring) -> Status,
    propGetDoubleN:   proc "c" (properties: PropertySetHandle, property: cstring, count: i32, value: ^f64) -> Status,
    propGetIntN:      proc "c" (properties: PropertySetHandle, property: cstring, count: i32, value: ^i32) -> Status,

    propReset:        proc "c" (properties: PropertySetHandle, property: cstring) -> Status,
    propGetDimension: proc "c" (properties: PropertySetHandle, property: cstring, count: ^i32) -> Status,
}

TimeLineSuiteV1 :: struct {
    getTime:       proc "c" (instance: rawptr, time: ^f64) -> Status,
    gotoTime:      proc "c" (instance: rawptr, time: f64) -> Status,
    getTimeBounds: proc "c" (instance: rawptr, firstTime: ^f64, lastTime: ^f64) -> Status,
}

StandardColour :: enum i32 {
    StandardColourOverlayBackground,
    StandardColourOverlayActive,
    StandardColourOverlaySelected,
    StandardColourOverlayDeselected,
    StandardColourOverlayMarqueeFG,
    StandardColourOverlayMarqueeBG,
    StandardColourOverlayText,
}

DrawLineStipplePattern :: enum i32 {
    DrawLineStipplePatternSolid,
    DrawLineStipplePatternDot,
    DrawLineStipplePatternDash,
    DrawLineStipplePatternAltDash,
    DrawLineStipplePatternDotDash,
}

DrawPrimitive :: enum i32 {
    DrawPrimitiveLines,
    DrawPrimitiveLineStrip,
    DrawPrimitiveLineLoop,
    DrawPrimitiveRectangle,
    DrawPrimitivePolygon,
    DrawPrimitiveEllipse
}

DrawTextAlignment :: enum i32 {
    DrawTextAlignmentLeft     = 0x0001,
    DrawTextAlignmentRight    = 0x0002,
    DrawTextAlignmentTop      = 0x0004,
    DrawTextAlignmentBottom   = 0x0008,
    DrawTextAlignmentBaseline = 0x0010,
    DrawTextAlignmentCenterH  = (DrawTextAlignmentLeft | DrawTextAlignmentRight),
    DrawTextAlignmentCenterV  = (DrawTextAlignmentTop | DrawTextAlignmentBaseline),
}

FlagInfiniteMax :: c.INT32_MAX
FlagInfiniteMin :: c.INT32_MIN

StatOK                    : i32 : 0
StatFailed                : i32 : 1
StatErrFatal              : i32 : 2
StatErrUnknown            : i32 : 3
StatErrMissingHostFeature : i32 : 4
StatErrUnsupported        : i32 : 5
StatErrExists             : i32 : 6
StatErrFormat             : i32 : 7
StatErrMemory             : i32 : 8
StatErrBadHandle          : i32 : 9
StatErrBadIndex           : i32 : 10
StatErrValue              : i32 : 11
StatReplyYes              : i32 : 12
StatReplyNo               : i32 : 13
StatReplyDefault          : i32 : 14
StatErrImageFormat        : i32 : 1000
StatGPUOutOfMemory        : i32 : 1001
StatGLOutOfMemory         : i32 : 1001
StatGPURenderFailed       : i32 : 1002
StatGLRenderFailed        : i32 : 1002

DialogSuite                                     : cstring : "OfxDialogSuite"
DrawSuite                                       : cstring : "OfxDrawSuite"
InteractSuite                                   : cstring : "OfxInteractSuite"
MemorySuite                                     : cstring : "OfxMemorySuite"
MessageSuite                                    : cstring : "OfxMessageSuite"
MultiThreadSuite                                : cstring : "OfxMultiThreadSuite"
ProgressSuite                                   : cstring : "OfxProgressSuite"
PropertySuite                                   : cstring : "OfxPropertySuite"
TimeLineSuite                                   : cstring : "OfxTimeLineSuite"
ParameterSuite                                  : cstring : "OfxParameterSuite"
ParametricParameterSuite                        : cstring : "OfxParametricParameterSuite"
OpenGLRenderSuite                               : cstring : "OfxImageEffectOpenGLRenderSuite"
ImageEffectSuite                                : cstring : "OfxImageEffectSuite"

PropAPIVersion                                  : cstring : "OfxPropAPIVersion"
PropTime                                        : cstring : "OfxPropTime"
PropIsInteractive                               : cstring : "OfxPropIsInteractive"
PropInstanceData                                : cstring : "OfxPropInstanceData"
PropType                                        : cstring : "OfxPropType"
PropName                                        : cstring : "OfxPropName"
PropVersion                                     : cstring : "OfxPropVersion"
PropVersionLabel                                : cstring : "OfxPropVersionLabel"
PropPluginDescription                           : cstring : "OfxPropPluginDescription"
PropLabel                                       : cstring : "OfxPropLabel"
PropIcon                                        : cstring : "OfxPropIcon"
PropShortLabel                                  : cstring : "OfxPropShortLabel"
PropLongLabel                                   : cstring : "OfxPropLongLabel"
PropChangeReason                                : cstring : "OfxPropChangeReason"
PropEffectInstance                              : cstring : "OfxPropEffectInstance"
PropHostOSHandle                                : cstring : "OfxPropHostOSHandle"
PropKeySym                                      : cstring : "kOfxPropKeySym"
PropKeyString                                   : cstring : "kOfxPropKeyString"
PropParamSetNeedsSyncing                        : cstring : "OfxPropParamSetNeedsSyncing"

HostNativeOriginBottomLeft                      : cstring : "kOfxImageEffectHostPropNativeOriginBottomLeft"
HostNativeOriginTopLeft                         : cstring : "kOfxImageEffectHostPropNativeOriginTopLeft"
HostNativeOriginCenter                          : cstring : "kOfxImageEffectHostPropNativeOriginCenter"

PluginPropFilePath                              : cstring : "OfxPluginPropFilePath"
PluginPropParamPageOrder                        : cstring : "OfxPluginPropParamPageOrder"

ChangeUserEdited                                : cstring : "OfxChangeUserEdited"
ChangePluginEdited                              : cstring : "OfxChangePluginEdited"
ChangeTime                                      : cstring : "OfxChangeTime"

TypeImageEffectHost                             : cstring : "OfxTypeImageEffectHost"
TypeImageEffect                                 : cstring : "OfxTypeImageEffect"
TypeImageEffectInstance                         : cstring : "OfxTypeImageEffectInstance"
TypeClip                                        : cstring : "OfxTypeClip"
TypeImage                                       : cstring : "OfxTypeImage"
TypeParameter                                   : cstring : "OfxTypeParameter"
TypeParameterInstance                           : cstring : "OfxTypeParameterInstance"

BitDepthNone                                    : cstring : "OfxBitDepthNone"
BitDepthByte                                    : cstring : "OfxBitDepthByte"
BitDepthShort                                   : cstring : "OfxBitDepthShort"
BitDepthHalf                                    : cstring : "OfxBitDepthHalf"
BitDepthFloat                                   : cstring : "OfxBitDepthFloat"

ImageComponentNone                              : cstring : "OfxImageComponentNone"
ImageComponentRGBA                              : cstring : "OfxImageComponentRGBA"
ImageComponentRGB                               : cstring : "OfxImageComponentRGB"
ImageComponentAlpha                             : cstring : "OfxImageComponentAlpha"
ImageComponentYUVA                              : cstring : "OfxImageComponentYUVA"

ImageOpaque                                     : cstring : "OfxImageOpaque"
ImagePreMultiplied                              : cstring : "OfxImageAlphaPremultiplied"
ImageUnPreMultiplied                            : cstring : "OfxImageAlphaUnPremultiplied"

ImageFieldNone                                  : cstring : "OfxFieldNone"
ImageFieldLower                                 : cstring : "OfxFieldLower"
ImageFieldUpper                                 : cstring : "OfxFieldUpper"
ImageFieldBoth                                  : cstring : "OfxFieldBoth"
ImageFieldSingle                                : cstring : "OfxFieldSingle"
ImageFieldDoubled                               : cstring : "OfxFieldDoubled"

ImagePropUniqueIdentifier                       : cstring : "OfxImagePropUniqueIdentifier"
ImagePropPixelAspectRatio                       : cstring : "OfxImagePropPixelAspectRatio"
ImagePropData                                   : cstring : "OfxImagePropData"
ImagePropBounds                                 : cstring : "OfxImagePropBounds"
ImagePropRegionOfDefinition                     : cstring : "OfxImagePropRegionOfDefinition"
ImagePropRowBytes                               : cstring : "OfxImagePropRowBytes"
ImagePropField                                  : cstring : "OfxImagePropField"

ImageClipPropFieldExtraction                    : cstring : "OfxImageClipPropFieldExtraction"
ImageClipPropContinuousSamples                  : cstring : "OfxImageClipPropContinuousSamples"
ImageClipPropUnmappedPixelDepth                 : cstring : "OfxImageClipPropUnmappedPixelDepth"
ImageClipPropUnmappedComponents                 : cstring : "OfxImageClipPropUnmappedComponents"
ImageClipPropOptional                           : cstring : "OfxImageClipPropOptional"
ImageClipPropIsMask                             : cstring : "OfxImageClipPropIsMask"
ImageClipPropConnected                          : cstring : "OfxImageClipPropConnected"
ImageClipPropFieldOrder                         : cstring : "OfxImageClipPropFieldOrder"

ActionLoad                                      : cstring : "OfxActionLoad"
ActionDescribe                                  : cstring : "OfxActionDescribe"
ActionUnload                                    : cstring : "OfxActionUnload"
ActionPurgeCaches                               : cstring : "OfxActionPurgeCaches"
ActionSyncPrivateData                           : cstring : "OfxActionSyncPrivateData"
ActionCreateInstance                            : cstring : "OfxActionCreateInstance"
ActionDestroyInstance                           : cstring : "OfxActionDestroyInstance"
ActionInstanceChanged                           : cstring : "OfxActionInstanceChanged"
ActionBeginInstanceChanged                      : cstring : "OfxActionBeginInstanceChanged"
ActionEndInstanceChanged                        : cstring : "OfxActionEndInstanceChanged"
ActionBeginInstanceEdit                         : cstring : "OfxActionBeginInstanceEdit"
ActionEndInstanceEdit                           : cstring : "OfxActionEndInstanceEdit"
ActionDialog                                    : cstring : "OfxActionDialog"
ActionOpenGLContextAttached                     : cstring : "OfxActionOpenGLContextAttached"
ActionOpenGLContextDetached                     : cstring : "kOfxActionOpenGLContextDetached"
ActionDescribeInteract                          : cstring : ActionDescribe
ActionCreateInstanceInteract                    : cstring : ActionCreateInstance
ActionDestroyInstanceInteract                   : cstring : ActionDestroyInstance

ImageEffectActionGetRegionOfDefinition          : cstring : "OfxImageEffectActionGetRegionOfDefinition"
ImageEffectActionGetRegionsOfInterest           : cstring : "OfxImageEffectActionGetRegionsOfInterest"
ImageEffectActionGetTimeDomain                  : cstring : "OfxImageEffectActionGetTimeDomain"
ImageEffectActionGetFramesNeeded                : cstring : "OfxImageEffectActionGetFramesNeeded"
ImageEffectActionGetClipPreferences             : cstring : "OfxImageEffectActionGetClipPreferences"
ImageEffectActionIsIdentity                     : cstring : "OfxImageEffectActionIsIdentity"
ImageEffectActionRender                         : cstring : "OfxImageEffectActionRender"
ImageEffectActionBeginSequenceRender            : cstring : "OfxImageEffectActionBeginSequenceRender"
ImageEffectActionEndSequenceRender              : cstring : "OfxImageEffectActionEndSequenceRender"
ImageEffectActionDescribeInContext              : cstring : "OfxImageEffectActionDescribeInContext"

ImageEffectContextGenerator                     : cstring : "OfxImageEffectContextGenerator"
ImageEffectContextFilter                        : cstring : "OfxImageEffectContextFilter"
ImageEffectContextTransition                    : cstring : "OfxImageEffectContextTransition"
ImageEffectContextPaint                         : cstring : "OfxImageEffectContextPaint"
ImageEffectContextGeneral                       : cstring : "OfxImageEffectContextGeneral"
ImageEffectContextRetimer                       : cstring : "OfxImageEffectContextRetimer"

ImageEffectHostPropIsBackground                 : cstring : "OfxImageEffectHostPropIsBackground"
ImageEffectHostPropNativeOrigin                 : cstring : "OfxImageEffectHostPropNativeOrigin"

ImageEffectRenderUnsafe                         : cstring : "OfxImageEffectRenderUnsafe"
ImageEffectRenderInstanceSafe                   : cstring : "OfxImageEffectRenderInstanceSafe"
ImageEffectRenderFullySafe                      : cstring : "OfxImageEffectRenderFullySafe"

ImageEffectFrameVarying                         : cstring : "OfxImageEffectFrameVarying"

ImageEffectPluginApi                            : cstring : "OfxImageEffectPluginAPI"
ImageEffectPluginApiVersion                     : i32     : 1
ImageEffectPluginRenderThreadSafety             : cstring : "OfxImageEffectPluginRenderThreadSafety"

ImageEffectPluginPropSingleInstance             : cstring : "OfxImageEffectPluginPropSingleInstance"
ImageEffectPluginPropHostFrameThreading         : cstring : "OfxImageEffectPluginPropHostFrameThreading"
ImageEffectPluginPropGrouping                   : cstring : "OfxImageEffectPluginPropGrouping"
ImageEffectPluginPropOverlayInteractV1          : cstring : "OfxImageEffectPluginPropOverlayInteractV1"
ImageEffectPluginPropOverlayInteractV2          : cstring : "OfxImageEffectPluginPropOverlayInteractV2"
ImageEffectPluginPropFieldRenderTwiceAlways     : cstring : "OfxImageEffectPluginPropFieldRenderTwiceAlways"

ImageEffectInstancePropSequentialRender         : cstring : "OfxImageEffectInstancePropSequentialRender"
ImageEffectInstancePropEffectDuration           : cstring : "OfxImageEffectInstancePropEffectDuration"

ImageEffectOutputClipName                       : cstring : "Output"
ImageEffectSimpleSourceClipName                 : cstring : "Source"
ImageEffectTransitionSourceFromClipName         : cstring : "SourceFrom"
ImageEffectTransitionSourceToClipName           : cstring : "SourceTo"
ImageEffectTransitionParamName                  : cstring : "Transition"
ImageEffectRetimerParamName                     : cstring : "SourceTime"

ImageEffectPropSupportedContexts                : cstring : "OfxImageEffectPropSupportedContexts"
ImageEffectPropPluginHandle                     : cstring : "OfxImageEffectPropPluginHandle"
ImageEffectPropSupportsMultipleClipDepths       : cstring : "OfxImageEffectPropMultipleClipDepths"
ImageEffectPropSupportsMultipleClipPARs         : cstring : "OfxImageEffectPropSupportsMultipleClipPARs"
ImageEffectPropClipPreferencesSlaveParam        : cstring : "OfxImageEffectPropClipPreferencesSlaveParam"
ImageEffectPropSetableFrameRate                 : cstring : "OfxImageEffectPropSetableFrameRate"
ImageEffectPropSetableFielding                  : cstring : "OfxImageEffectPropSetableFielding"
ImageEffectPropSequentialRenderStatus           : cstring : "OfxImageEffectPropSequentialRenderStatus"
ImageEffectPropInteractiveRenderStatus          : cstring : "OfxImageEffectPropInteractiveRenderStatus"
ImageEffectPropSupportsOverlays                 : cstring : "OfxImageEffectPropSupportsOverlays"
ImageEffectPropSupportsMultiResolution          : cstring : "OfxImageEffectPropSupportsMultiResolution"
ImageEffectPropSupportsTiles                    : cstring : "OfxImageEffectPropSupportsTiles"
ImageEffectPropTemporalClipAccess               : cstring : "OfxImageEffectPropTemporalClipAccess"
ImageEffectPropContext                          : cstring : "OfxImageEffectPropContext"
ImageEffectPropPixelDepth                       : cstring : "OfxImageEffectPropPixelDepth"
ImageEffectPropComponents                       : cstring : "OfxImageEffectPropComponents"
ImageEffectPropPreMultiplication                : cstring : "OfxImageEffectPropPreMultiplication"
ImageEffectPropSupportedPixelDepths             : cstring : "OfxImageEffectPropSupportedPixelDepths"
ImageEffectPropSupportedComponents              : cstring : "OfxImageEffectPropSupportedComponents"
ImageEffectPropFrameRate                        : cstring : "OfxImageEffectPropFrameRate"
ImageEffectPropUnmappedFrameRate                : cstring : "OfxImageEffectPropUnmappedFrameRate"
ImageEffectPropFrameStep                        : cstring : "OfxImageEffectPropFrameStep"
ImageEffectPropFrameRange                       : cstring : "OfxImageEffectPropFrameRange"
ImageEffectPropUnmappedFrameRange               : cstring : "OfxImageEffectPropUnmappedFrameRange"
ImageEffectPropRenderScale                      : cstring : "OfxImageEffectPropRenderScale"
ImageEffectPropRenderQualityDraft               : cstring : "OfxImageEffectPropRenderQualityDraft"
ImageEffectPropProjectExtent                    : cstring : "OfxImageEffectPropProjectExtent"
ImageEffectPropProjectSize                      : cstring : "OfxImageEffectPropProjectSize"
ImageEffectPropProjectOffset                    : cstring : "OfxImageEffectPropProjectOffset"
ImageEffectPropProjectPixelAspectRatio          : cstring : "OfxImageEffectPropPixelAspectRatio"
ImageEffectPropFieldToRender                    : cstring : "OfxImageEffectPropFieldToRender"
ImageEffectPropRegionOfDefinition               : cstring : "OfxImageEffectPropRegionOfDefinition"
ImageEffectPropRegionOfInterest                 : cstring : "OfxImageEffectPropRegionOfInterest"
ImageEffectPropRenderWindow                     : cstring : "OfxImageEffectPropRenderWindow"
ImageEffectPropOpenGLRenderSupported            : cstring : "OfxImageEffectPropOpenGLRenderSupported"
ImageEffectPropOpenGLEnabled                    : cstring : "OfxImageEffectPropOpenGLEnabled"
ImageEffectPropOpenGLTextureIndex               : cstring : "OfxImageEffectPropOpenGLTextureIndex"
ImageEffectPropOpenGLTextureTarget              : cstring : "OfxImageEffectPropOpenGLTextureTarget"
ImageEffectPropInAnalysis                       : cstring : "OfxImageEffectPropInAnalysis"
ImageEffectPropCudaRenderSupported              : cstring : "OfxImageEffectPropCudaRenderSupported"
ImageEffectPropCudaEnabled                      : cstring : "OfxImageEffectPropCudaEnabled"
ImageEffectPropCudaStreamSupported              : cstring : "OfxImageEffectPropCudaStreamSupported"
ImageEffectPropCudaStream                       : cstring : "OfxImageEffectPropCudaStream"
ImageEffectPropMetalRenderSupported             : cstring : "OfxImageEffectPropMetalRenderSupported"
ImageEffectPropMetalEnabled                     : cstring : "OfxImageEffectPropMetalEnabled"
ImageEffectPropMetalCommandQueue                : cstring : "OfxImageEffectPropMetalCommandQueue"
ImageEffectPropOpenCLRenderSupported            : cstring : "OfxImageEffectPropOpenCLRenderSupported"
ImageEffectPropOpenCLEnabled                    : cstring : "OfxImageEffectPropOpenCLEnabled"
ImageEffectPropOpenCLCommandQueue               : cstring : "OfxImageEffectPropOpenCLCommandQueue"

OpenGLPropPixelDepth                            : cstring : "OfxOpenGLPropPixelDepth"

InteractActionDraw                              : cstring : "OfxInteractActionDraw"
InteractActionPenMotion                         : cstring : "OfxInteractActionPenMotion"
InteractActionPenDown                           : cstring : "OfxInteractActionPenDown"
InteractActionPenUp                             : cstring : "OfxInteractActionPenUp"
InteractActionKeyDown                           : cstring : "OfxInteractActionKeyDown"
InteractActionKeyUp                             : cstring : "OfxInteractActionKeyUp"
InteractActionKeyRepeat                         : cstring : "OfxInteractActionKeyRepeat"
InteractActionGainFocus                         : cstring : "OfxInteractActionGainFocus"
InteractActionLoseFocus                         : cstring : "OfxInteractActionLoseFocus"

InteractPropSlaveToParam                        : cstring : "OfxInteractPropSlaveToParam"
InteractPropPixelScale                          : cstring : "OfxInteractPropPixelScale"
InteractPropBackgroundColour                    : cstring : "OfxInteractPropBackgroundColour"
InteractPropSuggestedColour                     : cstring : "OfxInteractPropSuggestedColour"
InteractPropPenPosition                         : cstring : "OfxInteractPropPenPosition"
InteractPropPenViewportPosition                 : cstring : "OfxInteractPropPenViewportPosition"
InteractPropPenPressure                         : cstring : "OfxInteractPropPenPressure"
InteractPropBitDepth                            : cstring : "OfxInteractPropBitDepth"
InteractPropHasAlpha                            : cstring : "OfxInteractPropHasAlpha"
InteractPropDrawContext                         : cstring : "OfxInteractPropDrawContext"
InteractPropViewportSize                        : cstring : "OfxInteractPropViewport"

MessageFatal                                    : cstring : "OfxMessageFatal"
MessageError                                    : cstring : "OfxMessageError"
MessageWarning                                  : cstring : "OfxMessageWarning"
MessageMessage                                  : cstring : "OfxMessageMessage"
MessageLog                                      : cstring : "OfxMessageLog"
MessageQuestion                                 : cstring : "OfxMessageQuestion"

ParamTypeInteger                                : cstring : "OfxParamTypeInteger"
ParamTypeDouble                                 : cstring : "OfxParamTypeDouble"
ParamTypeBoolean                                : cstring : "OfxParamTypeBoolean"
ParamTypeChoice                                 : cstring : "OfxParamTypeChoice"
ParamTypeRGBA                                   : cstring : "OfxParamTypeRGBA"
ParamTypeRGB                                    : cstring : "OfxParamTypeRGB"
ParamTypeDouble2D                               : cstring : "OfxParamTypeDouble2D"
ParamTypeInteger2D                              : cstring : "OfxParamTypeInteger2D"
ParamTypeDouble3D                               : cstring : "OfxParamTypeDouble3D"
ParamTypeInteger3D                              : cstring : "OfxParamTypeInteger3D"
ParamTypeString                                 : cstring : "OfxParamTypeString"
ParamTypeCustom                                 : cstring : "OfxParamTypeCustom"
ParamTypeGroup                                  : cstring : "OfxParamTypeGroup"
ParamTypePage                                   : cstring : "OfxParamTypePage"
ParamTypePushButton                             : cstring : "OfxParamTypePushButton"
ParamTypeParametric                             : cstring : "OfxParamTypeParametric"

ParamHostPropSupportsCustomAnimation            : cstring : "OfxParamHostPropSupportsCustomAnimation"
ParamHostPropSupportsStringAnimation            : cstring : "OfxParamHostPropSupportsStringAnimation"
ParamHostPropSupportsBooleanAnimation           : cstring : "OfxParamHostPropSupportsBooleanAnimation"
ParamHostPropSupportsChoiceAnimation            : cstring : "OfxParamHostPropSupportsChoiceAnimation"
ParamHostPropSupportsCustomInteract             : cstring : "OfxParamHostPropSupportsCustomInteract"
ParamHostPropSupportsParametricAnimation        : cstring : "OfxParamHostPropSupportsParametricAnimation"

ParamHostPropMaxParameters                      : cstring : "OfxParamHostPropMaxParameters"
ParamHostPropMaxPages                           : cstring : "OfxParamHostPropMaxPages"
ParamHostPropPageRowColumnCount                 : cstring : "OfxParamHostPropPageRowColumnCount"

ParamPageSkipRow                                : cstring : "OfxParamPageSkipRow"
ParamPageSkipColumn                             : cstring : "OfxParamPageSkipColumn"

ParamInvalidateValueChange                      : cstring : "OfxParamInvalidateValueChange"
ParamInvalidateValueChangeToEnd                 : cstring : "OfxParamInvalidateValueChangeToEnd"
ParamInvalidateAll                              : cstring : "OfxParamInvalidateAll"

ParamPropInteractV1                             : cstring : "OfxParamPropInteractV1"
ParamPropInteractSize                           : cstring : "OfxParamPropInteractSize"
ParamPropInteractSizeAspect                     : cstring : "OfxParamPropInteractSizeAspect"
ParamPropInteractMinimumSize                    : cstring : "OfxParamPropInteractMinimumSize"
ParamPropInteractPreferedSize                   : cstring : "OfxParamPropInteractPreferedSize"

ParamPropType                                   : cstring : "OfxParamPropType"
ParamPropAnimates                               : cstring : "OfxParamPropAnimates"
ParamPropCanUndo                                : cstring : "OfxParamPropCanUndo"
ParamPropIsAnimating                            : cstring : "OfxParamPropIsAnimating"
ParamPropPluginMayWrite                         : cstring : "OfxParamPropPluginMayWrite"
ParamPropPersistant                             : cstring : "OfxParamPropPersistant"
ParamPropEvaluateOnChange                       : cstring : "OfxParamPropEvaluateOnChange"
ParamPropSecret                                 : cstring : "OfxParamPropSecret"
ParamPropScriptName                             : cstring : "OfxParamPropScriptName"
ParamPropCacheInvalidation                      : cstring : "OfxParamPropCacheInvalidation"
ParamPropHint                                   : cstring : "OfxParamPropHint"
ParamPropDefault                                : cstring : "OfxParamPropDefault"
ParamPropDoubleType                             : cstring : "OfxParamPropDoubleType"
ParamPropDefaultCoordinateSystem                : cstring : "OfxParamPropDefaultCoordinateSystem"
ParamPropHasHostOverlayHandle                   : cstring : "OfxParamPropHasHostOverlayHandle"
ParamPropUseHostOverlayHandle                   : cstring : "kOfxParamPropUseHostOverlayHandle"
ParamPropShowTimeMarker                         : cstring : "OfxParamPropShowTimeMarker"
ParamPropPageChild                              : cstring : "OfxParamPropPageChild"
ParamPropParent                                 : cstring : "OfxParamPropParent"
ParamPropGroupOpen                              : cstring : "OfxParamPropGroupOpen"
ParamPropEnabled                                : cstring : "OfxParamPropEnabled"
ParamPropDataPtr                                : cstring : "OfxParamPropDataPtr"
ParamPropChoiceOption                           : cstring : "OfxParamPropChoiceOption"
ParamPropMin                                    : cstring : "OfxParamPropMin"
ParamPropMax                                    : cstring : "OfxParamPropMax"
ParamPropDisplayMin                             : cstring : "OfxParamPropDisplayMin"
ParamPropDisplayMax                             : cstring : "OfxParamPropDisplayMax"
ParamPropIncrement                              : cstring : "OfxParamPropIncrement"
ParamPropDigits                                 : cstring : "OfxParamPropDigits"
ParamPropDimensionLabel                         : cstring : "OfxParamPropDimensionLabel"
ParamPropIsAutoKeying                           : cstring : "OfxParamPropIsAutoKeying"
ParamPropCustomInterpCallbackV1                 : cstring : "OfxParamPropCustomCallbackV1"
ParamPropStringMode                             : cstring : "OfxParamPropStringMode"
ParamPropStringFilePathExists                   : cstring : "OfxParamPropStringFilePathExists"
ParamPropCustomValue                            : cstring : "OfxParamPropCustomValue"
ParamPropInterpolationTime                      : cstring : "OfxParamPropInterpolationTime"
ParamPropInterpolationAmount                    : cstring : "OfxParamPropInterpolationAmount"
ParamPropParametricDimension                    : cstring : "OfxParamPropParametricDimension"
ParamPropParametricUIColour                     : cstring : "OfxParamPropParametricUIColour"
ParamPropParametricInteractBackground           : cstring : "OfxParamPropParametricInteractBackground"
ParamPropParametricRange                        : cstring : "OfxParamPropParametricRange"

ParamDoubleTypePlain                            : cstring : "OfxParamDoubleTypePlain"
ParamDoubleTypeScale                            : cstring : "OfxParamDoubleTypeScale"
ParamDoubleTypeAngle                            : cstring : "OfxParamDoubleTypeAngle"
ParamDoubleTypeTime                             : cstring : "OfxParamDoubleTypeTime"
ParamDoubleTypeAbsoluteTime                     : cstring : "OfxParamDoubleTypeAbsoluteTime"
ParamDoubleTypeX                                : cstring : "OfxParamDoubleTypeX"
ParamDoubleTypeY                                : cstring : "OfxParamDoubleTypeY"
ParamDoubleTypeXAbsolute                        : cstring : "OfxParamDoubleTypeXAbsolute"
ParamDoubleTypeYAbsolute                        : cstring : "OfxParamDoubleTypeYAbsolute"
ParamDoubleTypeXY                               : cstring : "OfxParamDoubleTypeXY"
ParamDoubleTypeXYAbsolute                       : cstring : "OfxParamDoubleTypeXYAbsolute"
ParamDoubleTypeNormalisedX                      : cstring : "OfxParamDoubleTypeNormalisedX"
ParamDoubleTypeNormalisedY                      : cstring : "OfxParamDoubleTypeNormalisedY"
ParamDoubleTypeNormalisedXAbsolute              : cstring : "OfxParamDoubleTypeNormalisedXAbsolute"
ParamDoubleTypeNormalisedYAbsolute              : cstring : "OfxParamDoubleTypeNormalisedYAbsolute"
ParamDoubleTypeNormalisedXY                     : cstring : "OfxParamDoubleTypeNormalisedXY"
ParamDoubleTypeNormalisedXYAbsolute             : cstring : "OfxParamDoubleTypeNormalisedXYAbsolute"

ParamCoordinatesCanonical                       : cstring : "OfxParamCoordinatesCanonical"
ParamCoordinatesNormalised                      : cstring : "OfxParamCoordinatesNormalised"

ParamStringIsSingleLine                         : cstring : "OfxParamStringIsSingleLine"
ParamStringIsMultiLine                          : cstring : "OfxParamStringIsMultiLine"
ParamStringIsFilePath                           : cstring : "OfxParamStringIsFilePath"
ParamStringIsDirectoryPath                      : cstring : "OfxParamStringIsDirectoryPath"
ParamStringIsLabel                              : cstring : "OfxParamStringIsLabel"
ParamStringIsRichTextFormat                     : cstring : "OfxParamStringIsRichTextFormat"

Key_Unknown                                     : i32 : 0x0000
Key_BackSpace                                   : i32 : 0xff08
Key_Tab                                         : i32 : 0xff09
Key_Linefeed                                    : i32 : 0xff0a
Key_Clear                                       : i32 : 0xff0b
Key_Return                                      : i32 : 0xff0d
Key_Pause                                       : i32 : 0xff13
Key_Scroll_Lock                                 : i32 : 0xff14
Key_Sys_Req                                     : i32 : 0xff15
Key_Escape                                      : i32 : 0xff1b
Key_Delete                                      : i32 : 0xffff
Key_Multi_key                                   : i32 : 0xff20
Key_SingleCandidate                             : i32 : 0xff3c
Key_MultipleCandidate                           : i32 : 0xff3d
Key_PreviousCandidate                           : i32 : 0xff3e
Key_Kanji                                       : i32 : 0xff21
Key_Muhenkan                                    : i32 : 0xff22
Key_Henkan_Mode                                 : i32 : 0xff23
Key_Henkan                                      : i32 : 0xff23
Key_Romaji                                      : i32 : 0xff24
Key_Hiragana                                    : i32 : 0xff25
Key_Katakana                                    : i32 : 0xff26
Key_Hiragana_Katakana                           : i32 : 0xff27
Key_Zenkaku                                     : i32 : 0xff28
Key_Hankaku                                     : i32 : 0xff29
Key_Zenkaku_Hankaku                             : i32 : 0xff2a
Key_Touroku                                     : i32 : 0xff2b
Key_Massyo                                      : i32 : 0xff2c
Key_Kana_Lock                                   : i32 : 0xff2d
Key_Kana_Shift                                  : i32 : 0xff2e
Key_Eisu_Shift                                  : i32 : 0xff2f
Key_Eisu_toggle                                 : i32 : 0xff30
Key_Zen_Koho                                    : i32 : 0xff3d
Key_Mae_Koho                                    : i32 : 0xff3e
Key_Home                                        : i32 : 0xff50
Key_Left                                        : i32 : 0xff51
Key_Up                                          : i32 : 0xff52
Key_Right                                       : i32 : 0xff53
Key_Down                                        : i32 : 0xff54
Key_Prior                                       : i32 : 0xff55
Key_Page_Up                                     : i32 : 0xff55
Key_Next                                        : i32 : 0xff56
Key_Page_Down                                   : i32 : 0xff56
Key_End                                         : i32 : 0xff57
Key_Begin                                       : i32 : 0xff58
Key_Select                                      : i32 : 0xff60
Key_Print                                       : i32 : 0xff61
Key_Execute                                     : i32 : 0xff62
Key_Insert                                      : i32 : 0xff63
Key_Undo                                        : i32 : 0xff65
Key_Redo                                        : i32 : 0xff66
Key_Menu                                        : i32 : 0xff67
Key_Find                                        : i32 : 0xff68
Key_Cancel                                      : i32 : 0xff69
Key_Help                                        : i32 : 0xff6a
Key_Break                                       : i32 : 0xff6b
Key_Mode_switch                                 : i32 : 0xff7e
Key_script_switch                               : i32 : 0xff7e
Key_Num_Lock                                    : i32 : 0xff7f
Key_KP_Space                                    : i32 : 0xff80
Key_KP_Tab                                      : i32 : 0xff89
Key_KP_Enter                                    : i32 : 0xff8d
Key_KP_F1                                       : i32 : 0xff91
Key_KP_F2                                       : i32 : 0xff92
Key_KP_F3                                       : i32 : 0xff93
Key_KP_F4                                       : i32 : 0xff94
Key_KP_Home                                     : i32 : 0xff95
Key_KP_Left                                     : i32 : 0xff96
Key_KP_Up                                       : i32 : 0xff97
Key_KP_Right                                    : i32 : 0xff98
Key_KP_Down                                     : i32 : 0xff99
Key_KP_Prior                                    : i32 : 0xff9a
Key_KP_Page_Up                                  : i32 : 0xff9a
Key_KP_Next                                     : i32 : 0xff9b
Key_KP_Page_Down                                : i32 : 0xff9b
Key_KP_End                                      : i32 : 0xff9c
Key_KP_Begin                                    : i32 : 0xff9d
Key_KP_Insert                                   : i32 : 0xff9e
Key_KP_Delete                                   : i32 : 0xff9f
Key_KP_Equal                                    : i32 : 0xffbd
Key_KP_Multiply                                 : i32 : 0xffaa
Key_KP_Add                                      : i32 : 0xffab
Key_KP_Separator                                : i32 : 0xffac
Key_KP_Subtract                                 : i32 : 0xffad
Key_KP_Decimal                                  : i32 : 0xffae
Key_KP_Divide                                   : i32 : 0xffaf
Key_KP_0                                        : i32 : 0xffb0
Key_KP_1                                        : i32 : 0xffb1
Key_KP_2                                        : i32 : 0xffb2
Key_KP_3                                        : i32 : 0xffb3
Key_KP_4                                        : i32 : 0xffb4
Key_KP_5                                        : i32 : 0xffb5
Key_KP_6                                        : i32 : 0xffb6
Key_KP_7                                        : i32 : 0xffb7
Key_KP_8                                        : i32 : 0xffb8
Key_KP_9                                        : i32 : 0xffb9
Key_F1                                          : i32 : 0xffbe
Key_F2                                          : i32 : 0xffbf
Key_F3                                          : i32 : 0xffc0
Key_F4                                          : i32 : 0xffc1
Key_F5                                          : i32 : 0xffc2
Key_F6                                          : i32 : 0xffc3
Key_F7                                          : i32 : 0xffc4
Key_F8                                          : i32 : 0xffc5
Key_F9                                          : i32 : 0xffc6
Key_F10                                         : i32 : 0xffc7
Key_F11                                         : i32 : 0xffc8
Key_L1                                          : i32 : 0xffc8
Key_F12                                         : i32 : 0xffc9
Key_L2                                          : i32 : 0xffc9
Key_F13                                         : i32 : 0xffca
Key_L3                                          : i32 : 0xffca
Key_F14                                         : i32 : 0xffcb
Key_L4                                          : i32 : 0xffcb
Key_F15                                         : i32 : 0xffcc
Key_L5                                          : i32 : 0xffcc
Key_F16                                         : i32 : 0xffcd
Key_L6                                          : i32 : 0xffcd
Key_F17                                         : i32 : 0xffce
Key_L7                                          : i32 : 0xffce
Key_F18                                         : i32 : 0xffcf
Key_L8                                          : i32 : 0xffcf
Key_F19                                         : i32 : 0xffd0
Key_L9                                          : i32 : 0xffd0
Key_F20                                         : i32 : 0xffd1
Key_L10                                         : i32 : 0xffd1
Key_F21                                         : i32 : 0xffd2
Key_R1                                          : i32 : 0xffd2
Key_F22                                         : i32 : 0xffd3
Key_R2                                          : i32 : 0xffd3
Key_F23                                         : i32 : 0xffd4
Key_R3                                          : i32 : 0xffd4
Key_F24                                         : i32 : 0xffd5
Key_R4                                          : i32 : 0xffd5
Key_F25                                         : i32 : 0xffd6
Key_R5                                          : i32 : 0xffd6
Key_F26                                         : i32 : 0xffd7
Key_R6                                          : i32 : 0xffd7
Key_F27                                         : i32 : 0xffd8
Key_R7                                          : i32 : 0xffd8
Key_F28                                         : i32 : 0xffd9
Key_R8                                          : i32 : 0xffd9
Key_F29                                         : i32 : 0xffda
Key_R9                                          : i32 : 0xffda
Key_F30                                         : i32 : 0xffdb
Key_R10                                         : i32 : 0xffdb
Key_F31                                         : i32 : 0xffdc
Key_R11                                         : i32 : 0xffdc
Key_F32                                         : i32 : 0xffdd
Key_R12                                         : i32 : 0xffdd
Key_F33                                         : i32 : 0xffde
Key_R13                                         : i32 : 0xffde
Key_F34                                         : i32 : 0xffdf
Key_R14                                         : i32 : 0xffdf
Key_F35                                         : i32 : 0xffe0
Key_R15                                         : i32 : 0xffe0
Key_Shift_L                                     : i32 : 0xffe1
Key_Shift_R                                     : i32 : 0xffe2
Key_Control_L                                   : i32 : 0xffe3
Key_Control_R                                   : i32 : 0xffe4
Key_Caps_Lock                                   : i32 : 0xffe5
Key_Shift_Lock                                  : i32 : 0xffe6
Key_Meta_L                                      : i32 : 0xffe7
Key_Meta_R                                      : i32 : 0xffe8
Key_Alt_L                                       : i32 : 0xffe9
Key_Alt_R                                       : i32 : 0xffea
Key_Super_L                                     : i32 : 0xffeb
Key_Super_R                                     : i32 : 0xffec
Key_Hyper_L                                     : i32 : 0xffed
Key_Hyper_R                                     : i32 : 0xffee

Key_space                                       : i32 : 0x020
Key_exclam                                      : i32 : 0x021
Key_quotedbl                                    : i32 : 0x022
Key_numbersign                                  : i32 : 0x023
Key_dollar                                      : i32 : 0x024
Key_percent                                     : i32 : 0x025
Key_ampersand                                   : i32 : 0x026
Key_apostrophe                                  : i32 : 0x027
Key_quoteright                                  : i32 : 0x027
Key_parenleft                                   : i32 : 0x028
Key_parenright                                  : i32 : 0x029
Key_asterisk                                    : i32 : 0x02a
Key_plus                                        : i32 : 0x02b
Key_comma                                       : i32 : 0x02c
Key_minus                                       : i32 : 0x02d
Key_period                                      : i32 : 0x02e
Key_slash                                       : i32 : 0x02f
Key_0                                           : i32 : 0x030
Key_1                                           : i32 : 0x031
Key_2                                           : i32 : 0x032
Key_3                                           : i32 : 0x033
Key_4                                           : i32 : 0x034
Key_5                                           : i32 : 0x035
Key_6                                           : i32 : 0x036
Key_7                                           : i32 : 0x037
Key_8                                           : i32 : 0x038
Key_9                                           : i32 : 0x039
Key_colon                                       : i32 : 0x03a
Key_semicolon                                   : i32 : 0x03b
Key_less                                        : i32 : 0x03c
Key_equal                                       : i32 : 0x03d
Key_greater                                     : i32 : 0x03e
Key_question                                    : i32 : 0x03f
Key_at                                          : i32 : 0x040
Key_A                                           : i32 : 0x041
Key_B                                           : i32 : 0x042
Key_C                                           : i32 : 0x043
Key_D                                           : i32 : 0x044
Key_E                                           : i32 : 0x045
Key_F                                           : i32 : 0x046
Key_G                                           : i32 : 0x047
Key_H                                           : i32 : 0x048
Key_I                                           : i32 : 0x049
Key_J                                           : i32 : 0x04a
Key_K                                           : i32 : 0x04b
Key_L                                           : i32 : 0x04c
Key_M                                           : i32 : 0x04d
Key_N                                           : i32 : 0x04e
Key_O                                           : i32 : 0x04f
Key_P                                           : i32 : 0x050
Key_Q                                           : i32 : 0x051
Key_R                                           : i32 : 0x052
Key_S                                           : i32 : 0x053
Key_T                                           : i32 : 0x054
Key_U                                           : i32 : 0x055
Key_V                                           : i32 : 0x056
Key_W                                           : i32 : 0x057
Key_X                                           : i32 : 0x058
Key_Y                                           : i32 : 0x059
Key_Z                                           : i32 : 0x05a
Key_bracketleft                                 : i32 : 0x05b
Key_backslash                                   : i32 : 0x05c
Key_bracketright                                : i32 : 0x05d
Key_asciicircum                                 : i32 : 0x05e
Key_underscore                                  : i32 : 0x05f
Key_grave                                       : i32 : 0x060
Key_quoteleft                                   : i32 : 0x060
Key_a                                           : i32 : 0x061
Key_b                                           : i32 : 0x062
Key_c                                           : i32 : 0x063
Key_d                                           : i32 : 0x064
Key_e                                           : i32 : 0x065
Key_f                                           : i32 : 0x066
Key_g                                           : i32 : 0x067
Key_h                                           : i32 : 0x068
Key_i                                           : i32 : 0x069
Key_j                                           : i32 : 0x06a
Key_k                                           : i32 : 0x06b
Key_l                                           : i32 : 0x06c
Key_m                                           : i32 : 0x06d
Key_n                                           : i32 : 0x06e
Key_o                                           : i32 : 0x06f
Key_p                                           : i32 : 0x070
Key_q                                           : i32 : 0x071
Key_r                                           : i32 : 0x072
Key_s                                           : i32 : 0x073
Key_t                                           : i32 : 0x074
Key_u                                           : i32 : 0x075
Key_v                                           : i32 : 0x076
Key_w                                           : i32 : 0x077
Key_x                                           : i32 : 0x078
Key_y                                           : i32 : 0x079
Key_z                                           : i32 : 0x07a
Key_braceleft                                   : i32 : 0x07b
Key_bar                                         : i32 : 0x07c
Key_braceright                                  : i32 : 0x07d
Key_asciitilde                                  : i32 : 0x07e
Key_nobreakspace                                : i32 : 0x0a0
Key_exclamdown                                  : i32 : 0x0a1
Key_cent                                        : i32 : 0x0a2
Key_sterling                                    : i32 : 0x0a3
Key_currency                                    : i32 : 0x0a4
Key_yen                                         : i32 : 0x0a5
Key_brokenbar                                   : i32 : 0x0a6
Key_section                                     : i32 : 0x0a7
Key_diaeresis                                   : i32 : 0x0a8
Key_copyright                                   : i32 : 0x0a9
Key_ordfeminine                                 : i32 : 0x0aa
Key_guillemotleft                               : i32 : 0x0ab
Key_notsign                                     : i32 : 0x0ac
Key_hyphen                                      : i32 : 0x0ad
Key_registered                                  : i32 : 0x0ae
Key_macron                                      : i32 : 0x0af
Key_degree                                      : i32 : 0x0b0
Key_plusminus                                   : i32 : 0x0b1
Key_twosuperior                                 : i32 : 0x0b2
Key_threesuperior                               : i32 : 0x0b3
Key_acute                                       : i32 : 0x0b4
Key_mu                                          : i32 : 0x0b5
Key_paragraph                                   : i32 : 0x0b6
Key_periodcentered                              : i32 : 0x0b7
Key_cedilla                                     : i32 : 0x0b8
Key_onesuperior                                 : i32 : 0x0b9
Key_masculine                                   : i32 : 0x0ba
Key_guillemotright                              : i32 : 0x0bb
Key_onequarter                                  : i32 : 0x0bc
Key_onehalf                                     : i32 : 0x0bd
Key_threequarters                               : i32 : 0x0be
Key_questiondown                                : i32 : 0x0bf
Key_Agrave                                      : i32 : 0x0c0
Key_Aacute                                      : i32 : 0x0c1
Key_Acircumflex                                 : i32 : 0x0c2
Key_Atilde                                      : i32 : 0x0c3
Key_Adiaeresis                                  : i32 : 0x0c4
Key_Aring                                       : i32 : 0x0c5
Key_AE                                          : i32 : 0x0c6
Key_Ccedilla                                    : i32 : 0x0c7
Key_Egrave                                      : i32 : 0x0c8
Key_Eacute                                      : i32 : 0x0c9
Key_Ecircumflex                                 : i32 : 0x0ca
Key_Ediaeresis                                  : i32 : 0x0cb
Key_Igrave                                      : i32 : 0x0cc
Key_Iacute                                      : i32 : 0x0cd
Key_Icircumflex                                 : i32 : 0x0ce
Key_Idiaeresis                                  : i32 : 0x0cf
Key_ETH                                         : i32 : 0x0d0
Key_Eth                                         : i32 : 0x0d0
Key_Ntilde                                      : i32 : 0x0d1
Key_Ograve                                      : i32 : 0x0d2
Key_Oacute                                      : i32 : 0x0d3
Key_Ocircumflex                                 : i32 : 0x0d4
Key_Otilde                                      : i32 : 0x0d5
Key_Odiaeresis                                  : i32 : 0x0d6
Key_multiply                                    : i32 : 0x0d7
Key_Ooblique                                    : i32 : 0x0d8
Key_Ugrave                                      : i32 : 0x0d9
Key_Uacute                                      : i32 : 0x0da
Key_Ucircumflex                                 : i32 : 0x0db
Key_Udiaeresis                                  : i32 : 0x0dc
Key_Yacute                                      : i32 : 0x0dd
Key_THORN                                       : i32 : 0x0de
Key_ssharp                                      : i32 : 0x0df
Key_agrave                                      : i32 : 0x0e0
Key_aacute                                      : i32 : 0x0e1
Key_acircumflex                                 : i32 : 0x0e2
Key_atilde                                      : i32 : 0x0e3
Key_adiaeresis                                  : i32 : 0x0e4
Key_aring                                       : i32 : 0x0e5
Key_ae                                          : i32 : 0x0e6
Key_ccedilla                                    : i32 : 0x0e7
Key_egrave                                      : i32 : 0x0e8
Key_eacute                                      : i32 : 0x0e9
Key_ecircumflex                                 : i32 : 0x0ea
Key_ediaeresis                                  : i32 : 0x0eb
Key_igrave                                      : i32 : 0x0ec
Key_iacute                                      : i32 : 0x0ed
Key_icircumflex                                 : i32 : 0x0ee
Key_idiaeresis                                  : i32 : 0x0ef
Key_eth                                         : i32 : 0x0f0
Key_ntilde                                      : i32 : 0x0f1
Key_ograve                                      : i32 : 0x0f2
Key_oacute                                      : i32 : 0x0f3
Key_ocircumflex                                 : i32 : 0x0f4
Key_otilde                                      : i32 : 0x0f5
Key_odiaeresis                                  : i32 : 0x0f6
Key_division                                    : i32 : 0x0f7
Key_oslash                                      : i32 : 0x0f8
Key_ugrave                                      : i32 : 0x0f9
Key_uacute                                      : i32 : 0x0fa
Key_ucircumflex                                 : i32 : 0x0fb
Key_udiaeresis                                  : i32 : 0x0fc
Key_yacute                                      : i32 : 0x0fd
Key_thorn                                       : i32 : 0x0fe
Key_ydiaeresis                                  : i32 : 0x0ff
