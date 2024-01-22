----------------------------------------------
-- Estructuras de Datos.  2018/19
-- 2º Curso del Grado en Ingeniería [Informática | del Software | de Computadores].
-- Escuela Técnica Superior de Ingeniería en Informática. UMA
--
-- Examen 4 de febrero de 2019
--
-- ALUMNO/NAME:
-- GRADO/STUDIES:
-- NÚM. MÁQUINA/MACHINE NUMBER:
--
----------------------------------------------

module Kruskal(kruskal, kruskals) where

import qualified DataStructures.Dictionary.AVLDictionary as D
import qualified DataStructures.PriorityQueue.LinearPriorityQueue as Q
import DataStructures.Graph.DictionaryWeightedGraph

kruskal :: (Ord a, Ord w) => WeightedGraph a w -> [WeightedEdge a w]
kruskal dic = aux (initDic (vertices dic)) (initPQ (edges dic)) []
    where 
        initDic [] = D.empty
        initDic (x:xs) = D.insert x x (initDic xs)

        initPQ [] = Q.empty
        initPQ (x:xs) = Q.enqueue x (initPQ xs)

        aux dict pq sol = if(Q.isEmpty pq) then sol else (solucionar dict pq sol)
            where 
                (WE a w b) = Q.first pq
                representante src dic = case D.valueOf src dic of
                    Just val -> if(val == src) then src else representante val dic
                    Nothing -> error "something has gone wrong"
                solucionar dict pq sol = if((representante a dict) /= (representante b dict)) then ((WE a w b) : 
                    (aux (modDic dict) (Q.dequeue pq) sol)) else aux dict (Q.dequeue pq) sol
                modDic dic = D.insert a (representante b dict) (D.delete a dic) 


-- Solo para evaluación continua / only for part time students
kruskals :: (Ord a, Ord w) => WeightedGraph a w -> [[WeightedEdge a w]]
kruskals = undefined
