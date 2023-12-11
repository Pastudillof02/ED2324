
-- EJERCICIO 4 --

func :: (Integer, Integer) -> Integer
func (x,y)  | x==0  = y+1
            | (x>0 && y==0) = func(x-1,1)
            | otherwise = func(x-1,func(x,y-1))


f1 :: (Ord a, Num a) => (a,a) -> a
f1 (x,y)    | x==0  = y+1
            | (x>0 && y==0) = f1(x-1,1)
            | otherwise = f1(x-1,f1(x,y-1))


-- EJERCICIO 5 --

cerosUnos :: Integer -> (Integer, Integer)
cerosUnos 0 = (1,0)
cerosUnos 1 = (0,1)
cerosUnos x | mod x 10 ==0 = (nceros+1,nunos)
            | otherwise = (nceros,nunos+1)
    where 
        (nceros,nunos) = cerosUnos(div x 10)
  