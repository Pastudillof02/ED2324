import Test.QuickCheck

-----------------------------------------------------------------------------------------

empareja :: [a] -> [b] -> [(a,b)]
empareja xs ys = [(xs !! i, ys !! i) | i <- [0..min (length xs) (length ys) - 1]]

p1_empareja xs ys = zip xs ys == empareja xs ys

-----------------------------------------------------------------------------------------

emparejaCon :: (a -> b -> c) -> [a] -> [b] -> [c]
emparejaCon f xs ys = [f (xs !! i) (ys !! i) | i <- [0..min (length xs) (length ys) - 1]]

-----------------------------------------------------------------------------------------

separaRec :: (a -> Bool) -> [a] -> ([a],[a])
separaRec p xs = (filter p xs, filter (not . p) xs)

separaC ::  (a -> Bool) -> [a] -> ([a],[a])
separaC p xs = ([x | x <- xs, p x],[y | y <- xs, not (p y)])

separaP :: (a -> Bool) -> [a] -> ([a],[a])
separaP p xs = foldr f ([],[]) xs
  where f x (ys,zs) | p x       = (x:ys,zs)
                    | otherwise = (ys,x:zs)

-----------------------------------------------------------------------------------------

cotizacion :: [(String,Double)]
cotizacion = [("apple",116),("intel",35),( "google", 824),("nvidia", 67)]

buscarRec :: (Eq a) => a -> [(a,b)] -> [b]
buscarRec c [] = []
buscarRec c ((x,y):xs) 
  | c == x = [y]
  | otherwise = buscarRec c xs

buscarC :: (Eq a) => a -> [(a,b)] -> [b]
buscarC c xs = [y | (x,y) <- xs, x == c]

buscarP :: (Eq a) => a -> [(a,b)] -> [b]
buscarP c xs = foldr f [] xs
  where f (x,y) ys | c == x    = y:ys
                   | otherwise = ys

valorCartera :: [(String,Double)] -> [(String,Double)] -> Double
valorCartera xs ys = sum [v*v2 | (c,v) <- xs, (c2,v2) <- ys, c == c2]
