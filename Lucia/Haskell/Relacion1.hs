import Test.QuickCheck --para hacer pruebas es importante importarlo

--comentario de una linea
{-comentario de mas de una linea-}

-- EJERCICIO 1 --
    -- apartado a --
esTerna :: Integer -> Integer -> Integer -> Bool
esTerna x y z = (x^2) + (y^2) == (z^2)
--Recuerda que True y False primera con mayusc

    -- apartado b --
terna :: Integer -> Integer -> (Integer, Integer, Integer)
terna x y | x>y = (x^2-y^2, 2*x*y, x^2+y^2)
{-Para multiplicar utilizar * y si para la salida quiero mas de un numero
ponerlo entre parentesis y separarlo con comas-}

    -- apartado c y d -- 
p_ternas x y = x>0 && y>0 && x>y ==> esTerna l1 l2 h
    where 
        (l1,l2,h) = terna x y



-- EJERCICIO 2 --
intercambia :: (a,b) -> (b,a)
intercambia (x,y) = (y,x)


-- EJERCICIO 3 --
    -- apartado a --
ordena2 :: Ord a => (a,a) -> (a,a)
ordena2 (x,y) | x>y = (y,x)
              | otherwise = (x,y)
--utilizar el otherwise como el else 

--Main> quickCheck p1_ordena2 colocarlo asi en la terminal
p1_ordena2 x y = enOrden (ordena2 (x,y))
    where 
        enOrden (x,y) = x<=y

p2_ordena2 x y = mismosElementos (x,y) (ordena2 (x,y))
    where 
        mismosElementos (x,y) (z,v) = (x==z && y==v) || (x==v && y==z)


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

    -- apartado a --
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

    -- apartado b --
p_descomponer x = x>=0 ==> h*3600 + m*60 + s == x
                           && entre m (0,59)
                           && entre s (0,59)
    where  (h,m,s) = descomponer x  


-- EJERCICIO 8 --
unEuro :: Double  --esto es como definir una cte
unEuro = 166.386

    -- apartado a --
pesetasAEuros :: Double -> Double
pesetasAEuros x = x/unEuro

    -- apartado b --
eurosAPesetas :: Double -> Double
eurosAPesetas x = x*unEuro

    -- apartado c --
--p_inversas x = eurosAPesetas (pesetasAEuros x) == x


-- EJERCICIO 9 -- 
infix 4 ~=  --indica la precedencia del operador
(~=) :: Double -> Double -> Bool --declaracion del operador, como es personalizado por eso lo hacemos con una funcion
x ~= y = abs (x-y) < epsilon --definicion del operador, epsilon es una cte que definimos en where
    where epsilon = 1/1000

p_inversas x = eurosAPesetas (pesetasAEuros x) ~= x


-- EJERCICIO 10 --
    -- apartado a --
raices :: Double -> Double -> Double -> (Double, Double)
raices a b c | b*b - 4*a*c<0  = error "Raices no reales" --para lanzar un mensaje de error
             | otherwise = ((-b + sqrt(b*b - 4*a*c)) / 2*a, (-b - sqrt(b*b - 4*a*c)) / 2*a)

    -- apartado b --
p1_raices a b c = esRaiz r1 && esRaiz r2
 where
    (r1,r2) = raices a b c
    esRaiz r = a*r^2 + b*r + c ~= 0


-- NO ME DA BIEN CORREGIR
 {-p2_raices a b c = a>0 && b*b - 4*a*c>=0 ==> esRaiz r1 && esRaiz r2
 where
    (r1,r2) = raices a b c
    esRaiz r = a*r^2 + b*r + c ~= 0
-}

-- EJERCICIO 11 --
esMúltiplo :: (Integral a) => a -> a -> Bool 
--La clase Integral es util para cuando vaya a hacer calculos con nº enteros
esMúltiplo x y | y>0 = ((mod x y) == 0) 
               | otherwise = False


-- EJERCICIO 12  no entendi hacer--
infixl 1 ==>>
(==>>) :: Bool -> Bool -> Bool
False ==>> y = True --si el primer argumento es F independientemente del valor del segundo parametro vale T
True ==>> False = False --cuando el primer argumento es T el resultado final depende del segundo argumento
True ==>> True = True

-- EJERCICIO 13  revisar-- 
esBisiesto :: Integer -> Bool
esBisiesto x = esMúltiplo x 4 ==>> esMúltiplo x 100 ==>> esMúltiplo x 400


-- EJERCICIO 14 repetir esta mal--
potencia :: Integer -> Integer -> Integer
potencia x y | y==0 = 1
             | y>0 = x*(potencia x (y-1))
             | otherwise = error "Exponente no natural"

potencia' :: Integer -> Integer -> Integer
potencia' x y | y==0 = 1
              | y==1 = x
              | y==2 = x*x
              | y>2 && (mod y 2 ==0) = potencia' (potencia' x (div y 2)) 2 
              | y>2 && (mod y 2 /=0) = potencia' (potencia' x (div (y-1) 2)) 2
              |otherwise = error "Exponente no natural"


-- EJERCICIO 15 --
factorial :: Integer -> Integer
factorial x | x==0 =1
            | x>0 = x * factorial(x-1) 
            | otherwise = error "Factorial negativo"


-- EJERCICIO 16  repetir--
divideA :: Integer -> Integer -> Bool
divideA x y = (mod y x) ==0

--p1_divideA x y = y/=0 && y `divideA` x  ==> div x y * y == x

--p2_divideA x y z = x/=0 && x `divideA` y && x `divideA` z ==> x `divideA` (y+z) 


-- EJERCICIO 17 no c --
mediana :: Ord a => (a,a,a,a,a) -> a
mediana (x,y,z,t,u)  | x > z = mediana (z,y,x,t,u)
                     | y > z = mediana (x,z,y,t,u)
                     | z > t = mediana (x,y,t,z,u) 
                     | z > u = mediana (x,y,u,t,z)
                     | otherwise = z


jj









