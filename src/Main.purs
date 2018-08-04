module Main where

import Prelude

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log, logShow)
import Data.Maybe (Maybe(..))
import Node.ChildProcess (CHILD_PROCESS, defaultExecOptions, exec)

foreign import process :: forall vals. { | vals}

main :: forall e. Eff (console :: CONSOLE, cp :: CHILD_PROCESS | e) Unit
main = do
  openBrowser "https://www.google.com" Nothing
  log "Hello sailor!"


openBrowser :: forall eff. String -> Maybe String -> Eff (cp :: CHILD_PROCESS, console :: CONSOLE | eff) Unit
openBrowser str mArgs = exec (getCmd str mArgs)  defaultExecOptions (\resp -> logShow resp.stderr *> logShow resp.stdout)

getCmd :: String -> Maybe String ->String
getCmd val mArgs= case process.platform of 
          "darwin" -> "open " <> val <> " --args --" <> (show mArgs)
          "android" -> "xdg-open " <> val 
          _ -> "cmd start " <> val <> (show mArgs)  
