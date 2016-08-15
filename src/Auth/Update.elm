module Auth.Update exposing (update)

import Auth.State exposing (..)
import Auth.Validation exposing (validate, isValid)
import MsgTools exposing (sendMsg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangePage page ->
            ( { model | page = page }, Cmd.none )

        ChangeEmail value ->
            ( { model | email = setValue value model.email }
            , Cmd.none
            )

        ChangePassword value ->
            ( { model | password = setValue value model.password }
            , Cmd.none
            )

        ChangePasswordAgain value ->
            ( { model | passwordAgain = setValue value model.passwordAgain }
            , Cmd.none
            )

        DoRegister _ ->
            Debug.crash "TODO. Use this for disabling button"

        Submit ->
            maybeLogin model


maybeLogin : Model -> ( Model, Cmd Msg )
maybeLogin model =
    let
        newModel =
            validate model

        cmd =
            if isValid newModel then
                { email = model.email.value
                , password = model.password.value
                }
                    |> DoRegister
                    |> sendMsg
            else
                Cmd.none
    in
        ( newModel, cmd )


setValue : String -> FieldState -> FieldState
setValue value field =
    { field | value = value }
