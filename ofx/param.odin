package ofx

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
    paramDefine: proc(paramSet: OfxParamSetHandle, paramType: cstring, name: cstring, propertySet: ^OfxPropertySetHandle) -> OfxStatus,
    paramGetHandle: proc(paramSet: OfxParamSetHandle, name: cstring, param: ^OfxParamHandle, propertySet: ^OfxPropertySetHandle) -> OfxStatus,
    paramSetGetPropertySet: proc(paramSet: OfxParamSetHandle, propHandle: ^OfxPropertySetHandle) -> OfxStatus,
    paramGetPropertySet: proc(param: OfxParamHandle, propHandle: ^OfxPropertySetHandle) -> OfxStatus,
    paramGetValue: proc "c" (paramHandle: OfxParamHandle, #c_vararg args: ..any) -> OfxStatus,
    paramGetValueAtTime: proc "c" (paramHandle: OfxParamHandle, time: OfxTime, #c_vararg args: ..any) -> OfxStatus,
    paramGetDerivative: proc "c" (paramHandle: OfxParamHandle, time: OfxTime, #c_vararg args: ..any) -> OfxStatus,
    paramGetIntegral: proc "c" (paramHandle: OfxParamHandle, time1: OfxTime, time2: OfxTime, #c_vararg args: ..any) -> OfxStatus,
    paramSetValue: proc "c" (paramHandle: OfxParamHandle, #c_vararg args: ..any) -> OfxStatus,
    paramSetValueAtTime: proc "c" (paramHandle: OfxParamHandle, time: OfxTime, #c_vararg args: ..any) -> OfxStatus,
    paramGetNumKeys: proc(paramHandle: OfxParamHandle, numberOfKeys: ^u32) -> OfxStatus,
    paramGetKeyTime: proc(paramHandle: OfxParamHandle, nthKey: u32, time: ^OfxTime) -> OfxStatus,
    paramGetKeyIndex: proc(paramHandle: OfxParamHandle, time: OfxTime, direction: i32, index: ^i32) -> OfxStatus,
    paramDeleteKey: proc(paramHandle: OfxParamHandle, time: OfxTime) -> OfxStatus,
    paramDeleteAllKeys: proc(paramHandle: OfxParamHandle) -> OfxStatus,
    paramCopy: proc(paramTo: OfxParamHandle, paramFrom: OfxParamHandle, dstOffset: OfxTime, frameRange: ^OfxRangeD) -> OfxStatus,
    paramEditBegin: proc(paramSet: OfxParamSetHandle, name: cstring) -> OfxStatus,
    paramEditEnd: proc(paramSet: OfxParamSetHandle) -> OfxStatus,
}
