package ofx

import "core:c"

// Core

OfxPropertySetStruct :: struct {}
OfxPropertySetHandle :: ^OfxPropertySetStruct

OfxStatus :: i32

OfxHost :: struct {
    host: OfxPropertySetHandle,
    fetchSuite: proc "c" (host: OfxPropertySetHandle, suiteName: cstring, suiteVersion: i32) -> rawptr,
}

OfxPluginEntryPoint :: proc(action: cstring, handle: rawptr, inArgs: OfxPropertySetHandle, outArgs: OfxPropertySetHandle) -> OfxStatus

OfxPlugin :: struct {
    pluginApi: cstring,
    apiVersion: i32,
    pluginIdentifier: cstring,
    pluginVersionMajor: u32,
    pluginVersionMinor: u32,
    setHost: proc(host: ^OfxHost),
    mainEntry: OfxPluginEntryPoint,
}

kOfxActionLoad                  : cstring : "OfxActionLoad"
kOfxActionDescribe              : cstring : "OfxActionDescribe"
kOfxActionUnload                : cstring : "OfxActionUnload"
kOfxActionPurgeCaches           : cstring : "OfxActionPurgeCaches"
kOfxActionSyncPrivateData       : cstring : "OfxActionSyncPrivateData"
kOfxActionCreateInstance        : cstring : "OfxActionCreateInstance"
kOfxActionDestroyInstance       : cstring : "OfxActionDestroyInstance"
kOfxActionInstanceChanged       : cstring : "OfxActionInstanceChanged"
kOfxActionBeginInstanceChanged  : cstring : "OfxActionBeginInstanceChanged"
kOfxActionEndInstanceChanged    : cstring : "OfxActionEndInstanceChanged"
kOfxActionBeginInstanceEdit     : cstring : "OfxActionBeginInstanceEdit"
kOfxActionEndInstanceEdit       : cstring : "OfxActionEndInstanceEdit"

// May not be needed.
foreign {
    // @export
    OfxGetPlugin :: proc(nth: i32) -> ^OfxPlugin ---

    // @export
    OfxGetNumberOfPlugins :: proc() -> i32 ---
}

kOfxPropAPIVersion          : cstring : "OfxPropAPIVersion"
kOfxPropTime                : cstring : "OfxPropTime"
kOfxPropIsInteractive       : cstring : "OfxPropIsInteractive"
kOfxPluginPropFilePath      : cstring : "OfxPluginPropFilePath"
kOfxPropInstanceData        : cstring : "OfxPropInstanceData"
kOfxPropType                : cstring : "OfxPropType"
kOfxPropName                : cstring : "OfxPropName"
kOfxPropVersion             : cstring : "OfxPropVersion"
kOfxPropVersionLabel        : cstring : "OfxPropVersionLabel"
kOfxPropPluginDescription   : cstring : "OfxPropPluginDescription"
kOfxPropLabel               : cstring : "OfxPropLabel"
kOfxPropIcon                : cstring : "OfxPropIcon"
kOfxPropShortLabel          : cstring : "OfxPropShortLabel"
kOfxPropLongLabel           : cstring : "OfxPropLongLabel"
kOfxPropChangeReason        : cstring : "OfxPropChangeReason"
kOfxPropEffectInstance      : cstring : "OfxPropEffectInstance"
kOfxPropHostOSHandle        : cstring : "OfxPropHostOSHandle"
kOfxChangeUserEdited        : cstring : "OfxChangeUserEdited"
kOfxChangePluginEdited      : cstring : "OfxChangePluginEdited"
kOfxChangeTime              : cstring : "OfxChangeTime"

OfxTime :: f64

OfxRangeI :: struct {
    min, max: i32,
}

OfxRangeD :: struct {
    min, max: f64,
}

OfxPointI :: struct {
    x, y: i32,
}

OfxPointD :: struct {
    x, y: f64,
}

kOfxFlagInfiniteMax :: c.INT32_MAX
kOfxFlagInfiniteMin :: c.INT32_MIN

OfxRectI :: struct {
    x1, y1, x2, y2: i32,
}

OfxRectD :: struct {
    x1, y1, x2, y2: f64,
}

kOfxBitDepthNone   : cstring : "OfxBitDepthNone"
kOfxBitDepthByte   : cstring : "OfxBitDepthByte"
kOfxBitDepthShort  : cstring : "OfxBitDepthShort"
kOfxBitDepthHalf   : cstring : "OfxBitDepthHalf"
kOfxBitDepthFloat  : cstring : "OfxBitDepthFloat"

kOfxStatOK                      : i32 : 0
kOfxStatFailed                  : i32 : 1
kOfxStatErrFatal                : i32 : 2
kOfxStatErrUnknown              : i32 : 3
kOfxStatErrMissingHostFeature   : i32 : 4
kOfxStatErrUnsupported          : i32 : 5
kOfxStatErrExists               : i32 : 6
kOfxStatErrFormat               : i32 : 7
kOfxStatErrMemory               : i32 : 8
kOfxStatErrBadHandle            : i32 : 9
kOfxStatErrBadIndex             : i32 : 10
kOfxStatErrValue                : i32 : 11
kOfxStatReplyYes                : i32 : 12
kOfxStatReplyNo                 : i32 : 13
kOfxStatReplyDefault            : i32 : 14

// Dialog

kOfxDialogSuite : cstring :  "OfxDialogSuite"
kOfxActionDialog : cstring : "OfxActionDialog"

OfxDialogSuiteV1 :: struct {
    RequestDialog: proc "c" (user_data: rawptr) -> OfxStatus,
    NotifyRedrawPending: proc "c" () -> OfxStatus,
}

// Image Effect

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

// Interact

kOfxInteractSuite : cstring : "OfxInteractSuite"

OfxInteract :: struct {}
OfxInteractHandle :: ^OfxInteract

kOfxInteractPropSlaveToParam            : cstring : "OfxInteractPropSlaveToParam"
kOfxInteractPropPixelScale              : cstring : "OfxInteractPropPixelScale"
kOfxInteractPropBackgroundColour        : cstring : "OfxInteractPropBackgroundColour"
kOfxInteractPropSuggestedColour         : cstring : "OfxInteractPropSuggestedColour"
kOfxInteractPropPenPosition             : cstring : "OfxInteractPropPenPosition"
kOfxInteractPropPenViewportPosition     : cstring : "OfxInteractPropPenViewportPosition"
kOfxInteractPropPenPressure             : cstring : "OfxInteractPropPenPressure"
kOfxInteractPropBitDepth                : cstring : "OfxInteractPropBitDepth"
kOfxInteractPropHasAlpha                : cstring : "OfxInteractPropHasAlpha"
kOfxInteractActionDraw                  : cstring : "OfxInteractActionDraw"
kOfxInteractActionPenMotion             : cstring : "OfxInteractActionPenMotion"
kOfxInteractActionPenDown               : cstring : "OfxInteractActionPenDown"
kOfxInteractActionPenUp                 : cstring : "OfxInteractActionPenUp"
kOfxInteractActionKeyDown               : cstring : "OfxInteractActionKeyDown"
kOfxInteractActionKeyUp                 : cstring : "OfxInteractActionKeyUp"
kOfxInteractActionKeyRepeat             : cstring : "OfxInteractActionKeyRepeat"
kOfxInteractActionGainFocus             : cstring : "OfxInteractActionGainFocus"
kOfxInteractActionLoseFocus             : cstring : "OfxInteractActionLoseFocus"

kOfxActionDescribeInteract          :: kOfxActionDescribe
kOfxActionCreateInstanceInteract    :: kOfxActionCreateInstance
kOfxActionDestroyInstanceInteract   :: kOfxActionDestroyInstance

// Key Syms

kOfxPropKeySym      : cstring : "kOfxPropKeySym"
kOfxPropKeyString   : cstring : "kOfxPropKeyString"

kOfxKey_Unknown             : i32 : 0x0
kOfxKey_BackSpace           : i32 : 0xFF08
kOfxKey_Tab                 : i32 : 0xFF09
kOfxKey_Linefeed            : i32 : 0xFF0A
kOfxKey_Clear               : i32 : 0xFF0B
kOfxKey_Return              : i32 : 0xFF0D
kOfxKey_Pause               : i32 : 0xFF13
kOfxKey_Scroll_Lock         : i32 : 0xFF14
kOfxKey_Sys_Req             : i32 : 0xFF15
kOfxKey_Escape              : i32 : 0xFF1B
kOfxKey_Delete              : i32 : 0xFFFF
kOfxKey_Multi_key           : i32 : 0xFF20
kOfxKey_SingleCandidate     : i32 : 0xFF3C
kOfxKey_MultipleCandidate   : i32 : 0xFF3D
kOfxKey_PreviousCandidate   : i32 : 0xFF3E
kOfxKey_Kanji               : i32 : 0xFF21
kOfxKey_Muhenkan            : i32 : 0xFF22
kOfxKey_Henkan_Mode         : i32 : 0xFF23
kOfxKey_Henkan              : i32 : 0xFF23
kOfxKey_Romaji              : i32 : 0xFF24
kOfxKey_Hiragana            : i32 : 0xFF25
kOfxKey_Katakana            : i32 : 0xFF26
kOfxKey_Hiragana_Katakana   : i32 : 0xFF27
kOfxKey_Zenkaku             : i32 : 0xFF28
kOfxKey_Hankaku             : i32 : 0xFF29
kOfxKey_Zenkaku_Hankaku     : i32 : 0xFF2A
kOfxKey_Touroku             : i32 : 0xFF2B
kOfxKey_Massyo              : i32 : 0xFF2C
kOfxKey_Kana_Lock           : i32 : 0xFF2D
kOfxKey_Kana_Shift          : i32 : 0xFF2E
kOfxKey_Eisu_Shift          : i32 : 0xFF2F
kOfxKey_Eisu_toggle         : i32 : 0xFF30
kOfxKey_Zen_Koho            : i32 : 0xFF3D
kOfxKey_Mae_Koho            : i32 : 0xFF3E
kOfxKey_Home                : i32 : 0xFF50
kOfxKey_Left                : i32 : 0xFF51
kOfxKey_Up                  : i32 : 0xFF52
kOfxKey_Right               : i32 : 0xFF53
kOfxKey_Down                : i32 : 0xFF54
kOfxKey_Prior               : i32 : 0xFF55
kOfxKey_Page_Up             : i32 : 0xFF55
kOfxKey_Next                : i32 : 0xFF56
kOfxKey_Page_Down           : i32 : 0xFF56
kOfxKey_End                 : i32 : 0xFF57
kOfxKey_Begin               : i32 : 0xFF58
kOfxKey_Select              : i32 : 0xFF60
kOfxKey_Print               : i32 : 0xFF61
kOfxKey_Execute             : i32 : 0xFF62
kOfxKey_Insert              : i32 : 0xFF63
kOfxKey_Undo                : i32 : 0xFF65
kOfxKey_Redo                : i32 : 0xFF66
kOfxKey_Menu                : i32 : 0xFF67
kOfxKey_Find                : i32 : 0xFF68
kOfxKey_Cancel              : i32 : 0xFF69
kOfxKey_Help                : i32 : 0xFF6A
kOfxKey_Break               : i32 : 0xFF6B
kOfxKey_Mode_switch         : i32 : 0xFF7E
kOfxKey_script_switch       : i32 : 0xFF7E
kOfxKey_Num_Lock            : i32 : 0xFF7F
kOfxKey_KP_Space            : i32 : 0xFF80
kOfxKey_KP_Tab              : i32 : 0xFF89
kOfxKey_KP_Enter            : i32 : 0xFF8D
kOfxKey_KP_F1               : i32 : 0xFF91
kOfxKey_KP_F2               : i32 : 0xFF92
kOfxKey_KP_F3               : i32 : 0xFF93
kOfxKey_KP_F4               : i32 : 0xFF94
kOfxKey_KP_Home             : i32 : 0xFF95
kOfxKey_KP_Left             : i32 : 0xFF96
kOfxKey_KP_Up               : i32 : 0xFF97
kOfxKey_KP_Right            : i32 : 0xFF98
kOfxKey_KP_Down             : i32 : 0xFF99
kOfxKey_KP_Prior            : i32 : 0xFF9A
kOfxKey_KP_Page_Up          : i32 : 0xFF9A
kOfxKey_KP_Next             : i32 : 0xFF9B
kOfxKey_KP_Page_Down        : i32 : 0xFF9B
kOfxKey_KP_End              : i32 : 0xFF9C
kOfxKey_KP_Begin            : i32 : 0xFF9D
kOfxKey_KP_Insert           : i32 : 0xFF9E
kOfxKey_KP_Delete           : i32 : 0xFF9F
kOfxKey_KP_Equal            : i32 : 0xFFBD
kOfxKey_KP_Multiply         : i32 : 0xFFAA
kOfxKey_KP_Add              : i32 : 0xFFAB
kOfxKey_KP_Separator        : i32 : 0xFFAC
kOfxKey_KP_Subtract         : i32 : 0xFFAD
kOfxKey_KP_Decimal          : i32 : 0xFFAE
kOfxKey_KP_Divide           : i32 : 0xFFAF
kOfxKey_KP_0                : i32 : 0xFFB0
kOfxKey_KP_1                : i32 : 0xFFB1
kOfxKey_KP_2                : i32 : 0xFFB2
kOfxKey_KP_3                : i32 : 0xFFB3
kOfxKey_KP_4                : i32 : 0xFFB4
kOfxKey_KP_5                : i32 : 0xFFB5
kOfxKey_KP_6                : i32 : 0xFFB6
kOfxKey_KP_7                : i32 : 0xFFB7
kOfxKey_KP_8                : i32 : 0xFFB8
kOfxKey_KP_9                : i32 : 0xFFB9
kOfxKey_F1                  : i32 : 0xFFBE
kOfxKey_F2                  : i32 : 0xFFBF
kOfxKey_F3                  : i32 : 0xFFC0
kOfxKey_F4                  : i32 : 0xFFC1
kOfxKey_F5                  : i32 : 0xFFC2
kOfxKey_F6                  : i32 : 0xFFC3
kOfxKey_F7                  : i32 : 0xFFC4
kOfxKey_F8                  : i32 : 0xFFC5
kOfxKey_F9                  : i32 : 0xFFC6
kOfxKey_F10                 : i32 : 0xFFC7
kOfxKey_F11                 : i32 : 0xFFC8
kOfxKey_L1                  : i32 : 0xFFC8
kOfxKey_F12                 : i32 : 0xFFC9
kOfxKey_L2                  : i32 : 0xFFC9
kOfxKey_F13                 : i32 : 0xFFCA
kOfxKey_L3                  : i32 : 0xFFCA
kOfxKey_F14                 : i32 : 0xFFCB
kOfxKey_L4                  : i32 : 0xFFCB
kOfxKey_F15                 : i32 : 0xFFCC
kOfxKey_L5                  : i32 : 0xFFCC
kOfxKey_F16                 : i32 : 0xFFCD
kOfxKey_L6                  : i32 : 0xFFCD
kOfxKey_F17                 : i32 : 0xFFCE
kOfxKey_L7                  : i32 : 0xFFCE
kOfxKey_F18                 : i32 : 0xFFCF
kOfxKey_L8                  : i32 : 0xFFCF
kOfxKey_F19                 : i32 : 0xFFD0
kOfxKey_L9                  : i32 : 0xFFD0
kOfxKey_F20                 : i32 : 0xFFD1
kOfxKey_L10                 : i32 : 0xFFD1
kOfxKey_F21                 : i32 : 0xFFD2
kOfxKey_R1                  : i32 : 0xFFD2
kOfxKey_F22                 : i32 : 0xFFD3
kOfxKey_R2                  : i32 : 0xFFD3
kOfxKey_F23                 : i32 : 0xFFD4
kOfxKey_R3                  : i32 : 0xFFD4
kOfxKey_F24                 : i32 : 0xFFD5
kOfxKey_R4                  : i32 : 0xFFD5
kOfxKey_F25                 : i32 : 0xFFD6
kOfxKey_R5                  : i32 : 0xFFD6
kOfxKey_F26                 : i32 : 0xFFD7
kOfxKey_R6                  : i32 : 0xFFD7
kOfxKey_F27                 : i32 : 0xFFD8
kOfxKey_R7                  : i32 : 0xFFD8
kOfxKey_F28                 : i32 : 0xFFD9
kOfxKey_R8                  : i32 : 0xFFD9
kOfxKey_F29                 : i32 : 0xFFDA
kOfxKey_R9                  : i32 : 0xFFDA
kOfxKey_F30                 : i32 : 0xFFDB
kOfxKey_R10                 : i32 : 0xFFDB
kOfxKey_F31                 : i32 : 0xFFDC
kOfxKey_R11                 : i32 : 0xFFDC
kOfxKey_F32                 : i32 : 0xFFDD
kOfxKey_R12                 : i32 : 0xFFDD
kOfxKey_F33                 : i32 : 0xFFDE
kOfxKey_R13                 : i32 : 0xFFDE
kOfxKey_F34                 : i32 : 0xFFDF
kOfxKey_R14                 : i32 : 0xFFDF
kOfxKey_F35                 : i32 : 0xFFE0
kOfxKey_R15                 : i32 : 0xFFE0
kOfxKey_Shift_L             : i32 : 0xFFE1
kOfxKey_Shift_R             : i32 : 0xFFE2
kOfxKey_Control_L           : i32 : 0xFFE3
kOfxKey_Control_R           : i32 : 0xFFE4
kOfxKey_Caps_Lock           : i32 : 0xFFE5
kOfxKey_Shift_Lock          : i32 : 0xFFE6
kOfxKey_Meta_L              : i32 : 0xFFE7
kOfxKey_Meta_R              : i32 : 0xFFE8
kOfxKey_Alt_L               : i32 : 0xFFE9
kOfxKey_Alt_R               : i32 : 0xFFEA
kOfxKey_Super_L             : i32 : 0xFFEB
kOfxKey_Super_R             : i32 : 0xFFEC
kOfxKey_Hyper_L             : i32 : 0xFFED
kOfxKey_Hyper_R             : i32 : 0xFFEE
kOfxKey_space               : i32 : 0x020
kOfxKey_exclam              : i32 : 0x021
kOfxKey_quotedbl            : i32 : 0x022
kOfxKey_numbersign          : i32 : 0x023
kOfxKey_dollar              : i32 : 0x024
kOfxKey_percent             : i32 : 0x025
kOfxKey_ampersand           : i32 : 0x026
kOfxKey_apostrophe          : i32 : 0x027
kOfxKey_quoteright          : i32 : 0x027
kOfxKey_parenleft           : i32 : 0x028
kOfxKey_parenright          : i32 : 0x029
kOfxKey_asterisk            : i32 : 0x02a
kOfxKey_plus                : i32 : 0x02b
kOfxKey_comma               : i32 : 0x02c
kOfxKey_minus               : i32 : 0x02d
kOfxKey_period              : i32 : 0x02e
kOfxKey_slash               : i32 : 0x02f
kOfxKey_0                   : i32 : 0x030
kOfxKey_1                   : i32 : 0x031
kOfxKey_2                   : i32 : 0x032
kOfxKey_3                   : i32 : 0x033
kOfxKey_4                   : i32 : 0x034
kOfxKey_5                   : i32 : 0x035
kOfxKey_6                   : i32 : 0x036
kOfxKey_7                   : i32 : 0x037
kOfxKey_8                   : i32 : 0x038
kOfxKey_9                   : i32 : 0x039
kOfxKey_colon               : i32 : 0x03a
kOfxKey_semicolon           : i32 : 0x03b
kOfxKey_less                : i32 : 0x03c
kOfxKey_equal               : i32 : 0x03d
kOfxKey_greater             : i32 : 0x03e
kOfxKey_question            : i32 : 0x03f
kOfxKey_at                  : i32 : 0x040
kOfxKey_A                   : i32 : 0x041
kOfxKey_B                   : i32 : 0x042
kOfxKey_C                   : i32 : 0x043
kOfxKey_D                   : i32 : 0x044
kOfxKey_E                   : i32 : 0x045
kOfxKey_F                   : i32 : 0x046
kOfxKey_G                   : i32 : 0x047
kOfxKey_H                   : i32 : 0x048
kOfxKey_I                   : i32 : 0x049
kOfxKey_J                   : i32 : 0x04a
kOfxKey_K                   : i32 : 0x04b
kOfxKey_L                   : i32 : 0x04c
kOfxKey_M                   : i32 : 0x04d
kOfxKey_N                   : i32 : 0x04e
kOfxKey_O                   : i32 : 0x04f
kOfxKey_P                   : i32 : 0x050
kOfxKey_Q                   : i32 : 0x051
kOfxKey_R                   : i32 : 0x052
kOfxKey_S                   : i32 : 0x053
kOfxKey_T                   : i32 : 0x054
kOfxKey_U                   : i32 : 0x055
kOfxKey_V                   : i32 : 0x056
kOfxKey_W                   : i32 : 0x057
kOfxKey_X                   : i32 : 0x058
kOfxKey_Y                   : i32 : 0x059
kOfxKey_Z                   : i32 : 0x05a
kOfxKey_bracketleft         : i32 : 0x05b
kOfxKey_backslash           : i32 : 0x05c
kOfxKey_bracketright        : i32 : 0x05d
kOfxKey_asciicircum         : i32 : 0x05e
kOfxKey_underscore          : i32 : 0x05f
kOfxKey_grave               : i32 : 0x060
kOfxKey_quoteleft           : i32 : 0x060
kOfxKey_a                   : i32 : 0x061
kOfxKey_b                   : i32 : 0x062
kOfxKey_c                   : i32 : 0x063
kOfxKey_d                   : i32 : 0x064
kOfxKey_e                   : i32 : 0x065
kOfxKey_f                   : i32 : 0x066
kOfxKey_g                   : i32 : 0x067
kOfxKey_h                   : i32 : 0x068
kOfxKey_i                   : i32 : 0x069
kOfxKey_j                   : i32 : 0x06a
kOfxKey_k                   : i32 : 0x06b
kOfxKey_l                   : i32 : 0x06c
kOfxKey_m                   : i32 : 0x06d
kOfxKey_n                   : i32 : 0x06e
kOfxKey_o                   : i32 : 0x06f
kOfxKey_p                   : i32 : 0x070
kOfxKey_q                   : i32 : 0x071
kOfxKey_r                   : i32 : 0x072
kOfxKey_s                   : i32 : 0x073
kOfxKey_t                   : i32 : 0x074
kOfxKey_u                   : i32 : 0x075
kOfxKey_v                   : i32 : 0x076
kOfxKey_w                   : i32 : 0x077
kOfxKey_x                   : i32 : 0x078
kOfxKey_y                   : i32 : 0x079
kOfxKey_z                   : i32 : 0x07a
kOfxKey_braceleft           : i32 : 0x07b
kOfxKey_bar                 : i32 : 0x07c
kOfxKey_braceright          : i32 : 0x07d
kOfxKey_asciitilde          : i32 : 0x07e
kOfxKey_nobreakspace        : i32 : 0x0a0
kOfxKey_exclamdown          : i32 : 0x0a1
kOfxKey_cent                : i32 : 0x0a2
kOfxKey_sterling            : i32 : 0x0a3
kOfxKey_currency            : i32 : 0x0a4
kOfxKey_yen                 : i32 : 0x0a5
kOfxKey_brokenbar           : i32 : 0x0a6
kOfxKey_section             : i32 : 0x0a7
kOfxKey_diaeresis           : i32 : 0x0a8
kOfxKey_copyright           : i32 : 0x0a9
kOfxKey_ordfeminine         : i32 : 0x0aa
kOfxKey_guillemotleft       : i32 : 0x0ab
kOfxKey_notsign             : i32 : 0x0ac
kOfxKey_hyphen              : i32 : 0x0ad
kOfxKey_registered          : i32 : 0x0ae
kOfxKey_macron              : i32 : 0x0af
kOfxKey_degree              : i32 : 0x0b0
kOfxKey_plusminus           : i32 : 0x0b1
kOfxKey_twosuperior         : i32 : 0x0b2
kOfxKey_threesuperior       : i32 : 0x0b3
kOfxKey_acute               : i32 : 0x0b4
kOfxKey_mu                  : i32 : 0x0b5
kOfxKey_paragraph           : i32 : 0x0b6
kOfxKey_periodcentered      : i32 : 0x0b7
kOfxKey_cedilla             : i32 : 0x0b8
kOfxKey_onesuperior         : i32 : 0x0b9
kOfxKey_masculine           : i32 : 0x0ba
kOfxKey_guillemotright      : i32 : 0x0bb
kOfxKey_onequarter          : i32 : 0x0bc
kOfxKey_onehalf             : i32 : 0x0bd
kOfxKey_threequarters       : i32 : 0x0be
kOfxKey_questiondown        : i32 : 0x0bf
kOfxKey_Agrave              : i32 : 0x0c0
kOfxKey_Aacute              : i32 : 0x0c1
kOfxKey_Acircumflex         : i32 : 0x0c2
kOfxKey_Atilde              : i32 : 0x0c3
kOfxKey_Adiaeresis          : i32 : 0x0c4
kOfxKey_Aring               : i32 : 0x0c5
kOfxKey_AE                  : i32 : 0x0c6
kOfxKey_Ccedilla            : i32 : 0x0c7
kOfxKey_Egrave              : i32 : 0x0c8
kOfxKey_Eacute              : i32 : 0x0c9
kOfxKey_Ecircumflex         : i32 : 0x0ca
kOfxKey_Ediaeresis          : i32 : 0x0cb
kOfxKey_Igrave              : i32 : 0x0cc
kOfxKey_Iacute              : i32 : 0x0cd
kOfxKey_Icircumflex         : i32 : 0x0ce
kOfxKey_Idiaeresis          : i32 : 0x0cf
kOfxKey_ETH                 : i32 : 0x0d0
kOfxKey_Eth                 : i32 : 0x0d0
kOfxKey_Ntilde              : i32 : 0x0d1
kOfxKey_Ograve              : i32 : 0x0d2
kOfxKey_Oacute              : i32 : 0x0d3
kOfxKey_Ocircumflex         : i32 : 0x0d4
kOfxKey_Otilde              : i32 : 0x0d5
kOfxKey_Odiaeresis          : i32 : 0x0d6
kOfxKey_multiply            : i32 : 0x0d7
kOfxKey_Ooblique            : i32 : 0x0d8
kOfxKey_Ugrave              : i32 : 0x0d9
kOfxKey_Uacute              : i32 : 0x0da
kOfxKey_Ucircumflex         : i32 : 0x0db
kOfxKey_Udiaeresis          : i32 : 0x0dc
kOfxKey_Yacute              : i32 : 0x0dd
kOfxKey_THORN               : i32 : 0x0de
kOfxKey_ssharp              : i32 : 0x0df
kOfxKey_agrave              : i32 : 0x0e0
kOfxKey_aacute              : i32 : 0x0e1
kOfxKey_acircumflex         : i32 : 0x0e2
kOfxKey_atilde              : i32 : 0x0e3
kOfxKey_adiaeresis          : i32 : 0x0e4
kOfxKey_aring               : i32 : 0x0e5
kOfxKey_ae                  : i32 : 0x0e6
kOfxKey_ccedilla            : i32 : 0x0e7
kOfxKey_egrave              : i32 : 0x0e8
kOfxKey_eacute              : i32 : 0x0e9
kOfxKey_ecircumflex         : i32 : 0x0ea
kOfxKey_ediaeresis          : i32 : 0x0eb
kOfxKey_igrave              : i32 : 0x0ec
kOfxKey_iacute              : i32 : 0x0ed
kOfxKey_icircumflex         : i32 : 0x0ee
kOfxKey_idiaeresis          : i32 : 0x0ef
kOfxKey_eth                 : i32 : 0x0f0
kOfxKey_ntilde              : i32 : 0x0f1
kOfxKey_ograve              : i32 : 0x0f2
kOfxKey_oacute              : i32 : 0x0f3
kOfxKey_ocircumflex         : i32 : 0x0f4
kOfxKey_otilde              : i32 : 0x0f5
kOfxKey_odiaeresis          : i32 : 0x0f6
kOfxKey_division            : i32 : 0x0f7
kOfxKey_oslash              : i32 : 0x0f8
kOfxKey_ugrave              : i32 : 0x0f9
kOfxKey_uacute              : i32 : 0x0fa
kOfxKey_ucircumflex         : i32 : 0x0fb
kOfxKey_udiaeresis          : i32 : 0x0fc
kOfxKey_yacute              : i32 : 0x0fd
kOfxKey_thorn               : i32 : 0x0fe
kOfxKey_ydiaeresis          : i32 : 0x0ff

// Memory

kOfxMemorySuite : cstring : "OfxMemorySuite"

OfxMemorySuiteV1 :: struct {
    memoryAlloc: proc(handle: rawptr, nBytes: uint, allocatedData: ^rawptr) -> OfxStatus,
    memoryFree: proc(allocatedData: rawptr) -> OfxStatus,
}

// Message

kOfxMessageSuite : cstring : "OfxMessageSuite"

kOfxMessageFatal        : cstring : "OfxMessageFatal"
kOfxMessageError        : cstring : "OfxMessageError"
kOfxMessageWarning      : cstring : "OfxMessageWarning"
kOfxMessageMessage      : cstring : "OfxMessageMessage"
kOfxMessageLog          : cstring : "OfxMessageLog"
kOfxMessageQuestion     : cstring : "OfxMessageQuestion"

OfxMessageSuiteV1 :: struct {
    message: proc "c" (handle: rawptr, messageType: cstring, messageId: cstring, format: cstring, #c_vararg args: ..any) -> OfxStatus,
}

OfxMessageSuiteV2 :: struct {
    message: proc "c" (handle: rawptr, messageType: cstring, messageId: cstring, format: cstring, #c_vararg args: ..any) -> OfxStatus,
    setPersistentMessage: proc "c" (handle: rawptr, messageType: cstring, messageId: cstring, format: cstring, #c_vararg args: ..any) -> OfxStatus,
    clearPersistentMessage: proc(handle: rawptr) -> OfxStatus,
}

// Multithread

kOfxMultiThreadSuite : cstring : "OfxMultiThreadSuite"

OfxMutex :: struct {}
OfxMutexHandle :: ^OfxMutex

OfxThreadFunctionV1 :: proc(threadIndex: u32, threadMax: u32, customArg: rawptr)

OfxMultiThreadSuiteV1 :: struct {
    multiThread: proc(func: OfxThreadFunctionV1, nThreads: u32, customArg: rawptr) -> OfxStatus,
    multiThreadNumCPUs: proc(nCPUs: ^u32) -> OfxStatus,

    multiThreadIndex: proc(threadIndex: ^u32) -> OfxStatus,
    multiThreadIsSpawnedThread: proc() -> i32,

    mutexCreate:    proc(mutex: ^OfxMutexHandle, lockCount: i32) -> OfxStatus,
    mutexDestroy:   proc(mutex: OfxMutexHandle) -> OfxStatus,
    mutexLock:      proc(mutex: OfxMutexHandle) -> OfxStatus,
    mutexUnLock:    proc(mutex: OfxMutexHandle) -> OfxStatus,
    mutexTryLock:   proc(mutex: OfxMutexHandle) -> OfxStatus,
}

// Old

kOfxImageComponentYUVA : cstring : "OfxImageComponentYUVA"

kOfxImageEffectPropInAnalysis : cstring : "OfxImageEffectPropInAnalysis"

OfxYUVAColourB :: struct {
    y, u, v, a: byte,
}

OfxYUVAColourS :: struct {
    y, u, v, a: u16,
}

OfxYUVAColourF :: struct {
    y, u, v, a: f32,
}

kOfxInteractPropViewportSize            : cstring : "OfxInteractPropViewport"
kOfxParamDoubleTypeNormalisedX          : cstring :  "OfxParamDoubleTypeNormalisedX"
kOfxParamDoubleTypeNormalisedY          : cstring :  "OfxParamDoubleTypeNormalisedY"
kOfxParamDoubleTypeNormalisedXAbsolute  : cstring :  "OfxParamDoubleTypeNormalisedXAbsolute"
kOfxParamDoubleTypeNormalisedYAbsolute  : cstring :  "OfxParamDoubleTypeNormalisedYAbsolute"
kOfxParamDoubleTypeNormalisedXY         : cstring :  "OfxParamDoubleTypeNormalisedXY"
kOfxParamDoubleTypeNormalisedXYAbsolute : cstring :  "OfxParamDoubleTypeNormalisedXYAbsolute"

// OpenGL

kOfxOpenGLRenderSuite : cstring : "OfxImageEffectOpenGLRenderSuite"

kOfxImageEffectPropOpenGLRenderSupported    : cstring : "OfxImageEffectPropOpenGLRenderSupported"
kOfxOpenGLPropPixelDepth                    : cstring : "OfxOpenGLPropPixelDepth"
kOfxImageEffectPropOpenGLEnabled            : cstring : "OfxImageEffectPropOpenGLEnabled"
kOfxImageEffectPropOpenGLTextureIndex       : cstring : "OfxImageEffectPropOpenGLTextureIndex"
kOfxImageEffectPropOpenGLTextureTarget      : cstring : "OfxImageEffectPropOpenGLTextureTarget"

kOfxStatGLOutOfMemory  : i32 : 1001
kOfxStatGLRenderFailed : i32 : 1002

OfxImageEffectOpenGLRenderSuiteV1 :: struct {
    clipLoadTexture: proc(clip: OfxImageClipHandle, time: OfxTime, format: cstring, region: ^OfxRectD, textureHandle: ^OfxPropertySetHandle) -> OfxStatus,
    clipFreeTexture: proc(textureHandle: OfxPropertySetHandle) -> OfxStatus,
    flushResources: proc() -> OfxStatus,
}

kOfxActionOpenGLContextAttached : cstring : "OfxActionOpenGLContextAttached"
kOfxActionOpenGLContextDetached : cstring : "kOfxActionOpenGLContextDetached"

// Param

kOfxParameterSuite          : cstring : "OfxParameterSuite"
kOfxTypeParameter           : cstring : "OfxTypeParameter"
kOfxTypeParameterInstance   : cstring : "OfxTypeParameterInstance"

OfxParamStruct :: struct {}
OfxParamHandle :: ^OfxParamStruct

OfxParamSetStruct :: struct {}
OfxParamSetHandle :: ^OfxParamSetStruct

kOfxParamTypeInteger        : cstring : "OfxParamTypeInteger"
kOfxParamTypeDouble         : cstring : "OfxParamTypeDouble"
kOfxParamTypeBoolean        : cstring : "OfxParamTypeBoolean"
kOfxParamTypeChoice         : cstring : "OfxParamTypeChoice"
kOfxParamTypeRGBA           : cstring : "OfxParamTypeRGBA"
kOfxParamTypeRGB            : cstring : "OfxParamTypeRGB"
kOfxParamTypeDouble2D       : cstring : "OfxParamTypeDouble2D"
kOfxParamTypeInteger2D      : cstring : "OfxParamTypeInteger2D"
kOfxParamTypeDouble3D       : cstring : "OfxParamTypeDouble3D"
kOfxParamTypeInteger3D      : cstring : "OfxParamTypeInteger3D"
kOfxParamTypeString         : cstring : "OfxParamTypeString"
kOfxParamTypeCustom         : cstring : "OfxParamTypeCustom"
kOfxParamTypeGroup          : cstring : "OfxParamTypeGroup"
kOfxParamTypePage           : cstring : "OfxParamTypePage"
kOfxParamTypePushButton     : cstring : "OfxParamTypePushButton"

kOfxParamHostPropSupportsCustomAnimation    : cstring : "OfxParamHostPropSupportsCustomAnimation"
kOfxParamHostPropSupportsStringAnimation    : cstring : "OfxParamHostPropSupportsStringAnimation"
kOfxParamHostPropSupportsBooleanAnimation   : cstring : "OfxParamHostPropSupportsBooleanAnimation"
kOfxParamHostPropSupportsChoiceAnimation    : cstring : "OfxParamHostPropSupportsChoiceAnimation"
kOfxParamHostPropSupportsCustomInteract     : cstring : "OfxParamHostPropSupportsCustomInteract"
kOfxParamHostPropMaxParameters              : cstring : "OfxParamHostPropMaxParameters"
kOfxParamHostPropMaxPages                   : cstring : "OfxParamHostPropMaxPages"
kOfxParamHostPropPageRowColumnCount         : cstring : "OfxParamHostPropPageRowColumnCount"
kOfxParamPageSkipRow                        : cstring : "OfxParamPageSkipRow"
kOfxParamPageSkipColumn                     : cstring : "OfxParamPageSkipColumn"
kOfxParamPropInteractV1                     : cstring : "OfxParamPropInteractV1"
kOfxParamPropInteractSize                   : cstring : "OfxParamPropInteractSize"
kOfxParamPropInteractSizeAspect             : cstring : "OfxParamPropInteractSizeAspect"
kOfxParamPropInteractMinimumSize            : cstring : "OfxParamPropInteractMinimumSize"
kOfxParamPropInteractPreferedSize           : cstring : "OfxParamPropInteractPreferedSize"
kOfxParamPropType                           : cstring : "OfxParamPropType"
kOfxParamPropAnimates                       : cstring : "OfxParamPropAnimates"
kOfxParamPropCanUndo                        : cstring : "OfxParamPropCanUndo"
kOfxPropParamSetNeedsSyncing                : cstring : "OfxPropParamSetNeedsSyncing"
kOfxParamPropIsAnimating                    : cstring : "OfxParamPropIsAnimating"
kOfxParamPropPluginMayWrite                 : cstring : "OfxParamPropPluginMayWrite"
kOfxParamPropPersistant                     : cstring : "OfxParamPropPersistant"
kOfxParamPropEvaluateOnChange               : cstring : "OfxParamPropEvaluateOnChange"
kOfxParamPropSecret                         : cstring : "OfxParamPropSecret"
kOfxParamPropScriptName                     : cstring : "OfxParamPropScriptName"
kOfxParamPropCacheInvalidation              : cstring : "OfxParamPropCacheInvalidation"
kOfxParamInvalidateValueChange              : cstring : "OfxParamInvalidateValueChange"
kOfxParamInvalidateValueChangeToEnd         : cstring : "OfxParamInvalidateValueChangeToEnd"
kOfxParamInvalidateAll                      : cstring : "OfxParamInvalidateAll"
kOfxParamPropHint                           : cstring : "OfxParamPropHint"
kOfxParamPropDefault                        : cstring : "OfxParamPropDefault"
kOfxParamPropDoubleType                     : cstring : "OfxParamPropDoubleType"
kOfxParamDoubleTypePlain                    : cstring : "OfxParamDoubleTypePlain"
kOfxParamDoubleTypeScale                    : cstring : "OfxParamDoubleTypeScale"
kOfxParamDoubleTypeAngle                    : cstring : "OfxParamDoubleTypeAngle"
kOfxParamDoubleTypeTime                     : cstring : "OfxParamDoubleTypeTime"
kOfxParamDoubleTypeAbsoluteTime             : cstring : "OfxParamDoubleTypeAbsoluteTime"
kOfxParamDoubleTypeX                        : cstring : "OfxParamDoubleTypeX"
kOfxParamDoubleTypeY                        : cstring : "OfxParamDoubleTypeY"
kOfxParamDoubleTypeXAbsolute                : cstring : "OfxParamDoubleTypeXAbsolute"
kOfxParamDoubleTypeYAbsolute                : cstring : "OfxParamDoubleTypeYAbsolute"
kOfxParamDoubleTypeXY                       : cstring : "OfxParamDoubleTypeXY"
kOfxParamDoubleTypeXYAbsolute               : cstring : "OfxParamDoubleTypeXYAbsolute"
kOfxParamPropDefaultCoordinateSystem        : cstring : "OfxParamPropDefaultCoordinateSystem"
kOfxParamCoordinatesCanonical               : cstring : "OfxParamCoordinatesCanonical"
kOfxParamCoordinatesNormalised              : cstring : "OfxParamCoordinatesNormalised"
kOfxParamPropHasHostOverlayHandle           : cstring : "OfxParamPropHasHostOverlayHandle"
kOfxParamPropUseHostOverlayHandle           : cstring : "kOfxParamPropUseHostOverlayHandle"
kOfxParamPropShowTimeMarker                 : cstring : "OfxParamPropShowTimeMarker"
kOfxPluginPropParamPageOrder                : cstring : "OfxPluginPropParamPageOrder"
kOfxParamPropPageChild                      : cstring : "OfxParamPropPageChild"
kOfxParamPropParent                         : cstring : "OfxParamPropParent"
kOfxParamPropGroupOpen                      : cstring : "OfxParamPropGroupOpen"
kOfxParamPropEnabled                        : cstring : "OfxParamPropEnabled"
kOfxParamPropDataPtr                        : cstring : "OfxParamPropDataPtr"
kOfxParamPropChoiceOption                   : cstring : "OfxParamPropChoiceOption"
kOfxParamPropMin                            : cstring : "OfxParamPropMin"
kOfxParamPropMax                            : cstring : "OfxParamPropMax"
kOfxParamPropDisplayMin                     : cstring : "OfxParamPropDisplayMin"
kOfxParamPropDisplayMax                     : cstring : "OfxParamPropDisplayMax"
kOfxParamPropIncrement                      : cstring : "OfxParamPropIncrement"
kOfxParamPropDigits                         : cstring : "OfxParamPropDigits"
kOfxParamPropDimensionLabel                 : cstring : "OfxParamPropDimensionLabel"
kOfxParamPropIsAutoKeying                   : cstring : "OfxParamPropIsAutoKeying"
kOfxParamPropCustomInterpCallbackV1         : cstring : "OfxParamPropCustomCallbackV1"
kOfxParamPropStringMode                     : cstring : "OfxParamPropStringMode"
kOfxParamPropStringFilePathExists           : cstring : "OfxParamPropStringFilePathExists"
kOfxParamStringIsSingleLine                 : cstring : "OfxParamStringIsSingleLine"
kOfxParamStringIsMultiLine                  : cstring : "OfxParamStringIsMultiLine"
kOfxParamStringIsFilePath                   : cstring : "OfxParamStringIsFilePath"
kOfxParamStringIsDirectoryPath              : cstring : "OfxParamStringIsDirectoryPath"
kOfxParamStringIsLabel                      : cstring : "OfxParamStringIsLabel"
kOfxParamStringIsRichTextFormat             : cstring : "OfxParamStringIsRichTextFormat"
kOfxParamPropCustomValue                    : cstring : "OfxParamPropCustomValue"
kOfxParamPropInterpolationTime              : cstring : "OfxParamPropInterpolationTime"
kOfxParamPropInterpolationAmount            : cstring : "OfxParamPropInterpolationAmount"

OfxCustomParamInterpFuncV1 :: proc(instance: OfxParamSetHandle, inArgs: OfxPropertySetHandle, outArgs: OfxPropertySetHandle) -> OfxStatus

OfxParameterSuiteV1 :: struct {
    paramDefine:            proc(paramSet: OfxParamSetHandle, paramType: cstring, name: cstring, propertySet: ^OfxPropertySetHandle) -> OfxStatus,
    paramGetHandle:         proc(paramSet: OfxParamSetHandle, name: cstring, param: ^OfxParamHandle, propertySet: ^OfxPropertySetHandle) -> OfxStatus,
    paramSetGetPropertySet: proc(paramSet: OfxParamSetHandle, propHandle: ^OfxPropertySetHandle) -> OfxStatus,

    paramGetPropertySet:    proc(param: OfxParamHandle, propHandle: ^OfxPropertySetHandle) -> OfxStatus,

    paramGetValue:          proc "c" (paramHandle: OfxParamHandle, #c_vararg args: ..any) -> OfxStatus,
    paramGetValueAtTime:    proc "c" (paramHandle: OfxParamHandle, time: OfxTime, #c_vararg args: ..any) -> OfxStatus,
    paramGetDerivative:     proc "c" (paramHandle: OfxParamHandle, time: OfxTime, #c_vararg args: ..any) -> OfxStatus,
    paramGetIntegral:       proc "c" (paramHandle: OfxParamHandle, time1: OfxTime, time2: OfxTime, #c_vararg args: ..any) -> OfxStatus,

    paramSetValue:          proc "c" (paramHandle: OfxParamHandle, #c_vararg args: ..any) -> OfxStatus,
    paramSetValueAtTime:    proc "c" (paramHandle: OfxParamHandle, time: OfxTime, #c_vararg args: ..any) -> OfxStatus,

    paramGetNumKeys:        proc(paramHandle: OfxParamHandle, numberOfKeys: ^u32) -> OfxStatus,
    paramGetKeyTime:        proc(paramHandle: OfxParamHandle, nthKey: u32, time: ^OfxTime) -> OfxStatus,
    paramGetKeyIndex:       proc(paramHandle: OfxParamHandle, time: OfxTime, direction: i32, index: ^i32) -> OfxStatus,

    paramDeleteKey:         proc(paramHandle: OfxParamHandle, time: OfxTime) -> OfxStatus,
    paramDeleteAllKeys:     proc(paramHandle: OfxParamHandle) -> OfxStatus,

    paramCopy:              proc(paramTo: OfxParamHandle, paramFrom: OfxParamHandle, dstOffset: OfxTime, frameRange: ^OfxRangeD) -> OfxStatus,

    paramEditBegin:         proc(paramSet: OfxParamSetHandle, name: cstring) -> OfxStatus,
    paramEditEnd:           proc(paramSet: OfxParamSetHandle) -> OfxStatus,
}

// Parametric Param

kOfxParametricParameterSuite                    : cstring : "OfxParametricParameterSuite"
kOfxParamTypeParametric                         : cstring : "OfxParamTypeParametric"
kOfxParamPropParametricDimension                : cstring : "OfxParamPropParametricDimension"
kOfxParamPropParametricUIColour                 : cstring : "OfxParamPropParametricUIColour"
kOfxParamPropParametricInteractBackground       : cstring : "OfxParamPropParametricInteractBackground"
kOfxParamHostPropSupportsParametricAnimation    : cstring : "OfxParamHostPropSupportsParametricAnimation"
kOfxParamPropParametricRange                    : cstring : "OfxParamPropParametricRange"

OfxParametricParameterSuiteV1 :: struct {
    parametricParamGetValue:                proc(param: OfxParamHandle, curveIndex: i32, time: OfxTime, parametricPosition: f64, returnValue: ^f64) -> OfxStatus,
    parametricParamGetNControlPoints:       proc(param: OfxParamHandle, curveIndex: i32, time: f64, returnValue: ^i32) -> OfxStatus,
    parametricParamGetNthControlPoint:      proc(param: OfxParamHandle, curveIndex: i32, time: f64, nthCtl: i32, key: ^f64, value: ^f64) -> OfxStatus,

    parametricParamSetNthControlPoint:      proc(param: OfxParamHandle, curveIndex: i32, time: f64, nthCtl: i32, key: f64, value: f64, addAnimationKey: bool) -> OfxStatus,

    parametricParamAddControlPoint:         proc(param: OfxParamHandle, curveIndex: i32, time: f64, key: f64, value: f64, addAnimationKey: bool) -> OfxStatus,

    parametricParamDeleteControlPoint:      proc(param: OfxParamHandle, curveIndex: i32, nthCtl: i32) -> OfxStatus,
    parametricParamDeleteAllControlPoints:  proc(param: OfxParamHandle, curveIndex: i32) -> OfxStatus,
}

// Pixels

OfxRGBAColourB :: struct {
    r, g, b, a: byte,
}

OfxRGBAColourS :: struct {
    r, g, b, a: u16,
}

OfxRGBAColourF :: struct {
    r, g, b, a: f32,
}

OfxRGBAColourD :: struct {
    r, g, b, a: f64,
}

OfxRGBColourB :: struct {
    r, g, b: byte,
}

OfxRGBColourS :: struct {
    r, g, b: u16,
}

OfxRGBColourF :: struct {
    r, g, b: f32,
}

OfxRGBColourD :: struct {
    r, g, b: f64,
}

// Progress

kOfxProgressSuite : cstring : "OfxProgressSuite"

OfxProgressSuiteV1 :: struct {
    progressStart:  proc(effectInstance: rawptr, label: cstring) -> OfxStatus,
    progressUpdate: proc(effectInstance: rawptr, progress: f64) -> OfxStatus,
    progressEnd:    proc(effectInstance: rawptr) -> OfxStatus,
}

OfxProgressSuiteV2 :: struct {
    progressStart:  proc(effectInstance: rawptr, message: cstring, messageid: cstring) -> OfxStatus,
    progressUpdate: proc(effectInstance: rawptr, progress: f64) -> OfxStatus,
    progressEnd:    proc(effectInstance: rawptr) -> OfxStatus,
}

// Property

kOfxPropertySuite : cstring : "OfxPropertySuite"

OfxPropertySuiteV1 :: struct {
    propSetPointer:     proc(properties: OfxPropertySetHandle, property: cstring, index: i32, value: rawptr) -> OfxStatus,
    propSetString:      proc(properties: OfxPropertySetHandle, property: cstring, index: i32, value: cstring) -> OfxStatus,
    propSetDouble:      proc(properties: OfxPropertySetHandle, property: cstring, index: i32, value: f64) -> OfxStatus,
    propSetInt:         proc(properties: OfxPropertySetHandle, property: cstring, index: i32, value: i32) -> OfxStatus,

    propSetPointerN:    proc(properties: OfxPropertySetHandle, property: cstring, count: i32, value: ^rawptr) -> OfxStatus,
    propSetStringN:     proc(properties: OfxPropertySetHandle, property: cstring, count: i32, value: ^cstring) -> OfxStatus,
    propSetDoubleN:     proc(properties: OfxPropertySetHandle, property: cstring, count: i32, value: ^f64) -> OfxStatus,
    propSetIntN:        proc(properties: OfxPropertySetHandle, property: cstring, count: i32, value: ^i32) -> OfxStatus,

    propGetPointer:     proc(properties: OfxPropertySetHandle, property: cstring, index: i32, value: ^rawptr) -> OfxStatus,
    propGetString:      proc(properties: OfxPropertySetHandle, property: cstring, index: i32, value: ^cstring) -> OfxStatus,
    propGetDouble:      proc(properties: OfxPropertySetHandle, property: cstring, index: i32, value: ^f64) -> OfxStatus,
    propGetInt:         proc(properties: OfxPropertySetHandle, property: cstring, index: i32, value: ^i32) -> OfxStatus,

    propGetPointerN:    proc(properties: OfxPropertySetHandle, property: cstring, count: i32, value: ^rawptr) -> OfxStatus,
    propGetStringN:     proc(properties: OfxPropertySetHandle, property: cstring, count: i32, value: ^cstring) -> OfxStatus,
    propGetDoubleN:     proc(properties: OfxPropertySetHandle, property: cstring, count: i32, value: ^f64) -> OfxStatus,
    propGetIntN:        proc(properties: OfxPropertySetHandle, property: cstring, count: i32, value: ^i32) -> OfxStatus,

    propReset:          proc(properties: OfxPropertySetHandle, property: cstring) -> OfxStatus,
    propGetDimension:   proc(properties: OfxPropertySetHandle, property: cstring, count: ^i32) -> OfxStatus,
}

// Timeline

kOfxTimeLineSuite : cstring : "OfxTimeLineSuite"

OfxTimeLineSuiteV1 :: struct {
    getTime:       proc(instance: rawptr, time: ^f64) -> OfxStatus,
    gotoTime:      proc(instance: rawptr, time: f64) -> OfxStatus,
    getTimeBounds: proc(instance: rawptr, firstTime: ^f64, lastTime: ^f64) -> OfxStatus,
}
