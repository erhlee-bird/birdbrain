import karax / karax

type
  UIStateType* {.pure.} = enum
    FirstLoad,
    HelloWorld,

## State Variables that drive the UI
## =================================
## Changes to these variables will generally trigger a redraw.
var
  uiState*: UIStateType = UIStateType.FirstLoad
  foreignCount*: int = 0

## State Transitions
## =================

proc toHelloWorld*() =
  uiState = UIStateType.HelloWorld
  # DEV: This forced redraw is most likely necessary because of the foreign
  #      nodes present like the font-awesome icons.
  redrawSync()
