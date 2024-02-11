package ofx

kOfxTimeLineSuite : cstring : "OfxTimeLineSuite"

OfxTimeLineSuiteV1 :: struct {
    getTime: proc(instance: rawptr, time: ^f64) -> OfxStatus,
    gotoTime: proc(instance: rawptr, time: f64) -> OfxStatus,
    getTimeBounds: proc(instance: rawptr, firstTime: ^f64, lastTime: ^f64) -> OfxStatus,
}
