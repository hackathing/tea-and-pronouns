module Auth.Validation exposing (isValid, validate)

import String
import Auth.State exposing (..)


isValid : Model -> Bool
isValid model =
    case model.page of
        Registration ->
            (model.email.status == Valid)
                && (model.password.status == Valid)
                && (model.passwordAgain.status == Valid)

        Login ->
            (model.email.status == Valid)
                && (model.password.status == Valid)


validate : Model -> Model
validate model =
    case model.page of
        Login ->
            validateLogin model

        Registration ->
            validateRegistration model


validateRegistration : Model -> Model
validateRegistration model =
    let
        password =
            checkPasswordLength model.password

        email =
            checkEmailFormat model.email

        passwordAgain =
            checkPasswordAgain model.passwordAgain model.password
    in
        { model
            | password = password
            , passwordAgain = passwordAgain
            , email = email
        }


validateLogin : Model -> Model
validateLogin model =
    let
        password =
            checkPasswordLength model.password

        email =
            checkEmailFormat model.email
    in
        { model
            | password = password
            , email = email
        }


checkPasswordLength : FieldState -> FieldState
checkPasswordLength password =
    if String.length password.value < 8 then
        { password
            | status = (Invalid "Password must be at least 8 characters")
        }
    else
        password


checkEmailFormat : FieldState -> FieldState
checkEmailFormat email =
    if String.contains "@" email.value then
        email
    else
        { email
            | status = (Invalid "That doesn't look like a valid email")
        }


checkPasswordAgain : FieldState -> FieldState -> FieldState
checkPasswordAgain passwordAgain password =
    if passwordAgain.value /= password.value then
        { passwordAgain
            | status = (Invalid "Passwords don't match")
        }
    else
        passwordAgain
