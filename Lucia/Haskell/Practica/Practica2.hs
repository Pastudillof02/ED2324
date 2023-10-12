import Test.QuickCheck
import Data.Char

--3,4,11,13,14,22 y 12

--EJERCICIO 3

reparte :: [a] -> ([a],[a])
--definimos los casos bases
reparte [] = ([],[]) 
reparte [x] = ([x],[])
--recursividad
reparte (x: y: xs) = (x: ys, y: zs)
    where
        (ys,zs) = reparte xs


--EJERCICIO 4
distintos :: Eq a => [a] -> Bool
distintos [] = True
distintos (x: xs) = not (x `elem` xs)  && distintos xs


--EJERCICIO 11

    --apartado a   
take' :: Int -> [a] -> [a]
take' n xs = [ x | (p,x) <- zip [0..n-1] xs]

    --apartado b
drop' :: Int -> [a] -> [a]
drop' n xs = [ x | (p,x) <- zip [0..] xs, n<=p]

    --apartado c  


--EJERCICIO 13
desconocida :: (Ord a) => [a] -> Bool
desconocida xs = and [x<=y | (x,y) <- zip xs (tail xs)]
{-ej: xs=[1,2,3] tail xs = [2,3]
compara (1,2), (2,3) sea cada par x<=y
sirve para saber si esta ordenada una lista-}


--EJERCICIO 14
inserta:: (Ord a) -> a -> [a] -> [a]
inserta x xs = take (<x) xs --i don't know mister
