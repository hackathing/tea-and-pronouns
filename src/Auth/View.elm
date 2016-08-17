module Auth.View exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
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
        , emailField model
        , passwordField model
        , submitButton model.status
        , pageSwitch Registration "Need to create an account?"
        ]


registration : Model -> Html Msg
registration model =
    div []
        [ h1 [] [ text "Registration" ]
        , emailField model
        , passwordField model
        , passwordAgainField model
        , submitButton model.status
        , pageSwitch Login "Already have an account?"
        ]


submitButton : FormStatus -> Html Msg
submitButton status =
    case status of
        Ready ->
            button [ onClick Submit ] [ text "Submit" ]

        Waiting ->
            button [ disabled True ] [ text "Submit" ]


emailField : Model -> Html Msg
emailField model =
    div []
        [ label []
            [ text "Email" ]
        , input [ onInput ChangeEmail ]
            [ text model.email.value ]
        , errorDisplay model.email
        ]


passwordField : Model -> Html Msg
passwordField model =
    div []
        [ label []
            [ text "Password" ]
        , input [ onInput ChangePassword ]
            [ text model.password.value ]
        , errorDisplay model.password
        ]


passwordAgainField : Model -> Html Msg
passwordAgainField model =
    div []
        [ label []
            [ text "Password Confirmation" ]
        , input [ onInput ChangePasswordAgain ]
            [ text model.passwordAgain.value ]
        , errorDisplay model.passwordAgain
        ]


errorDisplay : FieldState -> Html a
errorDisplay field =
    span [] <|
        case field.status of
            Valid ->
                []

            Invalid error ->
                [ text error ]


pageSwitch : Page -> String -> Html Msg
pageSwitch page prompt =
    a [ href "#", onClick <| ChangePage page ] [ text prompt ]
