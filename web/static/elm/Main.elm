import Color exposing (..)
import Graphics.Collage exposing (..)
import Graphics.Element exposing (..)
import Graphics.Input exposing (..)
import Keyboard
import Time exposing (..)
import Animation exposing (..)


type alias Point = (Int, Int)
type alias Model =
  { points : List Point
  , x : Int
  , y : Int
  , arrows: { x : Int, y : Int }
  , clock : Time
  , animation : Animation
  }


type Action
  = Arrows { x : Int, y : Int }
  | Tick Time
  | NoOp
  | Shake


shakeAnimation : Time -> Animation
shakeAnimation t =
  animation t
  |> from 0
  |> to 360
  |> duration (500 * Time.millisecond)



initialModel : Model
initialModel =
  { points = [(0, 0)]
  , x = 0
  , y = 0
  , arrows = { x = 0, y = 0 }
  , clock = 0
  , animation = static 0
  }


update : Action -> Model -> Model
update action model =
  case action of
    Arrows arrows ->
      { model
      | arrows = arrows
      }

    Tick dt ->
      let
        newX = model.x + model.arrows.x
        newY = model.y + model.arrows.y
        (newPoints, newAnimation) =
          case (model.animation `equals` (static 0)) of
            True ->
              (model.points, model.animation)
            False ->
              case (isDone model.clock model.animation) of
                True -> ([], (static 0))
                False -> (model.points, model.animation)

        newPoints' =
          case (model.arrows.x, model.arrows.y) of
            (0, 0) -> newPoints
            _ ->
              (newX, newY) :: newPoints

        model' =
          { model
          | points = newPoints'
          , clock = model.clock + dt
          , animation = newAnimation
          }
      in
        case (model.arrows.x, model.arrows.y) of
          (0, 0) ->
            model'
          _ ->
            { model'
            | points = (newX, newY) :: model.points
            , x = newX
            , y = newY
            , clock = dt + model.clock
            }

    Shake ->
      { model
      | animation = shakeAnimation model.clock
      }

    NoOp ->
      model


arrows : Signal Action
arrows =
  Signal.map Arrows Keyboard.arrows


clock : Signal Action
clock =
  Signal.map Tick (Time.fps 30)


events : Signal Action
events =
  Signal.mergeMany
    [ arrows
    , clock
    , buttonActions.signal
    ]


model : Signal Model
model =
  Signal.foldp update initialModel events


buttonActions : Signal.Mailbox Action
buttonActions = Signal.mailbox NoOp


shakeButton : Element
shakeButton =
  button (Signal.message buttonActions.address Shake) "Shake it good"


view : Model -> Element
view model =
  let
    angle =
      animate model.clock model.animation
  in
    flow down
      [ collage 800 800
        [ (rotate (degrees angle) (drawLine model.points)) ]
      , shakeButton
      ]


drawLine : List Point -> Form
drawLine points =
  let
    intsToFloats : (Int, Int) -> (Float, Float)
    intsToFloats (x, y) =
      (toFloat x, toFloat y)

    shape = path (List.map intsToFloats points)
  in
    shape
    |> traced (solid red)


main : Signal Element
main =
  Signal.map view model
