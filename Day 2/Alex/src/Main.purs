module Main where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Effect.Console (log)
import Node.ReadLine as ReadLine
import Data.String (length)
import Data.String.Common (split)
import Data.String.Pattern (Pattern(..))
import Partial.Unsafe (unsafePartial, unsafeCrashWith)
import Data.Maybe (Maybe(..))
import Data.Array as Array
import Effect.Ref as Ref
import Node.ReadLine (Interface, prompt, close, setLineHandler, setPrompt,  noCompletion, createConsoleInterface)

infixr 8 mod as %
  
unsafeIndex :: forall a. Array a -> Int -> a
unsafeIndex arr idx =
  if idx == 0 then do
      case (Array.head arr) of
        Just a -> a
        Nothing -> unsafeCrashWith "The inserted position is no available"
  else do
      case (Array.tail arr) of
        Just b -> unsafeIndex b (idx - 1)
        Nothing -> unsafeCrashWith "The array is too short"


getPlayer1:: String -> Int
getPlayer1 choice = do
  case choice of 
    "A" -> 1
    "B" -> 2
    "C" -> 3
    _ -> 0

getPlayer2:: String -> Int
getPlayer2 choice = do
  case choice of 
    "X" -> 1
    "Y" -> 2
    "Z" -> 3
    _ -> 0    

-- Cases part 2:
-- X -> Lose:
--  1 - 3  = 1 mod 3 -> I lose
--  2 - 1  = 1 mod 3 -> I lose
--  3 - 2  = 1 mod 3 -> I lose
-- Y -> Draw:
--  1 - 1 = 0 mod 3 -> I draw
--  2 - 2 = 0 mod 3 -> I draw
--  3 - 3 = 0 mod 3 -> I draw
-- Z -> Win:
--  1 - 2 = 2 mod 3 -> I win
--  2 - 3 = 2 mod 3 -> I win
--  3 - 1 = 2 mod 3 -> I win

match :: Int -> Int -> Int -> Int -> Int
match player1Points player2Points result mod_ = do
    if (player1Points - player2Points) % mod_ == result then
        player2Points
    else
        match player1Points (player2Points + 1) result mod_

drawGame:: String -> String -> Int
drawGame player1 player2 = do
    let
        player1Choice = getPlayer1 player1
        player2Choice = case player2 of
            "X" -> match player1Choice 1 1 3 -- Loose
            "Y" -> match player1Choice 1 0 3 -- Draw
            "Z" -> match player1Choice 1 2 3 -- Win
            _ -> 0
        result = (player1Choice - player2Choice) % 3
    player2Choice + case result of
        0 -> 3 -- tie
        1 -> 0 -- player1 win
        2 -> 6 -- player2 win
        _ -> 0

-- Cases part 1:
-- A - Y = 8 --> 1 - 2 mod 3 = 2
-- B - X = 1 --> 2 - 1 mod 3 = 1
-- C - Z = 6 --> 3 - 3 mod 3 = 0

checkGame :: String -> String -> Int 
checkGame player1 player2 = do
  let
    player1Choice = getPlayer1 player1
    player2Choice = getPlayer2 player2
    result = (player1Choice - player2Choice) % 3
  player2Choice + case result of
    0 -> 3 -- tie
    1 -> 0 -- player1 win
    2 -> 6 -- player2 win
    _ -> 0

processInput :: Ref.Ref Int -> Ref.Ref Int -> String -> Effect Unit
processInput total1 total2 input = do
  let
    arr = split (Pattern " ") input
    player1 = unsafePartial $ unsafeIndex arr 0
    player2 = unsafePartial $ unsafeIndex arr 1
    result = checkGame player1 player2
    result2 = drawGame player1 player2
  currentTotal1 <- Ref.read total1  -- Read from the cell
  let newTotal = currentTotal1 + result 
  Ref.write newTotal total1        -- Write new value to the cell

  currentTotal2 <- Ref.read total2  -- Read from the cell
  let newTotal2 = currentTotal2 + result2
  Ref.write newTotal2 total2        -- Write new value to the cell

  log $ "You typed: " <> player1 <> " " <> player2 <> ": " <> show (result) <> ", current total is " <> show newTotal
  log $ "You typed: " <> player1 <> " " <> player2 <> ": " <> show (result2) <> ", current total is " <> show newTotal2

lineHandler :: Ref.Ref Int -> Ref.Ref Int -> Interface -> String -> Effect Unit
lineHandler total1 total2 interface s  = do
  if s == "quit"
    then do
      close interface
    else do
        processInput total1 total2 s
        prompt interface

main :: Effect Unit
main = do
  total1 <- Ref.new 0  -- Create a new memory cell with initial value of 0
  total2 <- Ref.new 0  -- Create a new memory cell with initial value of 0
  interface <- createConsoleInterface noCompletion
  setPrompt "> " interface
  setLineHandler (lineHandler total1 total2 interface) interface
  prompt interface  

    

