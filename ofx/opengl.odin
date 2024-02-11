package ofx

kOfxOpenGLRenderSuite : cstring : "OfxImageEffectOpenGLRenderSuite"

kOfxImageEffectPropOpenGLRenderSupported    : cstring : "OfxImageEffectPropOpenGLRenderSupported"
kOfxOpenGLPropPixelDepth                    : cstring : "OfxOpenGLPropPixelDepth"
kOfxImageEffectPropOpenGLEnabled            : cstring : "OfxImageEffectPropOpenGLEnabled"
kOfxImageEffectPropOpenGLTextureIndex       : cstring : "OfxImageEffectPropOpenGLTextureIndex"
kOfxImageEffectPropOpenGLTextureTarget      : cstring : "OfxImageEffectPropOpenGLTextureTarget"

kOfxStatGLOutOfMemory  : i32 : 1001
kOfxStatGLRenderFailed : i32 : 1002

OfxImageEffectOpenGLRenderSuiteV1 :: struct {
    clipLoadTexture: proc(clip: OfxImageClipHandle, time: OfxTime, format: cstring, region: ^OfxRectD, textureHandle: ^OfxPropertySetHandle) -> OfxStatus,
    clipFreeTexture: proc(textureHandle: OfxPropertySetHandle) -> OfxStatus,
    flushResources: proc() -> OfxStatus,
}

kOfxActionOpenGLContextAttached : cstring : "OfxActionOpenGLContextAttached"
kOfxActionOpenGLContextDetached : cstring : "kOfxActionOpenGLContextDetached"
