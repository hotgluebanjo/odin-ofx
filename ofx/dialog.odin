package ofx

kOfxDialogSuite : cstring :  "OfxDialogSuite"
kOfxActionDialog : cstring : "OfxActionDialog"

OfxDialogSuiteV1 :: struct {
    RequestDialog: proc(user_data: rawptr) -> OfxStatus,
    NotifyRedrawPending: proc() -> OfxStatus,
}
