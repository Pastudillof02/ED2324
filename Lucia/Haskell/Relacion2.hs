----------------------------    TEMA 2   ---------------------------------------

import Test.QuickCheck

len :: [a] -> Int --calcula el nº de elem de la lista
len xs = if null xs then 0 else 1 + len(tail xs)

--la longitud de una concatenacion de cadenas tiene que ser igual a la suma de la longitud de cada cadena
p1 xs ys = len xs + len ys == len(xs ++ ys) --sin precondicion
--quickCheck (p1 :: [Char] -> [Char] -> Bool) el prefiere que hagamos las pruebas asi

--PATRONES, es como utilizar un if else con los distintos casos
f :: [Int] -> Int
f [] = 0     -- como funciona cuando recibe una lista vacia
f [x] = 2*x  -- como funciona cuando recibe una lista con un elemento, aqui es necesario el nombre dado que la x se utiliza en el calculo del resultado por eso no se puede poner _
f [x,y] = x + y
-- estos patrones son para cuando tienes exactamentes n elementos


f1 :: [Int] -> Int
f1 [] = 0              -- como funciona cuando recibe una lista vacia
f1 (x:xs) = 1 + f1 xs  -- como funciona cuando recibe una lista con al menos un elemento


--me devuelve true si sus elementos estan ordenados en orden ascendente por ej [10,10,30,70] ó [10,30,70]
sorted :: (Ord a) => [a] -> Bool --debe ser de tipo ordenable pq utiliza el operador <=
sorted [] = True
sorted [x] = True --como el elemento no se utiliza no hace falta darle un nombre y podrías ponerle [_] donde _ puede ser cualquier dato
sorted (x:y:zs) = x <= y && sorted(y:zs)


--con acumuladores:
sumatorio :: Integer -> Integer
sumatorio n = aux 0 necesario
    where
        | aux ac 0 = ac
        | aux ac n | n>0 = aux (ac+n) (n-1)


--longitud de una lista con parametros acumuladores
long :: [a] -> Int
long xs = aux 0 xs
    where
        | aux ac [] = ac
        | axu ac (x:xs) = aux (ac+1) xs


toma :: Int -> [a] -> [a]
toma 0 _ = []
toma _ [] = []
toma n (x:xs)
    | n>0 = x : toma (n-1) xs
    | otherwise = []



--argumentos simples x y z
--argumentos compuestos xs ys zs