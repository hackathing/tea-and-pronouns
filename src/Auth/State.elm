module Auth.State
    exposing
        ( Model
        , Page(Login, Registration)
        , FieldName(Email, Password, PasswordAgain)
        , FieldState
        , Status(Valid, Invalid)
        , Msg(..)
        , init
        )


type Status
    = Valid
    | Invalid String


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
    | ChangeEmail String
    | ChangePassword String
    | ChangePasswordAgain String
    | Submit
    | DoRegister { email : String, password : String }


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
    , status = Valid
    }
