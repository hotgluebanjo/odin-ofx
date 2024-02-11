package ofx

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
