module Auth.ValidationTests exposing (all)

import Test exposing (..)
import Expect exposing (..)
import Auth.State exposing (..)
import Auth.Validation exposing (isValid)


all : List Test
all =
    [ isValidLoginTests
    , isValidRegistrationTests
    ]


isValidLoginTests : Test
isValidLoginTests =
    describe "Auth.Validation.isValid on Login page"
        [ test "it can be valid" <|
            \() ->
                loginModel
                    |> isValid
                    |> equal True
        , test "it is invalid with untouched email" <|
            \() ->
                let
                    email =
                        loginModel.email

                    newEmail =
                        { email | touched = False }
                in
                    { loginModel | email = newEmail }
                        |> isValid
                        |> equal False
        , test "it is invalid with untouched password" <|
            \() ->
                let
                    pw =
                        loginModel.password

                    newPw =
                        { pw | touched = False }
                in
                    { loginModel | password = newPw }
                        |> isValid
                        |> equal False
        , test "login page does not require passwordAgain to be touched" <|
            \() ->
                let
                    pw =
                        loginModel.passwordAgain

                    newPw =
                        { pw | touched = False }
                in
                    { loginModel | passwordAgain = newPw }
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
        , test "it is invalid with untouched email" <|
            \() ->
                let
                    email =
                        registrationModel.email

                    newEmail =
                        { email | touched = False }
                in
                    { registrationModel | email = newEmail }
                        |> isValid
                        |> equal False
        , test "it is invalid with untouched password" <|
            \() ->
                let
                    pw =
                        registrationModel.password

                    newPw =
                        { pw | touched = False }
                in
                    { registrationModel | password = newPw }
                        |> isValid
                        |> equal False
        , test "it is invalid with untouched passwordAgain" <|
            \() ->
                let
                    pw =
                        registrationModel.passwordAgain

                    newPw =
                        { pw | touched = False }
                in
                    { registrationModel | passwordAgain = newPw }
                        |> isValid
                        |> equal False
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


validModel : Model
validModel =
    { page = Registration
    , email = { value = "louis@example.eu", touched = True, status = Valid }
    , password = { value = "hunter99", touched = True, status = Valid }
    , passwordAgain = { value = "hunter99", touched = True, status = Valid }
    }


loginModel : Model
loginModel =
    { validModel | page = Login }


registrationModel : Model
registrationModel =
    { validModel | page = Registration }
