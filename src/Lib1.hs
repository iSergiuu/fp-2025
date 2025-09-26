module Lib1
  ( Path
  , Command(..)
  , examples
  , numExamples
  , dumpExamples
  , showCommand
  ) where

import Data.List (intercalate)

-- Path type
type Path = [String]

-- Command type
data Command
  = AddCategory Path String
  | AddGame Path String String Integer
  | Remove Path String
  | List Path
  | CountGames Path
  | DumpExamples
  deriving Eq

-- Show instance uses DSL formatting
instance Show Command where
  show = showCommand

-- List of example commands
examples :: [Command]
examples =
  [ AddCategory [] "Action"
  , AddCategory ["Action"] "Shooter"
  , AddGame ["Action","Shooter"] "Half-Life" "Valve" 1998
  , List ["Action"]
  , CountGames ["Action"]
  , Remove ["Action","Shooter"] "Half-Life"
  , DumpExamples
  ]

-- Number of examples
numExamples :: Int
numExamples = length examples

-- Dump examples
dumpExamples :: [Command]
dumpExamples = examples

-- Convert Command to DSL string
showCommand :: Command -> String
showCommand (AddCategory p name) = "add-category " ++ renderPath p ++ " " ++ name
showCommand (AddGame p t pub yr) = "add-game " ++ renderPath p ++ " \"" ++ t ++ "\" \"" ++ pub ++ "\" " ++ show yr
showCommand (Remove p name) = "remove " ++ renderPath p ++ " " ++ name
showCommand (List p) = "list " ++ renderPath p
showCommand (CountGames p) = "count-games " ++ renderPath p
showCommand DumpExamples = "dump examples"

-- Render a path as string
renderPath :: Path -> String
renderPath [] = "/"
renderPath segs = '/' : intercalate "/" segs