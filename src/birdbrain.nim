include karax / prelude
import karax / [jwebsockets, kajax, kdom, vstyles]

import birdbrainpkg / [state]

const title = "BirdBrain"

## Helper Components
## =================

proc foreign(): cstring =
  result = cstring(&"karax_foreign_node_{foreignCount}")
  foreignCount += 1
  setForeignNodeId(result)

proc loader(text: string): VNode =
  buildHtml:
    tdiv(class="is-active pageloader"):
      span(class="title no-select"):
        text text

proc icon(class: string, margin_right: string = "1rem"): VNode =
  buildHtml:
    italic(class=class,
           style=style(
             (StyleAttr.marginRight, kstring(margin_right)),
           )):
      discard

proc hero(title: string,
          is_fullheight: bool = false): VNode =
  var hero_class = "hero is-primary"
  if is_fullheight:
    hero_class &= " is-fullheight"
  buildHtml(tdiv(class=hero_class)):
    tdiv(class="hero-body has-text-centered"):
      tdiv(class="container"):
        h1(class="title no-select",
           id=foreign(),
           style=style(
             (fontSize, kstring"4rem"),
           )):
          icon("fas fa-kiwi-bird is-large")
          text title

## Main Components
## ===============

proc createDom(data: RouterData): VNode =
  buildHtml:
    case uiState:

    of UIStateType.FirstLoad:
      loader(title)

    of UIStateType.HelloWorld:
      hero("Hello World!", is_fullheight = true)

proc view(callback: proc (data: RouterData)) =
  setRenderer(renderer = createDom, clientPostRenderCallback = callback)

when isMainModule:
  view do (data: any):
    case uiState:

    of UIStateType.FirstLoad:
      # Showcase the loading screen with an artificial delay.
      discard setTimeout(toHelloWorld, 2000)

    of UIStateType.HelloWorld:
      echo "Hello World!"
