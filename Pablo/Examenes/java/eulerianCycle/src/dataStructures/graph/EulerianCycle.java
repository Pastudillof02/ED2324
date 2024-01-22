/**
 * Student's name:
 * Student's group:
 *
 * Data Structures. Grado en Informática. UMA.
 */

package dataStructures.graph;

import dataStructures.list.*;

import java.util.Iterator;

public class EulerianCycle<V> {
    private List<V> eCycle;

    @SuppressWarnings("unchecked")
    public EulerianCycle(Graph<V> g) {
        Graph<V> graph = (Graph<V>) g.clone();
        eCycle = eulerianCycle(graph);
    }

    public boolean isEulerian()
    {
        return eCycle != null;
    }

    public List<V> eulerianCycle() {
        return eCycle;
    }

    // J.1
    private static <V> boolean isEulerian(Graph<V> g) {
        boolean pares = true;
        Iterator<V> it = g.vertices().iterator();
        while (it.hasNext() && pares) {
            if (g.degree(it.next()) % 2 != 0) {
                pares = false;
            }
        }
        return pares;
    }

    // J.2
    private static <V> void remove(Graph<V> g, V v, V u) {
        g.deleteEdge(v,u);

        Iterator<V> iter = g.vertices().iterator();
        while (iter.hasNext())
        {
            V vertice = iter.next();
            if(g.degree(vertice) == 0)
            {
                g.deleteVertex(vertice);
            }
        }
    }

    // J.3
    private static <V> List<V> extractCycle(Graph<V> g, V v0) {
        List<V> lista = new ArrayList<>();
        lista.append(v0);

        Iterator<V> iter = g.successors(v0).iterator();
        V v1 = iter.next();
        remove(g,v0,v1);
         v0 = v1;

         while (v0 != lista.get(0))
         {
             iter = g.successors(v0).iterator();
             lista.append(v0);
             v1 = iter.next();
             remove(g,v0,v1);
             v0 = v1;
         }
         lista.append(v0);
        return lista;
    }

    // J.4
    private static <V> void connectCycles(List<V> xs, List<V> ys) {
        V vertex = ys.get(0);
        List<V> sol = new ArrayList<>();
        Iterator<V> iter = xs.iterator();
        while (iter.hasNext())
        {
            V actual = iter.next();
            if(actual.equals(vertex))
            {
                Iterator<V> iter2 = ys.iterator();
                while (iter2.hasNext())
                {
                    sol.append(iter2.next());
                }
            }
            else sol.append(actual);
        }
        xs = sol;
    }

    // J.5
    private static <V> V vertexInCommon(Graph<V> g, List<V> cycle) {
        Iterator<V> iter = cycle.iterator();
        boolean encontrado = false;
        while(iter.hasNext())
        {
            V actual = iter.next();
            if(g.vertices().isElem(actual))
            {
                encontrado = true;
                return actual;
            }
        }
        return null;
    }

    // J.6
    private static <V> List<V> eulerianCycle(Graph<V> g) {
    	if(!isEulerian(g)) return null;//throw new GraphException("Graph is not Eulerian");
        else
        {
            Iterator<V> iter = g.vertices().iterator();
            List<V> path = extractCycle(g,iter.next());

            while(g.vertices().size() != 0)
            {
                V vertex = vertexInCommon(g,path);
                List<V> newPath = extractCycle(g,vertex);
                connectCycles(path,newPath);
            }

            return path;
        }
    }
}
