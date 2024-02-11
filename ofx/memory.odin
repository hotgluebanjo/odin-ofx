package ofx

kOfxMemorySuite : cstring : "OfxMemorySuite"

OfxMemorySuiteV1 :: struct {
    memoryAlloc: proc(handle: rawptr, nBytes: uint, allocatedData: ^rawptr) -> OfxStatus,
    memoryFree: proc(allocatedData: rawptr) -> OfxStatus,
}
