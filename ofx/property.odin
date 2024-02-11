package ofx

import "core:c"

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
