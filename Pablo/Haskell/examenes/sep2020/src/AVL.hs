{------------------------------------------------------------------------------
 - Student's name:
 -
 - Student's group:
 -----------------------------------------------------------------------------}

module AVL 
  ( 
    Weight
  , Capacity
  , AVL (..)
  , Bin
  , emptyBin
  , remainingCapacity
  , addObject
  , maxRemainingCapacity
  , height
  , nodeWithHeight
  , node
  , rotateLeft
  , addNewBin
  , addFirst
  , addAll
  , toList
  , linearBinPacking
  , seqToList
  , addAllFold
  ) where

type Capacity = Int
type Weight= Int

data Bin = B Capacity [Weight] 

data AVL = Empty | Node Bin Int Capacity AVL AVL deriving Show


emptyBin :: Capacity -> Bin
emptyBin x = B x []

remainingCapacity :: Bin -> Capacity
remainingCapacity (B x []) = x

addObject :: Weight -> Bin -> Bin
addObject a (B x xs)
  | a > x = error  "the object is to weight for the bin (addObject)"
  | otherwise = B (x-a)(xs++[a])

maxRemainingCapacity :: AVL -> Capacity
maxRemainingCapacity (Node _ _ c _ _ ) = c

height :: AVL -> Int
height (Node _ h _ _ _) = h
 
nodeWithHeight :: Bin -> Int -> AVL -> AVL -> AVL
nodeWithHeight bin@(B c xs) h lt rt = Node bin h m lt rt
  where 
    m = max c cap
    cap = max (maxRemainingCapacity lt) (maxRemainingCapacity rt)


node :: Bin -> AVL -> AVL -> AVL
node b@(B c xs) lt rt = Node b getH getM lt rt
  where 
    getH = if(height lt < height rt) then (height rt)+1 else (height lt )+1
    getM = max c cap
    cap = max (maxRemainingCapacity lt) (maxRemainingCapacity rt)

rotateLeft :: Bin -> AVL -> AVL -> AVL
rotateLeft _ _ _ = undefined

addNewBin :: Bin -> AVL -> AVL
addNewBin _ _ = undefined
 
addFirst :: Capacity -> Weight -> AVL -> AVL
addFirst _ _ _ = undefined

addAll:: Capacity -> [Weight] -> AVL
addAll _ _ = undefined

toList :: AVL -> [Bin]
toList _ = undefined

{-
	SOLO PARA ALUMNOS SIN EVALUACION CONTINUA
  ONLY FOR STUDENTS WITHOUT CONTINUOUS ASSESSMENT
 -}

data Sequence = SEmpty | SNode Bin Sequence deriving Show  

linearBinPacking:: Capacity -> [Weight] -> Sequence
linearBinPacking _ _ = undefined

seqToList:: Sequence -> [Bin]
seqToList _ = undefined

addAllFold:: [Weight] -> Capacity -> AVL 
addAllFold _ _ = undefined



{- No modificar. Do not edit -}

objects :: Bin -> [Weight]
objects (B _ os) = reverse os

  
instance Show Bin where
  show b@(B c os) = "Bin("++show c++","++show (objects b)++")"