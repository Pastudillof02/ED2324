import Test.QuickCheck

-- 3,4,11,13,14,22,12,34

-- EJERCICIO 3

reparte :: [a] -> ([a],[a])
reparte [x] = ([x],[])
reparte (x:y:xs) = (x:s1,y:s2)
    where (s1,s2) = reparte xs

--------------------------------------------------------------------------------

-- EJERCICIO 4

distintos :: Eq a => [a] -> Bool
distintos [] = True
distintos [x] = True
distintos (x:xs) = not (elem x xs) && distintos xs

--------------------------------------------------------------------------------

-- EJERCICIO 11

-- a)

_take :: Int -> [a] -> [a]
_take n xs = [x | (p,x) <- zip [0..(n-1)] xs]

-- b)

_drop :: Int -> [a] -> [a]
_drop n xs = [x | (p,x) <- zip [0..(length xs)-1] xs, p >= n]

--------------------------------------------------------------------------------

-- EJERCICIO 13

desconocida :: (Ord a) => [a] -> Bool
desconocida xs = and [x <= y | (x,y) <- zip xs (tail xs)]

-- Comprueba que la lista este ordenada de menor a igual

--------------------------------------------------------------------------------

-- EJERCICIO 14

-- a)

inserta :: (Ord a) => a -> [a] -> [a]
inserta x xs = s1 ++ [x] ++ s2
    where 
        s1 = takeWhile(<x) xs
        s2 = dropWhile(<x) xs

-- b) 

_inserta :: (Ord a) => a -> [a] -> [a]
_inserta y [] = [y]
_inserta y (x:xs) 
    | y <= x = y:x:xs
    | y > x = x:(_inserta y xs)

-- c) 

p1_inserta x xs = desconocida xs ==> desconocida (_inserta x xs)

-- e)

ordena :: (Ord a) => [a] -> [a]
ordena xs = foldr (_inserta) [] xs

-- f)

p1_ordena xs = desconocida (ordena xs)

--------------------------------------------------------------------------------

-- EJERCICIO 22

