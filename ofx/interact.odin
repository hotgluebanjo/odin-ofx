package ofx

kOfxInteractSuite : cstring : "OfxInteractSuite"

OfxInteract :: struct {}
OfxInteractHandle :: ^OfxInteract

kOfxInteractPropSlaveToParam            : cstring : "OfxInteractPropSlaveToParam"
kOfxInteractPropPixelScale              : cstring : "OfxInteractPropPixelScale"
kOfxInteractPropBackgroundColour        : cstring : "OfxInteractPropBackgroundColour"
kOfxInteractPropSuggestedColour         : cstring : "OfxInteractPropSuggestedColour"
kOfxInteractPropPenPosition             : cstring : "OfxInteractPropPenPosition"
kOfxInteractPropPenViewportPosition     : cstring : "OfxInteractPropPenViewportPosition"
kOfxInteractPropPenPressure             : cstring : "OfxInteractPropPenPressure"
kOfxInteractPropBitDepth                : cstring : "OfxInteractPropBitDepth"
kOfxInteractPropHasAlpha                : cstring : "OfxInteractPropHasAlpha"
kOfxInteractActionDraw                  : cstring : "OfxInteractActionDraw"
kOfxInteractActionPenMotion             : cstring : "OfxInteractActionPenMotion"
kOfxInteractActionPenDown               : cstring : "OfxInteractActionPenDown"
kOfxInteractActionPenUp                 : cstring : "OfxInteractActionPenUp"
kOfxInteractActionKeyDown               : cstring : "OfxInteractActionKeyDown"
kOfxInteractActionKeyUp                 : cstring : "OfxInteractActionKeyUp"
kOfxInteractActionKeyRepeat             : cstring : "OfxInteractActionKeyRepeat"
kOfxInteractActionGainFocus             : cstring : "OfxInteractActionGainFocus"
kOfxInteractActionLoseFocus             : cstring : "OfxInteractActionLoseFocus"

kOfxActionDescribeInteract          :: kOfxActionDescribe
kOfxActionCreateInstanceInteract    :: kOfxActionCreateInstance
kOfxActionDestroyInstanceInteract   :: kOfxActionDestroyInstance
