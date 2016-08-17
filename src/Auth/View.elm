module Auth.View exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)
import Auth.State exposing (..)


root : Model -> Html Msg
root model =
    div [ class "auth__card card" ]
        [ case model.page of
            Login ->
                login model

            Registration ->
                registration model
        ]


login : Model -> Html Msg
login model =
    Html.form
        [ onSubmit Submit
        , autocomplete True
        , id "login-form"
        ]
        [ h1 [ class "auth__title" ] [ text "Login" ]
        , emailField model
        , passwordField model
        , submitButton model.status
        , pageSwitch Registration "Need to create an account?"
        ]


registration : Model -> Html Msg
registration model =
    Html.form
        [ onSubmit Submit
        , autocomplete True
        , id "registration-form"
        ]
        [ h1 [ class "auth__title" ] [ text "Registration" ]
        , emailField model
        , passwordField model
        , passwordAgainField model
        , submitButton model.status
        , pageSwitch Login "Already have an account?"
        ]


submitButton : FormStatus -> Html Msg
submitButton status =
    button
        [ disabled (status == Waiting)
        , class "submit-button"
        ]
        [ text "Submit" ]


emailField : Model -> Html Msg
emailField model =
    div [ class "field-group" ]
        [ label [] [ text "Email" ]
        , input
            [ onInput ChangeEmail, autocomplete True, value model.email.value ]
            []
        , errorDisplay model.email
        ]


passwordField : Model -> Html Msg
passwordField model =
    div [ class "field-group" ]
        [ label [] [ text "Password" ]
        , input
            [ type' "password"
            , onInput ChangePassword
            , value model.password.value
            ]
            []
        , errorDisplay model.password
        ]


passwordAgainField : Model -> Html Msg
passwordAgainField model =
    div [ class "field-group" ]
        [ label [] [ text "Password Confirmation" ]
        , input
            [ type' "password"
            , onInput ChangePasswordAgain
            , value model.passwordAgain.value
            ]
            []
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
    div [ class "auth__page-switch" ]
        [ a [ href "#", onClick <| ChangePage page ]
            [ text prompt ]
        ]
