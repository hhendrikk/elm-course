import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)

type alias Model =
    { query: String
    , results: List SearchResult
    }

type alias SearchResult =
    { id: Int
    , name: String
    , stars: Int
    }

type alias Msg =
    { operation: String
    , data: Int
    }

initialModel : Model
initialModel =
    { query = "tutorial"
    , results =
        [ { id = 1
          , name = "TheSeamau5/elm-checkerboardgrid-tutorial"
          , stars = 66
          }
        , { id = 2
          , name = "grzegorzbalcerek/elm-by-example"
          , stars = 41
          }
        , { id = 3
          , name = "sporto/elm-tutorial-app"
          , stars = 35
          }
        , { id = 4
          , name = "jvoigtlaender/Elm-Tutorium"
          , stars = 10
          }
        , { id = 5
          , name = "sporto/elm-tutorial-assets"
          , stars = 7
          }
        ]
    }

elmHubHeader : Html Msg
elmHubHeader =
    header []
      [ h1 [] [ text "ElmHub" ]
      , span [ class "tagline" ] [ text "Like GitHub, but for Elm things." ]
      ]

view : Model -> Html Msg
view model =
    div [ class "content" ]
      [ elmHubHeader
      , ul [ class "results" ] (List.map viewSearchResult model.results)
      ]

viewSearchResult : SearchResult -> Html Msg
viewSearchResult result =
    li []
      [ span [ class "star-count" ] [ text (String.fromInt result.stars) ]
      , a [ href ("https://github.com/" ++ result.name), target "_blank" ]
        [ text result.name ]
      , button
        [ class "hide-result", onClick { operation = "DELETE_BY_ID", data = result.id} ]
        [ text "X" ]
      ]

update : Msg -> Model -> Model
update msg model =
    if msg.operation == "DELETE_BY_ID" then
      { model | results = List.filter (\result -> result.id /= msg.data) model.results }
    else
      model

main =
    Browser.sandbox
      { init = initialModel
      , view = view
      , update = update
      }