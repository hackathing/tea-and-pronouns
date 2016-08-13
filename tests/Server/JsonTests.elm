module Server.JsonTests exposing (all)

import Test exposing (..)
import Expect exposing (..)
import Server.Json


all : List Test
all =
    [ authTests
    ]


authTests : Test
authTests =
    describe "Server.Json.auth"
        [ test "encodes an email and password" <|
            \() ->
                { email = "one@two.three", password = "magicpass" }
                    |> Server.Json.auth
                    |> equal
                        ("""{"user":"""
                            ++ """{"email":"one@two.three","""
                            ++ """"password":"magicpass"}}"""
                        )
        ]
