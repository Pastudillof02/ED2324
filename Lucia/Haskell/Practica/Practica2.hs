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
distintos [x] = True
distintos (x: xs) 
    | x `elem` xs = False --elem te dice si un valor esta en la lista
    | otherwise = distintos xs


--EJERCICIO 11

    --apartado a   
take' :: Int -> [a] -> [a]
take' :: n xs = [ ?| (p,x) <- zip [0.. ??] xs]

    --apartado b
drop' :: Int -> [a] -> [a]
drop' n xs = [?? | (p,x) <- zip [??] xs, ??]

    --apartado c propiedades 