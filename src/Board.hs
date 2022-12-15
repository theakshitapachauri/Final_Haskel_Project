module Board
where

import Data.Char
import Data.List
import System.IO
import Prompt

type Grid = [[Player]]

data Player = O | B | X
              deriving (Eq, Ord, Show)

next :: Player -> Player
next O = X
next B = B
next X = O

-- Grid utilities

--create Grid [[B,B,B][B,B,B][B,B,B]]
empty :: Int -> Grid 
empty size = replicate size (replicate size B)

--checks whether the grid is full 
--returns True if ther is no B in the grid
full :: Grid -> Bool
full = all (/= B) . concat

-- turn takes in the Grid and check whose turn it is to play by checking the number of "X" or "O"
-- if the count of X is smaller than O it is X's chance else O's.
turn :: Grid -> Player
turn g = if os <= xs then O else X
         where
            os = length (filter (== O) ps)
            xs = length (filter (== X) ps)
            ps = concat g

-- wins checks which player won by checking if: 
-- *any* of the rows or col or diags is of *all* same Player
-- rows ++ cols ++ dias creates a list of lists containing all rows, cols and diagonals
-- checking if *any* of rows / cols / diagonals have *all* same Player (eg X,X,X)
wins :: Player -> Grid -> Bool
wins p g = any line (rows ++ cols ++ dias)
           where
              line = all (== p)
              rows = g
              cols = transpose g
              dias = [diag g, diag (map reverse g)]

--diag returns diagonal as list
diag :: Grid -> [Player]
-- diag g = [g !! n !! n | n <- [0..size-1]]
diag g = zipWith (!!) g [0..] 

--won calls wins with current grid
won :: Grid -> Bool
won g = wins O g || wins X g

-- Displaying a grid

putGrid :: Grid -> IO ()
putGrid g =
   (putStrLn . unlines . concat . interleave bar . map showRow) g
   where bar = [replicate (((length g)*4)-1) '-']

--foldr1 applies (zipWith (++)) to the last two items of list; concatenates every element of list
-- zipWith(++) applies ++ to both the lists (interleave bar and showPlayer)
showRow :: [Player] -> [String]
showRow = applyf . interleave bar . map showPlayer
          where
             applyf = foldr1 (zipWith (++))
             bar    = ["|"]

showPlayer :: Player -> [String]
showPlayer O = [" O "]
showPlayer X = [" X "]
showPlayer B = ["   "] 

--interleave inserts a between every element of the list and return the final modified list
interleave :: a -> [a] -> [a]
interleave x []     = []
interleave x [y]    = [y]
interleave x (y:ys) = y : x : interleave x ys

-- Making a move

--valid checks if the move choosen in the form of digit is valid or not by:
-- checking i should be greater than equal to 0
-- i < size * size or 3*3
-- (concat g) at (indice i) should be equal to B
valid :: Grid -> Int -> Bool
valid g i = 0 <= i && i < (length g)^2 && concat g !! i == B

-- move takes in Grid, user input i, Player (X or O)
-- checks if i is valid
-- converts list into matrix/grid using chop 
-- chop 3 ([B,B,B] ++ [X] ++ [B,B,B,B,B,B])
-- (xs,B:ys) = splitAt i (concat g) : concat g converts grid into single list,
-- than splitAt i list : splits the list at i and return the first list and the remaining list
-- xs : stores the first list, while B:ys stores the second list with ys containing remaining elements - B
-- then (xs ++ [p] ++ ys) inserts [p] at place of B
-- chop 3 ([B,B,B] ++ [X] ++ [B,B,B,B,B,B]) converts the list back to grid with [p] inserted at the place i.
move:: Grid -> Int -> Player -> [Grid]
move g i p =
   if valid g i then [chop (length g) (xs ++ [p] ++ ys)] else []
   where (xs,B:ys) = splitAt i (concat g)

-- Chops chop list in number of lists each containing n elements
-- or converts a single list to grid structure 
chop :: Int -> [a] -> [[a]]
chop n [] = []
chop n xs = take n xs : chop n (drop n xs)

-- Reading a natural number
-- getNat :: String -> IO Int
-- getNat p = do xs <- getLine
--               if xs /= [] && all isDigit xs then
--                   return (read xs-1)
--               else
--                   do putStrLn "ERROR: Invalid number"
--                      getNat p

getNat :: String -> String -> IO Int
getNat p h = do xs <- prompt p h Just return
                if xs /= [] && all isDigit xs then
                  return (read xs-1)
                else
                  do putStrLn "ERROR: Invalid number"
                     getNat p h

printMove :: Player -> String
printMove p = "Player " ++ show p ++ ", enter your move: "

printhelp :: Grid -> String
printhelp g = "\nEnter number from 1 - " ++ show (length(concat g)) ++ " for the index you wanna play your move on\n or type quit to quit game"


