-------------------------------------------------------------------------------
-- Apellidos, Nombre: 
-- Titulacion, Grupo: 
--
-- Estructuras de Datos. Grados en Informatica. UMA.
-------------------------------------------------------------------------------

module AVLBiDictionary( BiDictionary
                      , empty
                      , isEmpty
                      , size
                      , insert
                      , valueOf
                      , keyOf
                      , deleteByKey
                      , deleteByValue
                      , toBiDictionary
                      , compose
                      , isPermutation
                      , orbitOf
                      , cyclesOf
                      ) where

import qualified DataStructures.Dictionary.AVLDictionary as D
import qualified DataStructures.Set.BSTSet               as S

import           Data.List                               (intercalate, nub,
                                                          (\\))
import           Data.Maybe                              (fromJust, fromMaybe,
                                                          isJust)
import           Test.QuickCheck


data BiDictionary a b = Bi (D.Dictionary a b) (D.Dictionary b a)

-- | Exercise a. empty, isEmpty, size

empty :: (Ord a, Ord b) => BiDictionary a b
empty = Bi D.empty  D.empty

isEmpty :: (Ord a, Ord b) => BiDictionary a b -> Bool
isEmpty (Bi x y) = if(D.isEmpty(x) && D.isEmpty(y)) then True else False

size :: (Ord a, Ord b) => BiDictionary a b -> Int
size (Bi x y) = D.size(x)

-- | Exercise b. insert

insert :: (Ord a, Ord b) => a -> b -> BiDictionary a b -> BiDictionary a b
insert key val dic =  Bi (D.insert key val l) (D.insert val key r)
  where
    Bi l r = deleteByKey key (deleteByValue val dic)
  

-- | Exercise c. valueOf

valueOf :: (Ord a, Ord b) => a -> BiDictionary a b -> Maybe b
valueOf k (Bi l r) = if D.isDefinedAt k l then Just (fromJust $ D.valueOf k l) else Nothing

-- | Exercise d. keyOf

keyOf :: (Ord a, Ord b) => b -> BiDictionary a b -> Maybe a
keyOf v (Bi l r) = if D.isDefinedAt v r then Just (fromJust $ D.valueOf v r) else Nothing

-- | Exercise e. deleteByKey

deleteByKey :: (Ord a, Ord b) => a -> BiDictionary a b -> BiDictionary a b
deleteByKey k dic@(Bi l r) = if D.isDefinedAt k l then Bi (D.delete k l) (D.delete (fromJust $ D.valueOf k l) r) else dic

-- | Exercise f. deleteByValue

deleteByValue :: (Ord a, Ord b) => b -> BiDictionary a b -> BiDictionary a b
deleteByValue v dic@(Bi l r) = if D.isDefinedAt v r then Bi (D.delete (fromJust $ D.valueOf v r) l) (D.delete v r) else dic

-- | Exercise g. toBiDictionary

esInyectiva :: (Ord a) => [a] -> Bool
esInyectiva [] = True
esInyectiva (x:xs) 
  |elem x xs = False
  |otherwise = esInyectiva xs

insertarRec :: (Ord a, Ord b) => [a] -> D.Dictionary a b -> BiDictionary a b -> BiDictionary a b
insertarRec [] d bi = bi
insertarRec (k:ks) d bi = insertarRec ks d (insert k (fromJust (D.valueOf k d)) bi)

toBiDictionary :: (Ord a, Ord b) => D.Dictionary a b -> BiDictionary a b
toBiDictionary d
  |esInyectiva (D.values d) = insertarRec (D.keys d) d empty
  |otherwise = error "No es inyectivo"

-- | Exercise h. compose

composeRec :: (Ord a, Ord b, Ord c) => [a] -> BiDictionary a b -> BiDictionary b c -> BiDictionary a c -> BiDictionary a c   
composeRec [] (Bi d1 d2) (Bi d3 d4) (Bi d5 d6) = (Bi d5 d6)     
composeRec (x:xs) b1@(Bi d1 d2) b2@(Bi d3 d4) b3
  | D.isDefinedAt (fromJust (D.valueOf x d1)) d3 = composeRec xs b1 b2 (insert x (fromJust (D.valueOf (fromJust (D.valueOf x d1)) d3)) b3)
  | otherwise = composeRec xs b1 b2 b3

compose :: (Ord a, Ord b, Ord c) => BiDictionary a b -> BiDictionary b c -> BiDictionary a c
compose b1@(Bi d1 d2) b2@(Bi d3 d4) = composeRec (D.keys d1) b1 b2 empty

-- | Exercise i. isPermutation

isPermutationRec :: Ord a => [a] -> [a] -> Bool
isPermutationRec [] _ = True
isPermutationRec k [] = False
isPermutationRec (k:ks) v 
  |elem k v == True =  isPermutationRec ks v 
  |otherwise = False

isPermutation :: Ord a => BiDictionary a a -> Bool
isPermutation (Bi d1 d2) = (isPermutationRec (D.keys d1) (D.values d1))



-- |------------------------------------------------------------------------


-- | Exercise j. orbitOf

orbitOf :: Ord a => a -> BiDictionary a a -> [a]
orbitOf = undefined

-- | Exercise k. cyclesOf

cyclesOf :: Ord a => BiDictionary a a -> [[a]]
cyclesOf = undefined

-- |------------------------------------------------------------------------


instance (Show a, Show b) => Show (BiDictionary a b) where
  show (Bi dk dv)  = "BiDictionary(" ++ intercalate "," (aux (D.keysValues dk)) ++ ")"
                        ++ "(" ++ intercalate "," (aux (D.keysValues dv)) ++ ")"
   where
    aux kvs  = map (\(k,v) -> show k ++ "->" ++ show v) kvs
