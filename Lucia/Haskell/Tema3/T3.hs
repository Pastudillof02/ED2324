----------------------------    TEMA 3   ---------------------------------------

{-
ESPECIFICACION:
    - Signatura/Interfaz -- nombre d las operaciones y los tipo q maneja
    - Conj de axiomas -- como se comportan, q hace

    La implementacion tiene q verificar todo los axiomas puestos


ESTRUCTURA DE DATOS PARA UNA PILA, Stack (LIFO = El ultimo q entra es el primero q sale)    

Tipo abstracto de Datos Queue (cola) organiza los elem de manera FIFO = el primer elem introducido es el primero en salir

Tipo abstracto de Datos Set (conjunto) organiza los elem sin que tengan un indice asociado y sin elem repetidos

Listas -> coleccion homogenea de valores, cada valor tiene asociada una posicion, puede haber repeticion

¡¡¡¡¡¡¡¡¡OJOOOOOOOOOOOO: hay que entregear siempre un fichero que cargue lo q no vaya ponerle undefined al metodo que no me vaya
o lo paso a comentarios!!!!!!!!!!!!!!!!!!!!!!!1

Patrones alias nombre@  (para cuando quiero acceder a todo el parametro completo)
Ej:
insert :: (Ord a) => a -> Set a -> Set a
insert x set@Empty = Node x set -- no se confunde con el otro pq son dos ecuaciones distintas de todas formas no se suele utilizar para el empty
insert x set@(Node y s) --set representa todo el conj es un alias
| x < y = Node x set --pq set representa al conj que tiene la y y la s
| x == y = set
| otherwise = Node y (insert x s)


FUNCION fold
(insert 3(insert 2 (insert 7 empty))) --creo conjunto, res= (2,3,7)
fold (+) 0 (insert 3(insert 2 (insert 7 empty)))  --res=12
fold (:) [] (insert 3(insert 2 (insert 7 empty)))  --res=convierte en una lista [2,3,7]

funcion de orden superior que podriamos definir, que dado un predicado y un conjunto con datos y me devuelve un nuevo conjunto con aquellos valores del conjunto pasado que cumplan el predicado
select :: (a -> Bool) -> Set a -> Set a
select p Empty = Empty
select p (Nodo x s)
    | p x = Nodo x (select p s) --cuando cumple predicado, añado ese elemento
    | otherwise = select p s --descarto ese elemento

ej:
select even (insert 3(insert 2 (insert 7 empty))) --creo conjunto, res= (2) pares
select odd (insert 3(insert 2 (insert 7 empty))) --creo conjunto, res= (3,7) impares
select (>2)) (insert 3(insert 2 (insert 7 empty))) --creo conjunto, res= (3,7) mayores que el valor 2

Cargar el fichero de axiomas, si la implementacion es correcta deberia funcionar
poner setAxioms en la terminal para que compruebe axioma por axioma y se me ejecuta el bloque completo


-}

module T3 (f1,f3) where --f1 y f3 se consideran publicas
--ojo q se tiene q llamar igual al fichero 

import Data.Char


f1 :: Integer -> Integer -> Integer
f1 x y = f2 x + 100

f2 :: Integer -> Integer
f2 x = 10*x + 5*x^2

f3 :: Char -> Char
f3 c = chr(1 + ord c)