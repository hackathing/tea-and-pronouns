module Auth.ValidationTests exposing (all)

import Test exposing (..)
import Expect exposing (..)
import Auth.State exposing (..)
import Auth.Validation exposing (isValid, validate)


all : List Test
all =
    [ isValidLoginTests
    , isValidRegistrationTests
    , validateLoginTests
    , validateRegistrationTests
    ]


isValidLoginTests : Test
isValidLoginTests =
    describe "Auth.Validation.isValid on Login page"
        [ test "it can be valid" <|
            \() ->
                loginModel
                    |> isValid
                    |> equal True
        , test "it is invalid with email error" <|
            \() ->
                let
                    email =
                        loginModel.email

                    newEmail =
                        { email | status = Invalid "" }
                in
                    { loginModel | email = newEmail }
                        |> isValid
                        |> equal False
        , test "it is invalid with password error" <|
            \() ->
                let
                    pw =
                        loginModel.password

                    newPw =
                        { pw | status = Invalid "" }
                in
                    { loginModel | password = newPw }
                        |> isValid
                        |> equal False
        , test "login page does not require passwordAgain to be valid" <|
            \() ->
                let
                    pw =
                        loginModel.passwordAgain

                    newPw =
                        { pw | status = Invalid "" }
                in
                    { loginModel | passwordAgain = newPw }
                        |> isValid
                        |> equal True
        ]


isValidRegistrationTests : Test
isValidRegistrationTests =
    describe "Auth.Validation.isValid on Registration page"
        [ test "it can be valid" <|
            \() ->
                registrationModel
                    |> isValid
                    |> equal True
        , test "it is invalid with email error" <|
            \() ->
                let
                    email =
                        registrationModel.email

                    newEmail =
                        { email | status = Invalid "" }
                in
                    { registrationModel | email = newEmail }
                        |> isValid
                        |> equal False
        , test "it is invalid with password error" <|
            \() ->
                let
                    pw =
                        registrationModel.password

                    newPw =
                        { pw | status = Invalid "" }
                in
                    { registrationModel | password = newPw }
                        |> isValid
                        |> equal False
        , test "it is invalid with passwordAgain error" <|
            \() ->
                let
                    pw =
                        registrationModel.passwordAgain

                    newPw =
                        { pw | status = Invalid "" }
                in
                    { registrationModel | passwordAgain = newPw }
                        |> isValid
                        |> equal False
        ]


validateRegistrationTests : Test
validateRegistrationTests =
    describe "Auth.Validation.validate on registration page"
        [ test "short passwords are invalid" <|
            \() ->
                let
                    pw =
                        registrationModel.password

                    newPw =
                        { pw | value = "short" }
                in
                    { registrationModel | password = newPw }
                        |> validate
                        |> .password
                        |> .status
                        |> equal
                            (Invalid "Password must be at least 8 characters")
        , test "emails that don't look like emails are invalid" <|
            \() ->
                let
                    email =
                        registrationModel.email

                    newEmail =
                        { email | value = "Timmeh" }
                in
                    { registrationModel | email = newEmail }
                        |> validate
                        |> .email
                        |> .status
                        |> equal
                            (Invalid "That doesn't look like a valid email")
        , test "passwordAgain is invalid unless it matches password" <|
            \() ->
                let
                    pw =
                        registrationModel.passwordAgain

                    newPw =
                        { pw | value = "some other value" }
                in
                    { registrationModel | passwordAgain = newPw }
                        |> validate
                        |> .passwordAgain
                        |> .status
                        |> equal
                            (Invalid "Passwords don't match")
        ]


validateLoginTests : Test
validateLoginTests =
    describe "Auth.Validation.validate on login page"
        [ test "short passwords are invalid" <|
            \() ->
                let
                    pw =
                        loginModel.password

                    newPw =
                        { pw | value = "short" }
                in
                    { loginModel | password = newPw }
                        |> validate
                        |> .password
                        |> .status
                        |> equal
                            (Invalid "Password must be at least 8 characters")
        , test "emails that don't look like emails are invalid" <|
            \() ->
                let
                    email =
                        loginModel.email

                    newEmail =
                        { email | value = "Timmeh" }
                in
                    { loginModel | email = newEmail }
                        |> validate
                        |> .email
                        |> .status
                        |> equal
                            (Invalid "That doesn't look like a valid email")
        ]


validModel : Model
validModel =
    { page = Registration
    , email = { value = "louis@example.eu", status = Valid }
    , password = { value = "hunter99", status = Valid }
    , passwordAgain = { value = "hunter99", status = Valid }
    }


loginModel : Model
loginModel =
    { validModel | page = Login }


registrationModel : Model
registrationModel =
    { validModel | page = Registration }
