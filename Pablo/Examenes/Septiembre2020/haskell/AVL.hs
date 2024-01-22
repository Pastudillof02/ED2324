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
emptyBin 0 = error "emptyBin: the capacity can not be 0"
emptyBin x = B x [] 

remainingCapacity :: Bin -> Capacity
remainingCapacity (B c x) = c

addObject :: Weight -> Bin -> Bin
addObject w (B c x)
    | w > c = error "addObject: the weight is bigger than bin capacity"
    | otherwise = B (c-w) (x ++ [w])

maxRemainingCapacity :: AVL -> Capacity
maxRemainingCapacity Empty = 0
maxRemainingCapacity (Node bin h c left right) = max (maxRemainingCapacity left) (maxRemainingCapacity right)

height :: AVL -> Int
height Empty = 0
height (Node bin h c left right) = h


 
nodeWithHeight :: Bin -> Int -> AVL -> AVL -> AVL
nodeWithHeight bin@(B c w) h left right = (Node bin h mC left right)
  where 
    mC = if(cl == 0 && cr == 0) then c else max cl cr
    cl = maxRemainingCapacity(left)
    cr = maxRemainingCapacity(right)


node :: Bin -> AVL -> AVL -> AVL
node b left right = nodeWithHeight b h left right
  where 
    h = 1 + max (height left) (height right)

rotateLeft :: Bin -> AVL -> AVL -> AVL
rotateLeft bin@(B c w) left right@(Node b h cM l r) = node b nuevoIzq r
  where 
    nuevoIzq = node bin left l

addNewBin :: Bin -> AVL -> AVL
addNewBin bin Empty = node bin Empty Empty
addNewBin bin (Node b h cM l r) = correct(newAvl)
  where 
    correct avl@(Node b h cM l r) = if(height(l)-height(r) > 1) then rotateLeft b l r else avl
    newAvl = node b l (addNewBin bin r)
 
addFirst :: Capacity -> Weight -> AVL -> AVL
addFirst c w Empty = node (addObject w (emptyBin c)) Empty Empty
addFirst c w avl@(Node b h cM l r)
  | maxRemainingCapacity(l) >= w = node b (addFirst c w l) r
  | remainingCapacity(b) >= w = node (addObject w b) l r
  | otherwise = node b l (addFirst c w r)

addAll:: Capacity -> [Weight] -> AVL
addAll c weights = foldl (\avl w -> addFirst c w avl) Empty weights

toList :: AVL -> [Bin]
toList Empty = []
toList (Node b h cM l r) = toList l ++ [b] ++ toList r 

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