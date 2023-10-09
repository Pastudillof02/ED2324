import Tema3
import Data.Char --necesario importarlo aunque este importado en el otro modulo

f4 :: Integer -> Integer -> Integer
f4 x y = even (f1 x y) 

f5 :: Char -> Char
f5 c = f3(f3 c) --devuelve el siguiente caracter