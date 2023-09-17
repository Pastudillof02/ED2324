import Test.QuickCheck

-- EJERCICIO 1 --
esTerna :: Integer -> Integer -> Integer -> Bool
esTerna x y z = if (x^2 + y^2) == z^2 then True else False
--Recuerda que True y False primera con mayusc


terna :: Integer -> Integer -> (Integer, Integer, Integer)
terna x y | x>y = (x^2-y^2, 2*x*y, x^2+y^2)
--Para multiplicar utilizar * y si para la salida quiero mas de un numero
--ponerlo entre parentesis y separarlo con comas


-- EJERCICIO 2 --
intercambia :: (a,b) -> (b,a)
intercambia (x,y) = (y,x)


-- EJERCICIO 3 --
ordena2 :: Ord a => (a,a) -> (a,a)
ordena2 (x,y) | x>y = (y,x)
              | otherwise = (x,y)
--utilizar el otherwise como el else 

-- EJERCICIO 4 --
