module MsgTools exposing (sendMsg)

import Task


{-| This function gives you a way to trigger a re-run of the top level update
function with a new Msg. This is useful when you need a higher level component
to react to the Msg.

If you need to re-run the update function of just the current module just call
the function normally. :)
-}
sendMsg : a -> Cmd a
sendMsg msg =
    Task.perform
        never
        identity
        (Task.succeed msg)


never : a -> b
never =
    (\_ -> Debug.crash "This failure cannot happen.")
