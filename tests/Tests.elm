module Tests exposing (..)

import Test exposing (..)
import Auth.ValidationTests


all : Test
all =
    describe "All tests" <|
        []
            ++ Auth.ValidationTests.all
