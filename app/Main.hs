module Main where

import Board
import HVH  
import HVC
import Prompt
import System.Exit

gameLoop :: IO()
gameLoop = do 
        let help1 = "Press enter to start or type quit to quit the game"
        answer <- prompt "Are you ready? \nP.S: Don't worry if you feel stuck you can type help or quit at any time in the game." help1 Just return
        let queryMessage =  "Select one option and press <Enter>: \n 1) Human Vs Human \n 2) Human Vs Computer \n 3) Rules \n 4) Exit" 
        let help2 = "Select any option (1,2,3,4) from below and press enter"
        prompt queryMessage help2 Just parseMove
        gameLoop

main :: IO ()
main = do
        cls
        goto(1,1)
        putStrLn "Welcome to the Tic-Tac-Toe Game!!! \n"
        gameLoop

parseMove :: String -> IO()
parseMove "1" = do 
        gameH
        gameLoop        
parseMove "2" = do
        gameC
        gameLoop
parseMove "3" = do
        let rules = "To win, you must get your n marks in a row (vertically, horizontally, or diagonally), for an n x n matrix/grid, before the computer/another player does.\nPress Enter to return"
        prompt rules "Press enter to start or type quit/n to quit the game" Just return 
        gameLoop
parseMove "4" = do
        putStrLn "Leaving game..."
        exitSuccess
parseMove otherwise = do 
        let queryMessage = "ERROR: Invalid option"
        prompt queryMessage "Select any option (1,2,3,4) from above and press enter" Just parseMove
        gameLoop
        


