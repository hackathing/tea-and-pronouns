module Auth.Validation exposing (isValid, validate)

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



-- TODO


validate : Model -> Model
validate model =
    model
