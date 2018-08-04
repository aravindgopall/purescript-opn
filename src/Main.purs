module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)
import Data.Maybe (Maybe(..))
import Node.ChildProcess (CHILD_PROCESS, defaultExecOptions, exec)

foreign import open ::forall eff. String -> Eff eff Unit
foreign import process :: forall vals. { | vals}



main :: forall e. Eff (console :: CONSOLE, cp :: CHILD_PROCESS | e) Unit
main = do
  openBrowser "https://www.google.com" Nothing
  log "Hello sailor!"


openBrowser :: forall eff. String -> Maybe String -> Eff (cp :: CHILD_PROCESS, console :: CONSOLE | eff) Unit
openBrowser str mArgs = exec (getArgsWithCmd str mArgs)  defaultExecOptions (\resp -> logShow resp.stderr *> logShow resp.stdout)


getArgsWithCmd :: String -> Maybe String -> String
getArgsWithCmd str mArgs = 
  let cmd = getCmd
      in case mArgs of 
           Just val -> cmd <> str <>" --args" <> val
           Nothing -> cmd <> str

getCmd :: String
getCmd = case process.platform of 
          "darwin" -> "open "
          "android" -> "xdg-open "

          _ -> "cmd "
