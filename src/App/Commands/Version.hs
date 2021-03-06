{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE RecordWildCards     #-}
{-# LANGUAGE ScopedTypeVariables #-}

module App.Commands.Version
  ( cmdVersion
  ) where

import App.Commands.Options.Parser (optsVersion)
import Data.List
import Data.Semigroup              ((<>))
import Options.Applicative         hiding (columns)

import qualified App.Commands.Options.Types         as Z
import qualified Data.Text                          as T
import qualified Data.Version                       as V
import qualified HaskellWorks.CabalCache.IO.Console as CIO
import qualified Paths_cabal_cache                  as P

{-# ANN module ("HLint: ignore Reduce duplication"  :: String) #-}
{-# ANN module ("HLint: ignore Redundant do"        :: String) #-}

runVersion :: Z.VersionOptions -> IO ()
runVersion _ = do
  let V.Version {..} = P.version

  let version = intercalate "." $ fmap show versionBranch

  CIO.putStrLn $ "cabal-cache " <> T.pack version

cmdVersion :: Mod CommandFields (IO ())
cmdVersion = command "version"  $ flip info idm $ runVersion <$> optsVersion
