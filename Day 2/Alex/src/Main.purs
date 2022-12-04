module Main where

import Prelude

import Data.Either (Either(..))
import Effect (Effect)
import Effect.Aff (Aff, runAff_, makeAff, nonCanceler)
import Effect.Class (liftEffect)
import Effect.Console (log)
import Node.ReadLine (Interface, createConsoleInterface, noCompletion, close)
import Node.ReadLine as ReadLine
import Control.Monad.Loops (whileM)
import Data.String (split)
import Data.String.Pattern (Pattern(..))
import Data.Array (length, head, tail)

-- This is `affQuestion` from the previous file
question :: String -> Interface -> Aff String
question message interface = makeAff go
  where
    -- go :: (Either Error a -> Effect Unit) -> Effect Canceler
    go runAffFunction = nonCanceler <$
      ReadLine.question message (runAffFunction <<< Right) interface


main :: Effect Unit
main = do
  log "\n\n" -- separate output from program

  log "Creating interface..."
  interface <- createConsoleInterface noCompletion
  log "Created!\n"
                                                                               {-
  runAff_ :: forall a. (Either Error a -> Effect Unit) -> Aff a -> Effect Unit -}
  runAff_
    -- Ignore any errors and output and just close the interface
    (\_ -> closeInterface interface)
    (useInterface interface)
  where
    closeInterface :: Interface -> Effect Unit
    closeInterface interface = do
      log "Now closing interface"
      close interface
      log "Finished!"

    -- Same code as before, but without the Pyramid of Doom!
    useInterface :: Interface -> Aff Unit
    useInterface interface = do
      liftEffect $ log "Requesting user input..."


      -- Request user input until EOF is reached

      -- answer1 <- interface # question "Type something here (1): "
      -- liftEffect $ log $ "You typed: '" <> answer1 <> "'\n"

      -- Ask for unpit while the user input is not empty
      _ <- whileM
        (do
          answer <- question "Type something here (2): " interface
          liftEffect $ log $ "You typed: '" <> answer <> "'\n"
          let a = split (Pattern " ") answer
          liftEffect $ log $ head a
          
          -- Access to the second element of answer
          -- answer_split <- split (Pattern " ") answer
          -- first_player <- head answer_split
          -- second_player <- tail answer_split
          -- liftEffect $ log $ "First player: '" <> first_player <> "'\n"
          -- liftEffect $ log $ "Second player: '" <> second_player <> "'\n"
          pure $ answer /= ""
        )
        (pure unit)


      liftEffect $ log "Finished!"
