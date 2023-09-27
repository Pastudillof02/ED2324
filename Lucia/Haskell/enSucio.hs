-------------------------------------------------------------------------------
-- Estructuras de Datos. 2º Curso. ETSI Informática. UMA
--
-- Titulación: Grado en Ingeniería del Software.
-- Alumno: ROSALES SANTIAGO, LUCIA
-- Fecha de entrega: 27 | 9 | 2023
--
-- Relación de Ejercicios 1. Ejercicios resueltos: ..........
--
-------------------------------------------------------------------------------
import Test.QuickCheck


--EJERCICIO 1--
esTerna :: (Num a, Eq a) => a -> a -> a -> Bool
esTerna x y z = (x*x + y*y) == z*z

terna :: Integer -> Integer -> (Integer,Integer,Integer)
terna x y | x>y = (x^2-y^2,2*x*y,x^2+y^2)
          | otherwise = error "No es pitagorica"

p_ternas x y = x>0 && y>0 && x>y ==> esTerna l1 l2 h
    where
         (l1,l2,h) = terna x y


--EJERCICIO 2--
intercambia :: (a,b) -> (b,a)
intercambia (x,y) = (y,x)


--EJERCICIO 3--
ordena2 :: Ord a => (a,a) -> (a,a)
ordena2 (x,y) | x<y = (x,y)
              | otherwise = (y,x)


p1_ordena2 x y = enOrden (ordena2 (x,y))
    where 
        enOrden (x,y) = x<=y

p2_ordena2 x y = mismosElementos (x,y) (ordena2 (x,y))
    where
        mismosElementos (x,y) (z,v) = (x==z && y==v) || (x==v && y==z)


ordena3 :: Ord a => (a,a,a) -> (a,a,a)
ordena3 (x,y,z) | z<fst(ordena2(x,y)) = (z, fst(ordena2(x,y)), snd(ordena2(x,y)))
                | z<snd(ordena2(x,y)) = (fst(ordena2(x,y)), z, snd(ordena2(x,y)))
                | otherwise = (fst(ordena2(x,y)), snd(ordena2(x,y)), z)


p1_ordena3 x y z = enOrden (ordena3 (x,y,z))
    where 
        enOrden (x,y,z) = x<=y && y<=z

p2_ordena3 x y z = mismosElementos (x,y,z) (ordena3 (x,y,z))
    where
        mismosElementos (x,y,z) (f,v,c) = (x==f && y==v && z==c)
                                       || (x==v && y==z && z==c)

--EJERCICIO 4--
max2 :: Ord a => a -> a -> a
max2 x y | x<y = y
         | otherwise = x


p1_max2 x y = maximo(max2 x y)
    where 
        maximo m = m==x || m==y

p2_max2 x y = mayor(max2 x y)
    where 
        mayor m = m>=x && m>=y

-- me falta la prueba 3 y 4 

--EJERCICIO 5--
entre :: Ord a => a -> (a,a) -> Bool
entre x (minimo,maximo) = (x>=minimo && x<=maximo)


--EJERCICIO 6--
iguales3 :: Eq a => (a,a,a) -> Bool
iguales3 (x,y,z) = (x==y && x==z)


--EJERCICIO 7--
type TotalSegundos = Integer
type Horas = Integer
type Minutos = Integer
type Segundos = Integer

descomponer :: TotalSegundos -> (Horas,Minutos,Segundos)
descomponer x = (horas, minutos, segundos)
    where
        horas = div x 3600
        minutos = div(mod x 3600) 60
        segundos = mod(mod x 3600) 60


p_descomponer x = x>=0 ==> h*3600 + m*60 + s == x
                            && entre m (0,59)
                            && entre s (0,59)
    where (h,m,s) = descomponer x


--EJERCICIO 8--
unEuro :: Double
unEuro = 166.386

pesetasAEuros :: Double -> Double
pesetasAEuros x = x/y
        where 
            y =unEuro

eurosAPesetas :: Double -> Double
eurosAPesetas x = x*y
        where 
            y =unEuro

p_inversas x = eurosAPesetas (pesetasAEuros x) == x 


--EJERCICIO 9--
infix 4 ~= 
(~=) :: Double -> Double -> Bool
x ~= y = abs (x-y) < epsilon
    where epsilon = 1/1000

p1_inversas x = eurosAPesetas (pesetasAEuros x) ~= x 


--EJERCICIO 10--
raices :: Double -> Double -> Double -> (Double, Double)
raices x y z | (y^2-4*x*z)<0 = error "Raices negativas"
             | otherwise = ((-y + sqrt(y^2-4*x*z))/2*z, (-y - sqrt(y^2-4*x*z))/2*z)


p1_raices a b c = esRaíz r1 && esRaíz r2
    where
        (r1,r2) = raices a b c
        esRaíz r = a*r^2 + b*r + c ~= 0

{-p2_raíces a b c =  &&  ==> esRaíz r1 && esRaíz r2
 where
    (r1,r2) = raíces a b c
    esRaíz r = a*r^2 + b*r + c ~= 0
-}

--1, 5, 7, 10, 14