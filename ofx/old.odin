package ofx

kOfxImageComponentYUVA : cstring : "OfxImageComponentYUVA"

kOfxImageEffectPropInAnalysis : cstring : "OfxImageEffectPropInAnalysis"

OfxYUVAColourB :: struct {
    y, u, v, a: byte,
}

OfxYUVAColourS :: struct {
    y, u, v, a: u16,
}

OfxYUVAColourF :: struct {
    y, u, v, a: f32,
}

kOfxInteractPropViewportSize            : cstring : "OfxInteractPropViewport"
kOfxParamDoubleTypeNormalisedX          : cstring :  "OfxParamDoubleTypeNormalisedX"
kOfxParamDoubleTypeNormalisedY          : cstring :  "OfxParamDoubleTypeNormalisedY"
kOfxParamDoubleTypeNormalisedXAbsolute  : cstring :  "OfxParamDoubleTypeNormalisedXAbsolute"
kOfxParamDoubleTypeNormalisedYAbsolute  : cstring :  "OfxParamDoubleTypeNormalisedYAbsolute"
kOfxParamDoubleTypeNormalisedXY         : cstring :  "OfxParamDoubleTypeNormalisedXY"
kOfxParamDoubleTypeNormalisedXYAbsolute : cstring :  "OfxParamDoubleTypeNormalisedXYAbsolute"
