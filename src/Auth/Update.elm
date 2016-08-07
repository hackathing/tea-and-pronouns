module Auth.Update exposing (update)

import Auth.State exposing (..)
import Auth.Validation exposing (validate)


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangePage page ->
            { model | page = page }

        ChangeEmail value ->
            { model
                | email = setValue value model.email
            }

        ChangePassword value ->
            { model
                | password = setValue value model.password
            }

        ChangePasswordAgain value ->
            { model
                | passwordAgain = setValue value model.passwordAgain
            }

        Submit ->
            model
                |> validate


setValue : String -> FieldState -> FieldState
setValue value field =
    { field | value = value }
