module HVC
where

import Data.Char
import Data.List
import System.IO
import Board
import HVH
import Tree
import Prompt

-- Human vs computer

gameC :: IO ()
gameC = do 
            hSetBuffering stdout NoBuffering
            gameStartC O

gameStartC p = do 
    input1 <- prompt "Please enter a board size n such that your Board will be of size n x n" "Type quit to quit game" Just return
    let size = (read input1 :: Int)
    let g = empty size
    play g p 

play :: Grid -> Player -> IO ()
play g p = do cls
              goto (1,1)
              putGrid g
            --   putStrLn ("Enter number from 1 - " ++ show (length(concat g)) ++ " for the index you wanna play your move on")
            --   putStrLn (printMove p)              
              play' g p

play' :: Grid -> Player -> IO ()
play' g p
    | wins O g = putStrLn "Player O wins!\n"
    | wins X g = putStrLn "Computer (X) wins!\n"
    | full g   = putStrLn "It's a draw!\n"
    | p == O   = do i <- getNat (printMove p) (printhelp g)       
                    case move g i p of
                        []   -> do putStrLn "ERROR: Invalid move"
                                   play' g p
                        [g'] -> play g' (next p)
    | p == X   = do putStr "Player X is thinking... "
                    (play $! (bestmove g p)) (next p)

