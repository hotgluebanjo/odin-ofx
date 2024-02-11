package ofx

kOfxParametricParameterSuite                    : cstring : "OfxParametricParameterSuite"
kOfxParamTypeParametric                         : cstring : "OfxParamTypeParametric"
kOfxParamPropParametricDimension                : cstring : "OfxParamPropParametricDimension"
kOfxParamPropParametricUIColour                 : cstring : "OfxParamPropParametricUIColour"
kOfxParamPropParametricInteractBackground       : cstring : "OfxParamPropParametricInteractBackground"
kOfxParamHostPropSupportsParametricAnimation    : cstring : "OfxParamHostPropSupportsParametricAnimation"
kOfxParamPropParametricRange                    : cstring : "OfxParamPropParametricRange"

OfxParametricParameterSuiteV1 :: struct {
    parametricParamGetValue: proc(param: OfxParamHandle, curveIndex: i32, time: OfxTime, parametricPosition: f64, returnValue: ^f64) -> OfxStatus,
    parametricParamGetNControlPoints: proc(param: OfxParamHandle, curveIndex: i32, time: f64, returnValue: ^i32) -> OfxStatus,
    parametricParamGetNthControlPoint: proc(param: OfxParamHandle, curveIndex: i32, time: f64, nthCtl: i32, key: ^f64, value: ^f64) -> OfxStatus,
    parametricParamSetNthControlPoint: proc(param: OfxParamHandle, curveIndex: i32, time: f64, nthCtl: i32, key: f64, value: f64, addAnimationKey: bool) -> OfxStatus,
    parametricParamAddControlPoint: proc(param: OfxParamHandle, curveIndex: i32, time: f64, key: f64, value: f64, addAnimationKey: bool) -> OfxStatus,
    parametricParamDeleteControlPoint: proc(param: OfxParamHandle, curveIndex: i32, nthCtl: i32) -> OfxStatus,
    parametricParamDeleteAllControlPoints: proc(param: OfxParamHandle, curveIndex: i32) -> OfxStatus,
}
