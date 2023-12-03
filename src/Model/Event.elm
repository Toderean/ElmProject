module Model.Event exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (Interval)
import Html.Attributes exposing (title)
import Html.Attributes exposing (href)
import List exposing (sortBy)


type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }


categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"


sortByInterval : List Event -> List Event
sortByInterval events = 
    List.sortWith (\event1 event2 -> Interval.compare event1.interval event2.interval) events

convert_from_maybe : Maybe String -> String
convert_from_maybe url = 
    case url of 
            Nothing -> " "
            Just u -> u
view : Event -> Html Never
view event =
    let
            isTrue a = True && a
    in
        div [class "event", classList [ ("event-important", event.important) ] ] 
         [
            h1 [class "event-title"] [text event.title]
            ,p [class "event-description"] [event.description]
            ,p [class "event-category"][categoryView event.category]
            ,a [class "event-url", href (convert_from_maybe event.url)][text (convert_from_maybe event.url)]   
            ,p [class "event-interval"][Interval.view event.interval]  
         ]   