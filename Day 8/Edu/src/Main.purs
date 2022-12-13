module Main where


-- #############
-- ## Imports ##
-- #############

import Prelude -- (Unit, bind, discard, map, show, ($))

import Effect         (Effect)
import Effect.Ref     (Ref, new, read, write)
import Effect.Unsafe  (unsafePerformEffect)
import Effect.Console (log)

import Data.Int    (fromString)
import Data.Array  (snoc, length, (..), filter, (!!), foldl)
import Data.Maybe  (fromJust)
import Data.String (singleton, toCodePointArray)
import Data.Foldable (traverse_, sum)

import Node.ReadLine (Interface, prompt, setLineHandler, setPrompt, createConsoleInterface, noCompletion)

import Partial.Unsafe (unsafePartial)

-- ##########
-- ## Main ##
-- ##########

main :: Effect Unit
main = do
  -- Variables to store the forest and its visibility
  forest <- new []
  readLines <- new 0
  
  -- Console interface to read stdin
  consoleInterface <- createConsoleInterface noCompletion
  setPrompt "" consoleInterface
  setLineHandler (lineHandler forest readLines consoleInterface) consoleInterface
  prompt consoleInterface


-- ######################
-- ## Helper functions ##
-- ######################

lineHandler :: Ref (Array (Array Int)) -> Ref Int -> Interface -> String -> Effect Unit
lineHandler forest readLines consoleInterface line = do
  -- Handle the input line
  --- Convert the input String to an array of Strings (each String is a single character)
  let stringArray = map singleton (toCodePointArray line)
  
  --- Convert the array of Strings to an array of Integers (each Integer is the height of a tree)
  let integerArray = unsafePartial (map fromJust (map fromString stringArray))
  
  --- Read the forest from the Ref (unpackedForest is an Array (Array Int))
  let unpackedForest = unsafePerformEffect (read forest)
  
  --- Append the array of Integers to the forest
  let expandedForest = snoc unpackedForest integerArray

  --- Write the new forest to the Ref
  write expandedForest forest
  
  -- Sentinel to know when to start the algorithm
  --- Increment the number of lines which have been read
  let unpackedReadLines = 1 + (unsafePerformEffect (read readLines))
  write unpackedReadLines readLines

  -- Start the algorithm
  --- If all lines have been read, then we can start the algorithm
  if unpackedReadLines == (length integerArray)
  then performAlgorithm forest
  else pure unit

  -- Continue reading the next line until EOF is reached
  --- Prompt the user for the next line
  prompt consoleInterface


performAlgorithm :: Ref (Array (Array Int)) -> Effect Unit
performAlgorithm forest = do
  -- Read the forest from the Ref (unpackedForest is an Array (Array Int))
  let unpackedForest = unsafePerformEffect (read forest)
  -- traverse_ log (map show unpackedForest)
  
  -- --- Part One ---

  -- Check the visibility of the forest row by row
  let checkedVisibility =  map (checkTreeRowVisibility unpackedForest) (0 .. ((length unpackedForest) - 1))
  -- traverse_ log (map show checkedVisibility)

  -- Count the number of visible trees
  let visibleTrees = sum (map length (map (filter (_ == true)) checkedVisibility))
  log $ "Number of visible trees: " <> show visibleTrees

  -- --- Part Two ---

  -- Check the visibility of the forest row by row
  let scenicScores =  map (checkTreeRowScenicScores unpackedForest) (0 .. ((length unpackedForest) - 1))
  -- traverse_ log (map show scenicScores)

  -- Count the number of visible trees
  let maxScenicScore = max (map max scenicScores)
  log $ "Maximum scenic score: " <> show maxScenicScore

  pure unit

-- --- Part One ---

checkTreeRowVisibility :: Array (Array Int) -> Int -> Array Boolean
checkTreeRowVisibility forest row = do
  -- log $ "Checking tree visibility at row " <> show row
  map (checkTreeVisibility forest row) (0 .. ((length forest) - 1))


checkTreeVisibility :: Array (Array Int) -> Int -> Int -> Boolean
checkTreeVisibility forest row column = do
  -- log $ "Checking tree visibility at column " <> show column
  let currentTree = unsafePartial (fromJust ((unsafePartial (fromJust (forest !! row))) !! column))
  let visibilityLeft  = checkVisibilityLeft  forest currentTree row (column - 1)
  let visibilityRight = checkVisibilityRight forest currentTree row (column + 1)
  let visibilityUp    = checkVisibilityUp    forest currentTree (row - 1) column
  let visibilityDown  = checkVisibilityDown  forest currentTree (row + 1) column
  visibilityLeft || visibilityRight || visibilityUp || visibilityDown


checkVisibilityLeft :: Array (Array Int) -> Int -> Int -> Int -> Boolean
checkVisibilityLeft forest currentTree row column = do
  if column < 0
  then true
  else do
    let leftTree =  unsafePartial (fromJust ((unsafePartial (fromJust (forest !! row))) !! column))
    if currentTree > leftTree
    then checkVisibilityLeft forest currentTree row (column - 1)
    else false


checkVisibilityRight :: Array (Array Int) -> Int -> Int -> Int -> Boolean
checkVisibilityRight forest currentTree row column = do
  if column >= length forest
  then true
  else do
    let rightTree =  unsafePartial (fromJust ((unsafePartial (fromJust (forest !! row))) !! column))
    if currentTree > rightTree
    then checkVisibilityRight forest currentTree row (column + 1)
    else false


checkVisibilityUp :: Array (Array Int) -> Int -> Int -> Int -> Boolean
checkVisibilityUp forest currentTree row column = do
  if row < 0
  then true
  else do
    let upTree =  unsafePartial (fromJust ((unsafePartial (fromJust (forest !! row))) !! column))
    if currentTree > upTree
    then checkVisibilityUp forest currentTree (row - 1) column
    else false


checkVisibilityDown :: Array (Array Int) -> Int -> Int -> Int -> Boolean
checkVisibilityDown forest currentTree row column = do
  if row >= length forest
  then true
  else do
    let downTree =  unsafePartial (fromJust ((unsafePartial (fromJust (forest !! row))) !! column))
    if currentTree > downTree
    then checkVisibilityDown forest currentTree (row + 1) column
    else false

-- --- Part Two ---

checkTreeRowScenicScores :: Array (Array Int) -> Int -> Array Int
checkTreeRowScenicScores forest row = do
  map (checkTreeScenicScore forest row) (0 .. ((length forest) - 1))


checkTreeScenicScore :: Array (Array Int) -> Int -> Int -> Int
checkTreeScenicScore forest row column = do
  let currentTree = unsafePartial (fromJust ((unsafePartial (fromJust (forest !! row))) !! column))
  let scenicScoreLeft  = checkScenicScoreLeft  forest currentTree row (column - 1) 0
  let scenicScoreRight = checkScenicScoreRight forest currentTree row (column + 1) 0
  let scenicScoreUp    = checkScenicScoreUp    forest currentTree (row - 1) column 0
  let scenicScoreDown  = checkScenicScoreDown  forest currentTree (row + 1) column 0
  scenicScoreLeft * scenicScoreRight * scenicScoreUp * scenicScoreDown


checkScenicScoreLeft :: Array (Array Int) -> Int -> Int -> Int -> Int -> Int
checkScenicScoreLeft forest currentTree row column scenicScore = do
  if column < 0
  then scenicScore
  else do
    let leftTree =  unsafePartial (fromJust ((unsafePartial (fromJust (forest !! row))) !! column))
    if currentTree > leftTree
    then checkScenicScoreLeft forest currentTree row (column - 1) (scenicScore + 1)
    else (scenicScore + 1)


checkScenicScoreRight :: Array (Array Int) -> Int -> Int -> Int -> Int -> Int
checkScenicScoreRight forest currentTree row column scenicScore = do
  if column >= length forest
  then scenicScore
  else do
    let rightTree =  unsafePartial (fromJust ((unsafePartial (fromJust (forest !! row))) !! column))
    if currentTree > rightTree
    then checkScenicScoreRight forest currentTree row (column + 1) (scenicScore + 1)
    else (scenicScore + 1)


checkScenicScoreUp :: Array (Array Int) -> Int -> Int -> Int -> Int -> Int
checkScenicScoreUp forest currentTree row column scenicScore = do
  if row < 0
  then scenicScore
  else do
    let upTree =  unsafePartial (fromJust ((unsafePartial (fromJust (forest !! row))) !! column))
    if currentTree > upTree
    then checkScenicScoreUp forest currentTree (row - 1) column (scenicScore + 1)
    else (scenicScore + 1)


checkScenicScoreDown :: Array (Array Int) -> Int -> Int -> Int -> Int -> Int
checkScenicScoreDown forest currentTree row column scenicScore = do
  if row >= length forest
  then scenicScore
  else do
    let downTree =  unsafePartial (fromJust ((unsafePartial (fromJust (forest !! row))) !! column))
    if currentTree > downTree
    then checkScenicScoreDown forest currentTree (row + 1) column (scenicScore + 1)
    else (scenicScore + 1)


-- --- Helpers ---
-- Maximum Int of an Array Int
max :: Array Int -> Int
max array = do
  let maxi = foldl (\acc x -> if x > acc then x else acc) 0 array
  maxi
