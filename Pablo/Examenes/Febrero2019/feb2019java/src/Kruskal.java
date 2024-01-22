/**----------------------------------------------
 * -- Estructuras de Datos.  2018/19
 * -- 2º Curso del Grado en Ingeniería [Informática | del Software | de Computadores].
 * -- Escuela Técnica Superior de Ingeniería en Informática. UMA
 * --
 * -- Examen 4 de febrero de 2019
 * --
 * -- ALUMNO/NAME:
 * -- GRADO/STUDIES:
 * -- NÚM. MÁQUINA/MACHINE NUMBER:
 * --
 * ----------------------------------------------
 */

import dataStructures.graph.WeightedGraph;
import dataStructures.graph.WeightedGraph.WeightedEdge;

import dataStructures.dictionary.Dictionary;
import dataStructures.dictionary.HashDictionary;
import dataStructures.priorityQueue.PriorityQueue;
import dataStructures.priorityQueue.LinkedPriorityQueue;
import dataStructures.set.Set;
import dataStructures.set.HashSet;
import dataStructures.tuple.Tuple2;

import java.util.Iterator;
import java.util.Stack;

public class Kruskal {
	public static <V,W> Set<WeightedEdge<V,W>> kruskal(WeightedGraph<V,W> g) {
		Dictionary<V,V> DICT = new HashDictionary<>();
		for (V v : g.vertices())
		{
			DICT.insert(v, v);
		}

		PriorityQueue<WeightedEdge<V,W>> PQ = new LinkedPriorityQueue<>();
		Iterator<WeightedEdge<V,W>> it = g.edges().iterator();
		while(it.hasNext()){
			PQ.enqueue(it.next());
		}

		Set<WeightedEdge<V,W>> T = new HashSet<>();

		while(!PQ.isEmpty())
		{
			WeightedEdge<V,W> edge = PQ.first();
			PQ.dequeue();
			V src = edge.source();
			V rep = DICT.valueOf(src);
			while(src != rep){
				src = rep;
				rep = DICT.valueOf(src);
			}

			V src2 = edge.destination();
			V rep2 = DICT.valueOf(src2);
			while(src2 != rep2){
				src2 = rep2;
				rep2 = DICT.valueOf(src2);
			}

			if(rep != rep2) {
				DICT.delete(rep2);
				DICT.insert(rep2, edge.source());
				T.insert(edge);
			}
		}

		return T;
	}

	// Sólo para evaluación continua / only for part time students
	public static <V,W> Set<Set<WeightedEdge<V,W>>> kruskals(WeightedGraph<V,W> g) {

		// COMPLETAR
		
		return null;
	}
}
