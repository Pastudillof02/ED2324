-----------------------------------------------------------------
-- Ejercicio 4
-----------------------------------------------------------------

ackerman :: (Integer,Integer) -> Integer
ackerman (m,n) 
    | m == 0 = n+1
    | m > 0 && n == 0 = ackerman(m-1,1)
    | m > 0 && n > 0 = ackerman(m-1,ackerman(m,n-1))

-----------------------------------------------------------------
-- Ejercicio 5
-----------------------------------------------------------------

cerosUnos :: Integer -> (Integer,Integer)
cerosUnos 0 = (1,0)
cerosUnos 1 = (0,1)
cerosUnos x 
    | mod x 10 == 0 = (a + 1, b)
    | mod x 10 == 1 = (a, b + 1)
        where (a,b) = cerosUnos (div x 10)