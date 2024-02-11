package ofx

kOfxMultiThreadSuite : cstring : "OfxMultiThreadSuite"

OfxMutex :: struct {}
OfxMutexHandle :: ^OfxMutex

OfxThreadFunctionV1 :: proc(threadIndex: u32, threadMax: u32, customArg: rawptr)

OfxMultiThreadSuiteV1 :: struct {
    multiThread: proc(func: OfxThreadFunctionV1, nThreads: u32, customArg: rawptr) -> OfxStatus,

    multiThreadNumCPUs: proc(nCPUs: ^u32) -> OfxStatus,

    multiThreadIndex: proc(threadIndex: ^u32) -> OfxStatus,
    multiThreadIsSpawnedThread: proc() -> i32,

    mutexCreate: proc(mutex: ^OfxMutexHandle, lockCount: i32) -> OfxStatus,
    mutexDestroy: proc(mutex: OfxMutexHandle) -> OfxStatus,
    mutexLock: proc(mutex: OfxMutexHandle) -> OfxStatus,
    mutexUnLock: proc(mutex: OfxMutexHandle) -> OfxStatus,

    mutexTryLock: proc(mutex: OfxMutexHandle) -> OfxStatus,
}
