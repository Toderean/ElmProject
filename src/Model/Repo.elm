module Model.Repo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Json.Decode as De exposing(..)
import Html.Attributes exposing (name)


type alias Repo =
    { name : String
    , description : Maybe String
    , url : String
    , pushedAt : String
    , stars : Int
    }


view : Repo -> Html msg
view repo =
    let
    -- (Repo util) = repo
        nameView = h1[class "repo-name repo-url"][a[href repo.url][text repo.name]]
        descriptionView = case repo.description of
                        Just a -> p[class "repo-description"][text a]
                        Nothing -> p[class "repo-descripion"][text " "]
        -- urlView = a[class "repo-url", href repo.url][text repo.name]
        starsView = p[class "repo-stars"][text (String.fromInt repo.stars)]   
    in
        div [class "repo"] [
             nameView
            ,descriptionView
            -- ,urlView
            ,starsView
        ]


sortByStars : List Repo -> List Repo
sortByStars repos =
    List.sortBy .stars repos 


{-| Deserializes a JSON object to a `Repo`.
Field mapping (JSON -> Elm):

  - name -> name
  - description -> description
  - html\_url -> url
  - pushed\_at -> pushedAt
  - stargazers\_count -> stars

-}
decodeRepo : De.Decoder Repo
decodeRepo =
        De.map5 Repo
        (De.field "name" De.string)
        (De.maybe (De.field "description"  De.string))
        (De.field "html_url" De.string)
        (De.field "pushed_at" De.string)
        (De.field "stargazers_count" De.int)
