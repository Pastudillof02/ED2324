-------------------------------------------------------------------------------
-- Student's name:
-- Student's group:
--
-- Data Structures. Grado en Informática. UMA.
-------------------------------------------------------------------------------

module DataStructures.Graph.EulerianCycle(isEulerian, eulerianCycle) where

import DataStructures.Graph.Graph
import Data.List

--H.1)
isEulerian :: Eq a => Graph a -> Bool
isEulerian g = and [mod(degree g vertex) 2 == 0 | vertex <- vertices g]

-- H.2)
remove :: (Eq a) => Graph a -> (a,a) -> Graph a
remove g (v,u) = removeNullVertex (deleteEdge g (v, u)) 0 (vertices g)
    where
        removeNullVertex :: (Eq a) => Graph a -> Int -> [a] -> Graph a
        removeNullVertex g' n v' 
            | n >= length v' = g'
            | degree g' (v' !! n) == 0 = removeNullVertex (deleteVertex g' (v' !! n)) (n+1) v'
            | otherwise = removeNullVertex g' (n+1) v'

-- H.3)
extractCycle :: (Eq a) => Graph a -> a -> (Graph a, Path a)
extractCycle g v0 = extractCycle' (remove g (v0, (head $ successors g v0))) (head $ successors g v0) [v0]
    where
        extractCycle' :: (Eq a) => Graph a -> a -> [a] -> (Graph a, Path a)
        extractCycle' g v0 list 
            | v0 == (head list) = (g, (list ++ [v0]))
            | otherwise = extractCycle' (remove g (v0, v1)) v1 (list ++ [v0])
            where
                v1 = head $ successors g v0

-- H.4)
connectCycles :: (Eq a) => Path a -> Path a -> Path a
connectCycles [] (y:ys) = (y:ys)
connectCycles xs (y:ys) = connect xs (y:ys) (firstTime y xs)
    where 
        firstTime y xs = head [n | n <- [0..length xs-1], (xs !! n) == y]
        connect xs yy n = [xs !! nn | nn <-[0..n-1]] ++ yy ++ [xs !! nn | nn <-[n+1..length xs-1]]

-- H.5)
vertexInCommon :: Eq a => Graph a -> Path a -> a
vertexInCommon g cycle = head [v | v <- vertices g, v `elem` cycle]

-- H.6) 
eulerianCycle :: Eq a => Graph a -> Path a
eulerianCycle g
    | isEulerian g == False = error "The given graph is not eulerian"
    | otherwise = eulerianCycle' (fst (extractCycle g (head $ vertices g))) (snd (extractCycle g (head $ vertices g)))
    where 
        eulerianCycle' g path
            | length (vertices g) == 0 = path
            | otherwise = eulerianCycle' graph (connectCycles path newPath)
            where
                (graph, newPath) = extractCycle g (vertexInCommon g path)
