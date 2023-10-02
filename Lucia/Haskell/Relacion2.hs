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
{-sumatorio :: Integer -> Integer
sumatorio n = aux 0 necesario
    where
        | aux ac 0 = ac
        | aux ac n 
        | n>0 = aux (ac+n) (n-1)
-}

--longitud de una lista con parametros acumuladores
{-long :: [a] -> Int
long xs = aux 0 xs
    where
        | aux ac [] = ac
        | aux ac (x:xs) = aux (ac+1) xs


toma :: Int -> [a] -> [a]
toma 0 _ = []
toma _ [] = []
toma n (x:xs)
    | n>0 = x : toma (n-1) xs
    | otherwise = []

-}
--take 10(map (*10) [1,3..]) si coloco esto en la consola me coge 10 elementos de la lista infinita y me los multiplica cada uno por 10
--take 10(filter (>100) (map (*10) [1,3..])) 


--argumentos simples x y z
--argumentos compuestos xs ys zs
-- para definir una lista infinita [1,3..]

{-
Cada pareja son equivalencias
[ x^2 | x <- [1..10]]
map (^2) [1..10]

[ x | x <- [1..10], x>5]
filter (>5) [1..10]

[ x^2 | x <- [1..10], x>5]
map (^2) (filter (>5) [1..10])

foldr (\x y -> x+y) 10 [1,2,3]  
foldr add 10 [1,2,3]
foldl (+) 10 [1,2,3] -- al menos en este caso/operacion en otras no es asi


foldr (*) 1 [1,2,3,4]
foldr (\x y -> x*y) 1 [1,2,3,4]

foldr (:) [] [1,2,3,4] --añado elem, res [1,2,3,4]
foldr (\x xs -> x :xs) [] [1,2,3,4] 

foldr (\x xs -> xs ++ [x]) [] [1,2,3,4] --res [4,3,2,1] 
foldl (\xs x -> x : xs) [] [1,2,3,4] -- res [4,3,2,1] mejor utilizar este en el caso de que tenga que invertir una lista pq es mas eficiente

foldr (\x n -> n+1) 0 [1,2,3,4] calcula la longitud de la lista
foldl (\n x -> n+1) 0 [1,2,3,4]

foldr (\x xs -> if even x then x:xs else xs) [] [1,2,3,4] -- filtro y me quedo con los pares


map (f 10 20) [1,2,3] -- es correcto debido a q es una funcion que espera un argumento para producir un resu

map (map suma10) [[1,2,3], [4,5], [6,7,8]] --esto esta bien
map (map (+10)) [[1,2,3], [4,5], [6,7,8]] --esto esta bien
map (map suma10) [1,2,3] --esto estaria mal, porque espera una lista de sublistas

-}

isMultipleOf :: Integer -> Integer -> Bool
isMultipleOf y x = mod x y ==0

{- si pongo lo siguiente en la consola :t isMultipleOf 3
isMultipleOf 3 :: Integer -> Bool esta es la funcion que me devuelve 
con esa funcion puedo aplicarla en filter por ej: filter(isMultipleOf 2) [1..10] pq requeria una funcion con esa estructura-}


esPar :: Integer -> Bool
esPar x = mod x 2 == 0 

misterio :: Integer -> Bool
misterio = not . esPar

-- Bool -> Bool     .     Integer -> Bool  =   Bool -> Bool 

--pag 45


























