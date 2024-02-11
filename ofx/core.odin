package ofx

import "core:c"

OfxPropertySetStruct :: struct {}
OfxPropertySetHandle :: ^OfxPropertySetStruct

OfxStatus :: i32

OfxHost :: struct {
    host: OfxPropertySetHandle,
    fetchSuite: proc(host: OfxPropertySetHandle, suiteName: cstring, suiteVersion: i32) -> rawptr,
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
