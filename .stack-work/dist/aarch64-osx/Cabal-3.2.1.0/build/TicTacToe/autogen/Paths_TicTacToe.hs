{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_TicTacToe (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/akshitapachauri/Desktop/FinalHaskelProject/Final_Haskel_PRoject/.stack-work/install/aarch64-osx/d4903dbeafe463b12205471e6a56dcde70c2c0409089edd06d76409e4925defb/8.10.7/bin"
libdir     = "/Users/akshitapachauri/Desktop/FinalHaskelProject/Final_Haskel_PRoject/.stack-work/install/aarch64-osx/d4903dbeafe463b12205471e6a56dcde70c2c0409089edd06d76409e4925defb/8.10.7/lib/aarch64-osx-ghc-8.10.7/TicTacToe-0.1.0.0-4x5RXWw90AU8q4a2wneiUI-TicTacToe"
dynlibdir  = "/Users/akshitapachauri/Desktop/FinalHaskelProject/Final_Haskel_PRoject/.stack-work/install/aarch64-osx/d4903dbeafe463b12205471e6a56dcde70c2c0409089edd06d76409e4925defb/8.10.7/lib/aarch64-osx-ghc-8.10.7"
datadir    = "/Users/akshitapachauri/Desktop/FinalHaskelProject/Final_Haskel_PRoject/.stack-work/install/aarch64-osx/d4903dbeafe463b12205471e6a56dcde70c2c0409089edd06d76409e4925defb/8.10.7/share/aarch64-osx-ghc-8.10.7/TicTacToe-0.1.0.0"
libexecdir = "/Users/akshitapachauri/Desktop/FinalHaskelProject/Final_Haskel_PRoject/.stack-work/install/aarch64-osx/d4903dbeafe463b12205471e6a56dcde70c2c0409089edd06d76409e4925defb/8.10.7/libexec/aarch64-osx-ghc-8.10.7/TicTacToe-0.1.0.0"
sysconfdir = "/Users/akshitapachauri/Desktop/FinalHaskelProject/Final_Haskel_PRoject/.stack-work/install/aarch64-osx/d4903dbeafe463b12205471e6a56dcde70c2c0409089edd06d76409e4925defb/8.10.7/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "TicTacToe_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "TicTacToe_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "TicTacToe_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "TicTacToe_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "TicTacToe_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "TicTacToe_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
