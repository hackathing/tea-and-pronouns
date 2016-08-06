module Auth.View exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Auth.State exposing (..)


root : Model -> Html Msg
root model =
    case model.page of
        Login ->
            login model

        Registration ->
            registration model


login : Model -> Html Msg
login model =
    div []
        [ h1 [] [ text "Login" ]
        , field Email model.email
        , field Password model.password
        , button [] [ text "Submit" ]
        , pageSwitch Registration "Need to create an account?"
        ]


registration : Model -> Html Msg
registration model =
    div []
        [ h1 [] [ text "Registration" ]
        , field Email model.email
        , field Password model.password
        , field PasswordAgain model.passwordAgain
        , button [] [ text "Submit" ]
        , pageSwitch Login "Already have an account?"
        ]


field : FieldName -> FieldState -> Html a
field name state =
    div []
        [ label [] [ labelText name ]
        , input [] [ text state.value ]
        ]


pageSwitch : Page -> String -> Html Msg
pageSwitch page prompt =
    a [ href "#", onClick <| ChangePage page ] [ text prompt ]


labelText : FieldName -> Html a
labelText name =
    text <|
        case name of
            Email ->
                "Email"

            Password ->
                "Password"

            PasswordAgain ->
                "Password Confirmation"
