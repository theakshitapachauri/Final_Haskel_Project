module Prompt where 

import System.Exit


prompt ::  String -> String -> (String -> Maybe a) -> (a -> IO b) -> IO b
prompt query help parse act = do
    putStrLn query
    input <- getLine
    if input == "quit"
    -- if input == "quit" || input == "n"
        then
            do
                putStrLn "Leaving game..."
                exitSuccess
    else if input == "help"
        then
            do
                putStrLn help
                prompt query help parse act
    else
        case parse input of
            Nothing -> do
                putStrLn "I didn't understand that."
                putStrLn help
                prompt query help parse act
            Just a -> act a


cls :: IO ()
cls = putStr "\ESC[2J"

goto :: (Int,Int) -> IO ()
goto (x,y) = putStr ("\ESC[" ++ show y ++ ";" ++ show x ++ "H")
            

        --     prompt queryMessage help parseMove return
        -- answer <- prompt "Are you ready?" "Press enter to start or type quit to quit the game" Just return
