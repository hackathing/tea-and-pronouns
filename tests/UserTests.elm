module UserTests exposing (all)

import Test exposing (..)
import Expect exposing (..)
import Json.Decode exposing (decodeString)
import User exposing (..)


all : List Test
all =
    [ fromAuthJsonTests
    ]


fromAuthJsonTests : Test
fromAuthJsonTests =
    describe "User.fromAuthJson"
        [ test "builds a User struct" <|
            \() ->
                """
                {
                    "user": {
                        "email": "foo@bar.baz",
                        "token": "hello-token"
                    }
                }
                """
                    |> decodeString User.fromAuthJson
                    |> equal
                        (Ok
                            { email = "foo@bar.baz"
                            , token = "hello-token"
                            }
                        )
        ]
