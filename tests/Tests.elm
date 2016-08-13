module Tests exposing (..)

import List
import Test exposing (..)
import Auth.ValidationTests
import UserTests
import Server.JsonTests


all : Test
all =
    describe "All tests" <|
        List.concat
            [ Auth.ValidationTests.all
            , Server.JsonTests.all
            , UserTests.all
            ]
