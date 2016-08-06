module Auth.State
    exposing
        ( Model
        , Page(Login, Registration)
        , FieldName(Email, Password, PasswordAgain)
        , FieldState
        , Msg(ChangePage)
        , init
        )


type Status
    = Ok
    | Error String


type Page
    = Login
    | Registration


type alias FieldState =
    { value : String, status : Status }


type FieldName
    = Email
    | Password
    | PasswordAgain


type alias Model =
    { page : Page
    , email : FieldState
    , password : FieldState
    , passwordAgain : FieldState
    }


type Msg
    = ChangePage Page


init : Model
init =
    { page = Login
    , email = fieldInit
    , password = fieldInit
    , passwordAgain = fieldInit
    }


fieldInit : FieldState
fieldInit =
    { value = ""
    , status = Ok
    }
