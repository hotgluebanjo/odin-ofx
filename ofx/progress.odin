package ofx

kOfxProgressSuite : cstring : "OfxProgressSuite"

OfxProgressSuiteV1 :: struct {
    progressStart: proc(effectInstance: rawptr, label: cstring) -> OfxStatus,
    progressUpdate: proc(effectInstance: rawptr, progress: f64) -> OfxStatus,
    progressEnd: proc(effectInstance: rawptr) -> OfxStatus,
}

OfxProgressSuiteV2 :: struct {
    progressStart: proc(effectInstance: rawptr, message: cstring, messageid: cstring) -> OfxStatus,
    progressUpdate: proc(effectInstance: rawptr, progress: f64) -> OfxStatus,
    progressEnd: proc(effectInstance: rawptr) -> OfxStatus,
}
