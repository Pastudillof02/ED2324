module SetMultiMap( SetMultiMap
                        , empty
                        , isEmpty
                        , size
                        , isDefinedAt
                        , insert
                        , deleteKey
                        , deleteKeyValue
                        , valuesOf
                        --, filterValues
                        --, fold
                        ) where
import Data.List (intercalate)
import Test.QuickCheck
import qualified DataStructures.Set.LinearSet as S

-- Invariante de representación:
-- - Los nodos están ordenados por clave
-- - No hay claves repetidas
-- - No hay claves que tengan asociado un conjunto vacío

data SetMultiMap a b = Empty
                    | Node a (S.Set b) (SetMultiMap a b)
                    deriving Eq

--Ejemplo para ir probando las funciones
m1 :: SetMultiMap String Int
m1 = Node "alfredo" (mkSet [9]) (Node "juan" (mkSet[0,1,8]) (Node "maria" (mkSet[4,-6,8]) Empty))

mkSet :: Eq a => [a] -> S.Set a
mkSet = foldr S.insert S.empty

--Ejercicio 1. Completa en SetMultiMap.hs las definiciones de las funciones empty, isEmpty, size,
--isDefinedAt, insert, valuesOf, deleteKey, deleteKeyValue, y filterValues. Completa además el
--comentario indicando la clase de complejidad a la que pertenece cada función.

--Empty
--Complejidad O(1)
empty :: SetMultiMap a b
empty = Empty

--isEmpty
--Complejidad O(1)
isEmpty :: SetMultiMap a b -> Bool
isEmpty Empty = True
isEmpty _ = False

--size
--k --> clave
--v --> conjunto de valores
--s --> resto de tuplas (k,v)
-- Complejidad O(n)

size :: SetMultiMap a b -> Integer
size Empty = 0
size (Node _ s ms) = (S.size s) + (size ms)

--Node a (S.Set b) (SetMultiMap a b)

--isDefinedAt
-- >>> isDefinedAt "maria" m1 => True
-- >>> isDefinedAt "eva" m1 => False
-- Complejidad : O(n)
isDefinedAt :: (Ord a, Eq a) => a -> SetMultiMap a b -> Bool
isDefinedAt kx Empty = False
isDefinedAt kx (Node ky s ms)
    | kx == ky = True
    | otherwise = isDefinedAt kx ms


-- 1 pto.
-- |
-- >>> insert "alfredo" 5 m1
-- "alfredo" --> LinearSet(9,5)
-- "juan" --> LinearSet(8,1,0)
-- "maria" --> LinearSet(8,-6,4)
--
-- >>> insert "carmen" 20 m1
-- "alfredo" --> LinearSet(9)
-- "carmen" --> LinearSet(20)
-- "juan" --> LinearSet(8,1,0)
-- "maria" --> LinearSet(8,-6,4)
-- Complejidad: O(n*m)

--esta implementación no está bien jaja, no se introduce de forma ordenada
insert :: (Ord a, Eq b) => a -> b -> SetMultiMap a b -> SetMultiMap a b
insert kx v Empty = Node kx (S.insert v S.empty) Empty
insert kx v (Node ky ls ms) 
    | kx == ky = (Node ky (S.insert v ls) ms)
    | kx > ky = Node ky ls (insert kx v ms)
    | otherwise = (Node kx (S.insert v S.empty) (Node ky ls ms))

--DeleteKey
--Complejidad: 
-- >>> deleteKey "juan" m1
-- "alfredo" --> LinearSet(9)
-- "maria" --> LinearSet(8,-6,4)

deleteKey :: (Ord a, Eq b) => a -> SetMultiMap a b -> SetMultiMap a b
deleteKey _ Empty = Empty
deleteKey kx (Node ky ls ms) 
    | kx == ky = ms 
    | otherwise = Node ky ls (deleteKey kx ms)

-- 1 pto.
-- |
-- >>> deleteKeyValue "maria" 4 m1
-- "alfredo" --> LinearSet(9)
-- "juan" --> LinearSet(8,1,0)
-- "maria" --> LinearSet(8,-6)
-- Complejidad: O(n*m)

deleteKeyValue :: (Ord a, Eq b) => a -> b -> SetMultiMap a b -> SetMultiMap a b
deleteKeyValue _ _ Empty = Empty
deleteKeyValue kx v (Node ky ls ms)
    | kx == ky = if(S.size(S.delete v ls) == 0) then deleteKey ky (Node ky ls ms) else (Node ky (S.delete v ls) ms)
    | otherwise = Node ky ls (deleteKeyValue kx v ms)

-- 1 pto.
-- |
-- >>> valuesOf "maria" m1
-- Just LinearSet(8,-6,4)
--
-- >>> valuesOf "paco" m1
-- Nothing
-- Complejidad: O(n)

valuesOf :: (Ord a, Eq b) => a -> SetMultiMap a b -> Maybe(S.Set b)
valuesOf _ Empty = Nothing
valuesOf kx (Node ky ls ms)
    | kx == ky = Just ls
    | otherwise = valuesOf kx ms

-- 1,25 ptos.
-- |
-- >>> filterValues (> 0) m1
-- "alfredo" --> LinearSet(9)
-- "juan" --> LinearSet(8,1)
-- "maria" --> LinearSet(8,4)
-- Complejidad: 

filterValues :: (Ord a, Eq b) => (b -> Bool) -> SetMultiMap a b -> SetMultiMap a b
filterValues _ Empty = Empty
filterValues p (Node ky ls ms) 
    | S.size(myFilter) == 0 = filterValues p (deleteKey ky (Node ky ls ms))
    | otherwise = Node ky myFilter (filterValues p ms)
    
    where
        myFilter = S.fold (\x s -> if(p x) then S.insert x s else s) S.empty ls

------------------------------ NO EDITAR EL CÓDIGO DE ABAJO ------------------------
------
fold :: (Ord a, Eq b) => (a -> b -> c -> c) -> c -> SetMultiMap a b -> c
fold f z ms = recSetMultiMap ms
    where
        recSetMultiMap Empty = z
        recSetMultiMap (Node k s ms)
            | S.isEmpty s = recSetMultiMap ms
            | otherwise = f k v (recSetMultiMap (Node k s' ms))
            where
                (v, s') = pickOne s
                pickOne s = (v, S.delete v s)
                    where v = head $ S.fold (:) [] s

instance (Show a, Show b) => Show(SetMultiMap a b) where
 show Empty = "{}"
 show ms = intercalate "\n" (showKeyValues ms)
    where
        showKeyValues Empty = []
        showKeyValues (Node k s ms) = (show k ++ " --> " ++ show s) : showKeyValues ms

instance (Ord a, Arbitrary a, Eq b, Arbitrary b) => Arbitrary (SetMultiMap a b)
    where
        arbitrary = do
        xs <- listOf arbitrary
        ys <- listOf arbitrary
        return (foldr (uncurry insert) empty (zip xs ys))

