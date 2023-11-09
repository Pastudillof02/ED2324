 | Ejercicio 2 - Axiomas del TAD
----------------------------------------------------------------------
-- 1 pto.
-- | completa los axiomas que definen deleteKeyValue
ax_deleteKeyValue_empty x y = deleteKeyValue x y empty == empty
ax_deleteKeyValue_1 k v q = not(isDefinedAt k q) ==> deleteKeyValue k v q == q
-- ax_deleteKeyValue_2 k v q = isDefinedAt k q && S.isElem v (valuesOf k q) ==> 
not(S.isElem v (valuesOf k (deleteKeyValue k v q))) -- Sin Tipo Maybe en ValuesOf
 
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
