module Model.PersonalDetails exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, id)
import Html.Attributes exposing (href)


type alias DetailWithName =
    { name : String
    , detail : String
    }


type alias PersonalDetails =
    { name : String
    , contacts : List DetailWithName
    , intro : String
    , socials : List DetailWithName
    }


view : PersonalDetails -> Html msg
view details =
    div [] [h1 [id "name"] [text details.name]
            ,em [id "intro"][text details.intro]
            ,ul [] (List.map (\x -> p [class "contact-detail"][text (x.detail ++ " " ++ x.name)]) details.contacts)
            ,ul [] (List.map (\x -> a [class "social-link", href x.detail][text x.name]) details.socials)
            ]
