-- REPASO T1 -- 
import Data.Char
import Test.QuickCheck

-- pag 5
-- factorial :: Integer -> Integer
-- factorial 0 = 1
-- factorial n | n > 0 = n * factorial(n-1)  

-- pag 18
-- Convierte una letra minuscula en mayuscula
g, g' :: Char -> Char
g x = chr(ord x + ord 'A' - ord 'a') --no uso de la libreria
g' x = toUpper x --usando la libreria Data.Char

-- pag 20
twice :: Integer -> Integer
twice x = x + x

square :: Integer -> Integer
square x = x * x

pythagoras :: Integer -> Integer -> Integer
pythagoras x y  = square x + square y


-- pag 22
maxInteger :: Integer -> Integer -> Integer
maxInteger x y  = if x>=y then x else y 

-- pag 23
-- sin condicionales
{-
factorial :: Integer -> Integer
factorial 0 = 1
factorial n | n > 0 = n * factorial(n-1)  
-}
-- con condicionales
fact :: Integer -> Integer
fact n = if n == 0 then 1 else n * fact(n-1)

-- pag 36
second :: Integer -> Integer -> Integer
second x y  = y

-- pag 41
succPred :: Integer -> (Integer, Integer)
succPred x = (x+1,x-1)

-- pag 42
-- Funciones predefinidas
{-
fst :: (a,b) -> a
fst (x,y) = x

snd :: (a,b) -> b
snd (x,y) = y
-}
-- pag 47 
{-
twice :: Integer -> Integer
twice x = x + x
-}

--Con clases de tipo
twice' :: (Num a) => a -> a
twice' x = x + x

-- pag 52
--guardas
{-
sign :: (Eq a, Ord a, Num a) => a -> a
sign x | x>0 = 1
       | x<0 = -1
       | x==0 = 0
-}

--con otherwise
sign :: (Eq a, Ord a, Num a) => a -> a
sign x | x>0 = 1
       | x<0 = -1
       | otherwise = 0


-- pag 56

--definicion de locales, where
    --area de cilindro
circArea :: Double -> Double
circArea r = pi*r^2

rectArea :: Double -> Double -> Double
rectArea b h = b*h

circLength :: Double -> Double
circLength r = 2*pi*r

cylinderArea :: Double -> Double -> Double
cylinderArea r h = 2*circ + rect
    where
        circ = circArea r 
        l = circLength r
        rect = rectArea l h

{- LO MISMO PERO CON EL LET IN 
cylinderArea :: Double -> Double -> Double
cylinderArea r h =
    let
        circ = circArea r 
        l = circLength r
        rect = rectArea l h
    in
        2*circ + rect
-}
    --area de circulo
areaCirc :: Double -> Double 
areaCirc radio = pi * radioCuadrado
    where
        radioCuadrado = radio*radio

    --verificar si un nº es par o impar
esParOImpar :: Int -> String
esParOImpar x = if esPar x then "Es par" else "Es impar"
    where
        esPar x = x `mod` 2 == 0 

    --devision con resto y cociente
divisionConResto :: Int -> Int -> (Int, Int)
divisionConResto dividendo divisor =
  (cociente, resto)
  where
    cociente = dividendo `div` divisor
    resto = dividendo `mod` divisor

    --max de 3 numeros
maximoDeTres :: Ord a => a -> a -> a -> a
maximoDeTres x y z = maxXY `max` z
  where
    maxXY = max x y

-- pag 57 
-- infix 4 ~= 
-- (~=) :: Double -> Double -> Bool
-- x ~= y = abs (x-y) < epsilon
--     where 
--             epsilon = 1/1000


-- RELACION T1 --

-- ACT 1
esTerna :: Integer -> Integer -> Integer -> Bool
esTerna x y z = x^2 + y^2 == z^2

terna :: Integer -> Integer -> (Integer,Integer,Integer)
terna x y |  x>y = (x^2-y^2,2*x*y,x^2+y^2)
          | otherwise = error "No es pitagorica"


p_ternas x y = x>0 && y>0 && x>y ==> esTerna l1 l2 h
    where
         (l1,l2,h) = terna x y


-- ACT 2
intercambia :: (a,b) -> (b,a)
intercambia (x,y) = (y,x)


-- ACT 3
ordena2 :: Ord a => (a,a) -> (a,a)
ordena2 (x,y) | x>y = (y,x)
              | otherwise = (x,y)

-- otra alternativa
ordena2' :: Ord a => (a,a) -> (a,a)
ordena2' (x,y) = if x>y then (y,x) else (x,y)

p1_ordena2 x y = enOrden (ordena2 (x,y))
    where 
            enOrden (x,y) = x<=y
            
p2_ordena2 x y = mismosElementos (x,y) (ordena2 (x,y))
    where
         mismosElementos (x,y) (z,v) = (x==z && y==v) || (x==v && y==z) 
         --mismosElementos (x,y) (z,v) = (x,y)==(z,v) || (x,y)==(v,z) 

ordena3 :: Ord a => (a,a,a) -> (a,a,a)
ordena3 (x,y,z) | z < fst(ordena2(x,y)) = (z, fst(ordena2(x,y)), snd (ordena2(x,y)))
                | z < snd (ordena2(x,y)) && z > fst(ordena2(x,y)) = (fst (ordena2(x,y)), z, snd (ordena2(x,y)))
                | otherwise = (fst (ordena2(x,y)), snd(ordena2(x,y)), z)

p1_ordena3 x y z = enOrden (ordena3 (x,y,z))
    where 
            enOrden (x,y,z) = x<=y && y<=z
            
p2_ordena3 x y z = mismosElementos (x,y,z) (ordena3 (x,y,z))
    where
         mismosElementos (x,y,z) (w,v,t) = (x,y,z)==(w,v,t) || (x,y,z)==(t,v,w)


-- ACT 4

max2 :: Ord a => a -> a -> a
max2 x y  | x>=y = x
          | otherwise = y

p1_max2 x y  = resultado(max2 x y)
    where
        resultado res = res==x || res==y

p2_max2 x y  = resultado(max2 x y)
    where
        resultado res = res>=x && res>=y

p3_max2 x y  = resultado(max2 x y)
    where
        resultado res = x>=y && res==x

p4_max2 x y  = resultado(max2 x y)
    where
        resultado res = y>=x && res==y


-- ACT 5 
entre :: Ord a => a -> (a,a) -> Bool
entre x (minimo,maximo) = (x>= minimo && x<=maximo)


-- ACT 6 
iguales3 :: Eq a => (a,a,a) -> Bool
iguales3 (x,y,z) = x==y && x==z


-- ACT 7
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

p_descomponer x = x>=0 ==> h*3600 + m*60 + s == x && entre m (0,59) && entre s (0,59)
    where 
        (h,m,s) = descomponer x


-- ACT 8

unEuro :: Double
unEuro = 166.386

type Pesetas = Double
type Euros = Double

pesetasAEuros :: Pesetas -> Euros
pesetasAEuros x = euros
        where
            euros = x/unEuro

eurosAPesetas :: Euros -> Pesetas
eurosAPesetas x = x*unEuro

--p_inversas x = eurosAPesetas (pesetasAEuros x) == x


-- ACT 9 
infix 4 ~= 
(~=) :: Double -> Double -> Bool
x ~= y = abs (x-y) < epsilon
    where 
        epsilon = 1/1000

p_inversas x = eurosAPesetas (pesetasAEuros x) ~= x


-- ACT 10
raices :: Double -> Double -> Double -> (Double, Double)
--raices :: (Floating a, Ord a) => a -> a -> a -> (a,a) otra forma
raices x y z | (y^2 - 4*x*z) >=0 = ((-y + sqrt (y^2 - 4*x*z))/ 2*x, (-y - sqrt (y^2 - 4*x*z ))/ 2*x)
             | otherwise = error "Raices no reales"

p1_raices a b c = esRaíz r1 && esRaíz r2
    where
        (r1,r2) = raices a b c
        esRaíz r = a*r^2 + b*r + c ~= 0

-- p2_raices a b c = discriminante>0 && a>0 ==> esRaíz r1 && esRaíz r2
--     where
--         discriminante = b^2 - 4*a*c
--         (r1,r2) = raices a b c
--         esRaíz r = a*r^2 + b*r + c ~= 0

-- ACT 11
esMultiplo :: (Integral a) => a -> a -> Bool
esMultiplo x y | y>0 = ((mod x y) == 0) 
               | otherwise = False


-- ACT 12
infixl 1 ==>>
(==>>) :: Bool -> Bool -> Bool
False ==>> y = True
True ==>> True  = True
True ==>> False  = False


-- ACT 13 
esBisiesto :: Integer -> Bool
esBisiesto x =  (mod x 4 == 0) && (mod x 100 == 0 ==>> mod x 400 == 0)


-- ACT 14 
potencia :: Integer -> Integer -> Integer
potencia x y | y == 0 = 1
             | y==1 = x
             | y>1 = x * (potencia x (y-1))
             | otherwise = error "Exponente no natural"


potencia' :: Integer -> Integer -> Integer
potencia' x y   | y == 0 = 1
                | otherwise = imp * (potencia' x (expo `div` 2))^2
    where
      expo = if even y then y else y-1 --para saber si resto o no el -1 en el exponente
      imp = if even y then 1 else x --para saber si multiplico o no la b
      --tengo el odd tmb
      
      
p_pot b n = n>=0 ==> potencia b n == sol && potencia' b n == sol
    where 
         sol = b^n


-- ACT 15 
factorial :: Integer -> Integer
factorial x | x == 0 = 1
            | otherwise = x * (factorial(x-1))


-- ACT 16
divideA :: Integer -> Integer -> Bool
divideA x y = mod y x == 0

p1_divideA x y = y/=0 && y `divideA` x ==> div x y * y == x

p2_divideA x y z =  x/=0  && x `divideA` y &&  x `divideA` z ==>  x `divideA` (y+z)


-- ACT 17
mediana :: Ord a => (a,a,a,a,a) -> a
mediana (x,y,z,t,u)    | x > z = mediana (z,y,x,t,u)
                       | y > z = mediana (x,z,y,t,u)
                       | t < z = mediana (x,y,t,z,u)
                       | u < z = mediana (x,y,u,t,z)
                       | otherwise = z


























































































