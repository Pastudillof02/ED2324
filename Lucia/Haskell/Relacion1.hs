import Test.QuickCheck --para hacer pruebas es importante importarlo

-- EJERCICIO 1 --
    -- apartado a --
esTerna :: Integer -> Integer -> Integer -> Bool
esTerna x y z = if (x^2 + y^2) == z^2 then True else False
--Recuerda que True y False primera con mayusc

    -- apartado b --
terna :: Integer -> Integer -> (Integer, Integer, Integer)
terna x y | x>y = (x^2-y^2, 2*x*y, x^2+y^2)
--Para multiplicar utilizar * y si para la salida quiero mas de un numero
--ponerlo entre parentesis y separarlo con comas

    -- apartado c NO LO ENTIENDO-- 
--p_ternas x y = x>0 && y>0 && x>y ==> esTerna 11 12 h
  --where (11,12,h) = terna x y

    -- apartado d NO LO ENTIENDO--


-- EJERCICIO 2 --
intercambia :: (a,b) -> (b,a)
intercambia (x,y) = (y,x)


-- EJERCICIO 3 --
    -- apartado a --
ordena2 :: Ord a => (a,a) -> (a,a)
ordena2 (x,y) | x>y = (y,x)
              | otherwise = (x,y)
--utilizar el otherwise como el else 

--p1_ordena2 x y = enOrden (ordena2 (x,y))
--where enOrden (x,y) = x<=y

--p2_ordena2 x y = mismosElementos (x,y) (ordena2 (x,y))
--where mismosElementos (x,y) (z,v) = (x==z && y==v) || (x==v && y==z)


    -- apartado b --
ordena3 :: Ord a => (a,a,a) -> (a,a,a)
ordena3 (x,y,z) | z < fst(ordena2(x,y)) = (z,fst(ordena2(x,y)), snd(ordena2(x,y)))
                | z < snd(ordena2(x,y)) && z>fst(ordena2(x,y)) = (fst(ordena2(x,y)),z, snd(ordena2(x,y)))
                | otherwise = (fst(ordena2(x,y)),snd(ordena2(x,y)),z)


-- EJERCICIO 4 --
    -- apartado a --
max2 :: Ord a => a -> a -> a
max2 x y | x<y = y
         | otherwise = x

    -- apartado b --
p1_max2 x y = coincide(max2 x y)
    where 
        coincide m = m==x || m==y
  

p2_max2 x y = mayor(max2 x y)
    where 
        mayor m = m>=x && m>=y


p3_max2 x y = mayorx(max2 x y)
    where 
        mayorx m = x>=y && x==x


p4_max2 x y = mayory(max2 x y)
    where 
        mayory m = y>=x && y==y


-- EJERCICIO 5 --
entre :: Ord a => a -> (a,a) -> Bool 
entre x (minimo,maximo) | x>=minimo && x<=maximo = True
                        | otherwise = False


-- EJERCICIO 6 --
iguales3 :: Eq a => (a,a,a) -> Bool
iguales3 (x,y,z) = x==y && x==z 
                 

-- EJERCICIO 7 -- 
--Funciones predefinidas --> div para el cociente, mod para el resto de la division
-- type sirve para que sea mas legible el codigo para crear sinonimos
type TotalSegundos = Integer 
type Horas = Integer
type Minutos = Integer
type Segundos = Integer

descomponer :: TotalSegundos -> (Horas,Minutos,Segundos)
descomponer x = (horas, minutos, segundos)
    where
        horas = div x 3600
        minutos = div (mod x 3600) 60
        segundos = mod (mod x 3600) 60
















