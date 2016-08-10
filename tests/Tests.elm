module Tests exposing (..)

import List
import Test exposing (..)
import Auth.ValidationTests
import UserTests


all : Test
all =
    describe "All tests" <|
        List.concat
            [ Auth.ValidationTests.all
            , UserTests.all
            ]
