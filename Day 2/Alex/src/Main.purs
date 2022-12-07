module Main where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff, runAff_, runAff, makeAff, nonCanceler, Canceler)
import Effect.Aff as Aff
import Effect.Class (liftEffect)
import Effect.Console (log)
-- import Node.ReadLine (Interface, createConsoleInterface, noCompletion, close)
import Node.ReadLine as ReadLine
import Control.Monad.Loops (whileM)
import Data.String (length)
import Data.String.Common (split)
import Data.String.Pattern (Pattern(..))
import Partial.Unsafe (unsafePartial, unsafeCrashWith)
import Data.Array (head, tail)
import Data.Array as Array
import Data.Maybe (Maybe(..), fromMaybe, fromJust)

import Node.ReadLine (prompt, close, setLineHandler, setPrompt,  noCompletion, createConsoleInterface)

unsafeIndex :: forall a. Array a -> Int -> a
unsafeIndex arr idx =
  if idx == 0 then do
      case (head arr) of
        Just a -> a
        Nothing -> unsafeCrashWith "The inserted position is no available"
  else do
      case (tail arr) of
        Just b -> unsafeIndex b (idx - 1)
        Nothing -> unsafeCrashWith "The array is too short"

-- win:: String -> String -> Int
-- win myChoice opponent = do


checkGame :: String -> String -> Int
checkGame player1 player2 = do
  case player1 of 
    "A" -> 1
    "B" -> 3
    "C" -> 5
    _ -> 0



main :: Effect Unit
main = do
  interface <- createConsoleInterface noCompletion
  setPrompt "> " interface
  prompt interface
  let 
    count = 0
  interface # setLineHandler \s ->
    if s == "quit"
      then close interface
      else do
          let
            arr = split (Pattern " ") s
            player1 = unsafeIndex arr 0
            player2 = unsafeIndex arr 1
          log $ "You typed: " <> player1 <> " " <> player2 <> ":" <> show ((checkGame player1 player2) + count)
          prompt interface