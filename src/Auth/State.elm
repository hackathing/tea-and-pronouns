module Auth.State
    exposing
        ( Model
        , Page(Login, Registration)
        , FieldName(Email, Password, PasswordAgain)
        , FieldState
        , FieldStatus(Valid, Invalid)
        , FormStatus(Ready, Waiting)
        , AuthCredentials
        , Msg(..)
        , init
        )


type FieldStatus
    = Valid
    | Invalid String


type FormStatus
    = Ready
    | Waiting


type Page
    = Login
    | Registration


type FieldName
    = Email
    | Password
    | PasswordAgain


type alias FieldState =
    { value : String, status : FieldStatus }


type alias Model =
    { page : Page
    , email : FieldState
    , password : FieldState
    , passwordAgain : FieldState
    , status : FormStatus
    }


type Msg
    = ChangePage Page
    | ChangeEmail String
    | ChangePassword String
    | ChangePasswordAgain String
    | Submit
    | DoRegister { email : String, password : String }
    | DoLogin { email : String, password : String }
    | AuthFail


type alias AuthCredentials =
    { email : String
    , password : String
    }


init : Model
init =
    { page = Login
    , email = fieldInit
    , password = fieldInit
    , passwordAgain = fieldInit
    , status = Ready
    }


fieldInit : FieldState
fieldInit =
    { value = ""
    , status = Valid
    }
