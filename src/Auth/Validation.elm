module Auth.Validation exposing (isValid, validate)

import String
import Auth.State exposing (..)


isValid : Model -> Bool
isValid model =
    case model.page of
        Registration ->
            allRegFieldsTouched model && allRegFieldsValid model

        Login ->
            allLoginFieldsTouched model && allLoginFieldsValid model


allRegFieldsTouched : Model -> Bool
allRegFieldsTouched model =
    model.email.touched
        && model.password.touched
        && model.passwordAgain.touched


allRegFieldsValid : Model -> Bool
allRegFieldsValid model =
    (model.email.status == Valid)
        && (model.password.status == Valid)
        && (model.passwordAgain.status == Valid)


allLoginFieldsTouched : Model -> Bool
allLoginFieldsTouched model =
    model.email.touched
        && model.password.touched


allLoginFieldsValid : Model -> Bool
allLoginFieldsValid model =
    (model.email.status == Valid)
        && (model.password.status == Valid)


validate : Model -> Model
validate model =
    case model.page of
        Login ->
            model

        Registration ->
            validateRegistration model


validateRegistration : Model -> Model
validateRegistration model =
    let
        password =
            checkPasswordLength model.password

        email =
            checkEmail model.email

        passwordAgain =
            checkPasswordAgain model.passwordAgain model.password
    in
        { model | password = password, passwordAgain = passwordAgain, email = email }


checkPasswordLength : FieldState -> FieldState
checkPasswordLength password =
    if password.touched && String.length password.value < 8 then
        { password
            | status = (Invalid "Password must be at least 8 characters")
        }
    else
        password


checkEmail : FieldState -> FieldState
checkEmail email =
    if email.touched && not (String.contains "@" email.value) then
        { email
            | status = (Invalid "That doesn't look like a valid email!")
        }
    else
        email


checkPasswordAgain : FieldState -> FieldState -> FieldState
checkPasswordAgain passwordAgain password =
    if passwordAgain.touched && passwordAgain.value /= password.value then
        { passwordAgain
            | status = (Invalid "Passwords don't match!")
        }
    else
        passwordAgain
