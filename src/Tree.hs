{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
module Tree 
where

import Board
import Data.Char
import Data.List
import System.IO

data Tree a = Node a [Tree a]
              deriving Show

-- gametree provides all possible moves left for the computer 
-- basically plays the whole game till the end from the current state of grid 
-- in order for the ai to choose the best move
gametree :: Grid -> Player -> Tree Grid
gametree g p = Node g [gametree g' (next p) | g' <- moves g p]


-- returns the choice of moves the player has
moves :: Grid -> Player -> [Grid]
moves g p | won g     = []
          | full g    = []
          | otherwise = concat [move g i p | i <- [0..(((length g)^2)-1)]]

-- prune prunes the branches of the tree upto n
-- prune 2 tree will return the tree with 2 depth level
-- returns the x(current state) and 
prune :: Int -> Tree a -> Tree a
prune 0 (Node x _)  = Node x []
prune n (Node x ts) = Node x [prune (n-1) t | t <- ts]

depth :: (Ord a, Num a, Num p) => a -> p
depth l | l > 6      = 2
        | l == 6     = 3
        | l == 5     = 4
        | l == 4     = 5
        | otherwise  = 9

-- Minimax

minimax :: Tree Grid -> Tree (Grid,Player)
minimax (Node g [])
   | wins O g  = Node (g,O) []
   | wins X g  = Node (g,X) []
   | otherwise = Node (g,B) []
minimax (Node g ts) 
   | turn g == O = Node (g, minimum ps) ts'
   | turn g == X = Node (g, maximum ps) ts'
                   where
                      ts' = map minimax ts
                      ps  = [p | Node (_,p) _ <- ts']

bestmove :: Grid -> Player -> Grid
bestmove g p = head [g' | Node (g',p') _ <- ts, p' == best]
               where 
                  tree = prune (depth (length g)) (gametree g p)
                  Node (_,best) ts = minimax tree
