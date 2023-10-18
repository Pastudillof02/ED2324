----------------------------    TEMA 3   ---------------------------------------

{-
ESPECIFICACION:
    - Signatura -- nombre d las operaciones y los tipo q maneja
    - Conj de axiomas -- como se comportan, q hace

    La implementacion tiene q verificar todo los axiomas puestos


ESTRUCTURA DE DATOS PARA UNA PILA, Stack (LIFO = El ultimo q entra es el primero q sale)    

-}

module Tema3 (f1,f3) where --f1 y f3 se consideran publicas
--ojo q se tiene q llamar igual al fichero 

import Data.Char


f1 :: Integer -> Integer -> Integer
f1 x y = f2 x + 100

f2 :: Integer -> Integer
f2 x = 10*x + 5*x^2

f3 :: Char -> Char
f3 c = chr(1 + ord c)