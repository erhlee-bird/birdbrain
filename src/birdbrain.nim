include karax / prelude
import karax / [jwebsockets, kajax, kdom, vstyles]

type
  UIStateType* {.pure.} = enum
    FirstLoad,
    HelloWorld,

const title = "BirdBrain"

## State Variables that drive the UI
## =================================
## Changes to these variables will generally trigger a redraw.
var
  uiState*: UIStateType = UIStateType.FirstLoad

proc loader(text: string): VNode =
  buildHtml:
    tdiv(class="is-active pageloader"):
      span(class="title no-select"):
        text text

proc createDom(data: RouterData): VNode =
  buildHtml:
    case uiState:

    of UIStateType.FirstLoad:
      loader(title)
    else:
      tdiv()

proc view(callback: proc (data: RouterData)) =
  setRenderer(renderer = createDom, clientPostRenderCallback = callback)

when isMainModule:
  view do (data: any):
    case uiState:

    of UIStateType.FirstLoad:
      # XXX: Transition here. Otherwise we'll load forever.
      discard
    else:
      discard
