module HVH
where

import Data.Char
import Data.List
import System.IO
import Board
import Prompt

gameH :: IO ()
gameH = do 
        hSetBuffering stdout NoBuffering
        gamestartH O 

gamestartH p = do input1 <- prompt "Please enter a board size n such that your Board will be of size n x n" "Type quit to quit game" Just return
                  let size = (read input1 :: Int)
                  let g = empty size
                  putStrLn (printhelp g)
                  run g p 

run :: Grid -> Player -> IO ()
run g p = do 
            cls
            goto (1,1)
            putGrid g
            run' g p

run' :: Grid -> Player -> IO ()  
run' g p
    | wins O g = putStrLn "Player O wins!\n"
    | wins X g = putStrLn "Player X wins!\n"
    | full g   = putStrLn "It's a draw!\n"
    | p == O   = do i <- getNat (printMove p) (printhelp g) 
                    case move g i p of
                        []   -> do putStrLn "ERROR: Invalid move"
                                   putStrLn (printMove p)
                                   run' g p
                        [g'] -> run g' (next p)
    | p == X   = do i <- getNat (printMove p) (printhelp g)
                    case move g i p of
                        []   -> do putStrLn "ERROR: Invalid move"
                                   putStrLn (printMove p)
                                   run' g p
                        [g'] -> run g' (next p)
                          
