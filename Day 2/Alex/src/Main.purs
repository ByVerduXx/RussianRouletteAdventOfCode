module Main where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff, runAff_, makeAff, nonCanceler, Canceler)
import Effect.Aff as Aff
import Effect.Class (liftEffect)
import Effect.Console (log)
import Node.ReadLine (Interface, createConsoleInterface, noCompletion, close)
import Node.ReadLine as ReadLine
import Control.Monad.Loops (whileM)
--import Data.String (length)
import Data.String.Common (split)
import Data.String.Pattern (Pattern(..))
import Data.Array (head, tail)
import Data.Array as Array
import Data.Maybe (Maybe(..), fromMaybe)

question :: String -> Interface -> Aff String
question message interface = makeAff go
  where
  go runAffFunction = nonCanceler <$
    ReadLine.question message (runAffFunction <<< Right) interface

run :: Interface -> Aff Unit
run interface = do
  liftEffect $ log $ "Welcome " <> name
  where 
    input = interface # question "What is your name?"
    name = head $ input # split (Pattern " ")

main :: Effect Unit
main = do
  interface <- createConsoleInterface noCompletion
  runAff_ (run interface) (const $ close interface)