module Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected, eventCategories, isEventCategorySelected, set, view)

import Html exposing (Html, div, input, text)
import Html.Attributes exposing (checked, class, style, type_)
import Html.Events exposing (onCheck)


type EventCategory
    = Academic
    | Work
    | Project
    | Award


eventCategories =
    [ Academic, Work, Project, Award ]


{-| Type used to represent the state of the selected event categories
-}
type SelectedEventCategories
    = EventCons{category : List(EventCategory, Bool)}


{-| Returns an instance of `SelectedEventCategories` with all categories selected

    isEventCategorySelected Academic allSelected --> True

-}
allSelected : SelectedEventCategories
allSelected =
    EventCons{category = List.map (\x -> (x, True)) eventCategories}

{-| Returns an instance of `SelectedEventCategories` with no categories selected

-- isEventCategorySelected Academic noneSelected --> False

-}
noneSelected : SelectedEventCategories
noneSelected =
    EventCons{category = List.map (\x -> (x, False)) eventCategories}

{-| Given a the current state and a `category` it returns whether the `category` is selected.

    isEventCategorySelected Academic allSelected --> True

-}
isEventCategorySelected : EventCategory -> SelectedEventCategories -> Bool
isEventCategorySelected category current =
    let
        (EventCons var) = current
    in
    List.member (category , True) var.category 
    

{-| Given an `category`, a boolean `value` and the current state, it sets the given `category` in `current` to `value`.

    allSelected |> set Academic False |> isEventCategorySelected Academic --> False

    allSelected |> set Academic False |> isEventCategorySelected Work --> True

-}
set : EventCategory -> Bool -> SelectedEventCategories -> SelectedEventCategories
set category value current =
    let
        (EventCons currentCategory) = current
        updateCat (cat, selected) = if cat == category then (cat, value) else (cat, selected)
        updateAll = List.map updateCat currentCategory.category
    in
        EventCons {category = updateAll}
    -- {current | category = updateAll}

checkbox : String -> Bool -> EventCategory -> Html ( EventCategory, Bool )
checkbox name state category =
    div [ style "display" "inline", class "category-checkbox" ]
        [ input [ type_ "checkbox", onCheck (\c -> ( category, c )), checked state ] []
        , text name
        ]


view : SelectedEventCategories -> Html ( EventCategory, Bool )
view model =
    let
        (EventCons util) = model
    in
    div [] (List.map (\(category , selected) -> checkbox (categoryToString category) selected category) util.category)

categoryToString : EventCategory -> String
categoryToString category =
    case category of
        Academic -> "Academic"
        Work -> "Work"
        Project -> "Project"
        Award -> "Award"
