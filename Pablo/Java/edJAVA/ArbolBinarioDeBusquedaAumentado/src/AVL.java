/**
 * Student's name:
 *
 * Student's group:
 */

import dataStructures.list.ArrayList;
import dataStructures.list.List;
import dataStructures.list.LinkedList;
import org.w3c.dom.Node;

import java.util.Iterator;


class Bin {
    private int remainingCapacity; // capacity left for this bin
    private List<Integer> weights; // weights of objects included in this bin

    public Bin(int initialCapacity) {
        this.weights = new ArrayList<>();
        this.remainingCapacity = initialCapacity;
    }

    // returns capacity left for this bin
    public int remainingCapacity() {
        return this.remainingCapacity;
    }

    // adds a new object to this bin
    public void addObject(int weight) {
        if(weight > remainingCapacity) {
            throw new IllegalArgumentException("no cabe en el cubo");
        }
        weights.append(weight);
        this.remainingCapacity -= weight;
    }

    public int totalWeight() {
        int total = 0;
        for (int w : weights) {
            total += w;
        }
        return total;
    }

    // returns an iterable through weights of objects included in this bin
    public Iterable<Integer> objects() {
        // todo
        //  SOLO PARA ALUMNOS SIN EVALUACION CONTINUA
        //  ONLY FOR STUDENTS WITHOUT CONTINUOUS ASSESSMENT
        return null;
    }

    public String toString() {
        String className = getClass().getSimpleName();
        StringBuilder sb = new StringBuilder(className);
        sb.append("(");
        sb.append(remainingCapacity);
        sb.append(", ");
        sb.append(weights.toString());
        sb.append(")");
        return sb.toString();
    }
}

// Class for representing an AVL tree of bins
public class AVL {
    static private class Node {
        Bin bin; // Bin stored in this node
        int height; // height of this node in AVL tree
        int maxRemainingCapacity; // max capacity left among all bins in tree rooted at this node
        Node left, right; // left and right children of this node in AVL tree

        public static int height(Node tree) {
            return tree==null ? 0 : 1+ tree.height;
        }
        // recomputes height of this node
        void setHeight() {
            height = 1 + Math.max(height(left), height(right));
        }

        // recomputes max capacity among bins in tree rooted at this node
        void setMaxRemainingCapacity() {
            maxRemainingCapacity = Math.max(left.maxRemainingCapacity, right.maxRemainingCapacity);
        }

        // left-rotates this node. Returns root of resulting rotated tree
        Node rotateLeft() {
            Node rt = this.right;
            Node lrt = rt.left;

            this.right = lrt;
            this.setHeight();

            rt.left = this;
            rt.setHeight();

            return rt;
            /*
            *  ARBOL ENTRADA                   ARBOL ROTADO
                    this			                rt
               0		   rt       =>         this	       0
                      rlt      0           0        lrt
            */
        }
    }

    private static int height(Node node) {
        if (node != null) {
            return node.height;
        } else {
            return 0;
        }
    }

    private static int maxRemainingCapacity(Node node) {
        if (node != null) {
            return node.maxRemainingCapacity;
        } else {
            return 0;
        }
    }

    private Node root; // root of AVL tree

    public AVL() {
        this.root = null;
    }

    // adds a new bin at the end of right spine.
    private void addNewBin(Bin bin) {
        //toma un cubo y lo añade al final de la espina derecha del AVL
        //para mantener el invariante, si la altura resultante del hijo dcho es más de una unidad superior a la del hijo
        //izq, habrá que aplicar una rotación simple a la izquierda
        root = addNewBin(root, bin);
    }

    private Node addNewBin(Node node, Bin bin) {
        if (node == null) {
            node = new Node();
            node.bin = bin;
        } else {
            node.right = addNewBin(node.right,bin);
            node.setHeight();
            node.setMaxRemainingCapacity();
            if (height(node.right) - height(node.left) > 1) {
                node = node.rotateLeft();
            }
        }
        return node;
    }

    // adds an object to first suitable bin. Adds
    // a new bin if object cannot be inserted in any existing bin
    public void addFirst(int initialCapacity, int weight) {
        root = addFirst(root,initialCapacity,weight);
    }

    private Node addFirst(Node node, int initialCapacity, int weight) {
        //si el AVL esta vacio o no cabe en ningun cubo, se añadira un nuevo nodo con un cubo con el objeto
        //al final de la espina derecha
        if (node == null) {
            Bin bin = new Bin(initialCapacity);
            bin.addObject(weight);
            return addNewBin(node,bin);
        } else if (maxRemainingCapacity(node.left) >= weight) {
            //se añade el objeto al primer cubo posible del hijo izquierdo
            node.left = addFirst(node.left,initialCapacity,weight);
        } else if (node.bin.remainingCapacity() >= weight) {
            node.bin.addObject(weight);
        } else {
            node.right = addFirst(node.right,initialCapacity,weight);
        }

        return node;
    }

    //toma el valor de la capacidad maxima de los cubos W y un array con los pesos de los objetos
    //añade al AVL todos los objetos del array
    public void addAll(int initialCapacity, int[] weights) {
        for (int w : weights) {
            addFirst(initialCapacity,w);
        }
    }

    public List<Bin> toList() {
        List<Bin> bins = new ArrayList<>();
        //en orden: hijo izq - raiz - hijo dcho
        inOrder(root,bins);
        return bins;
    }

    private void inOrder(Node node, List<Bin> bins) {
        if (node != null) {
            inOrder(node.left,bins);
            bins.append(node.bin);
            inOrder(node.right,bins);
        }
    }

    public String toString() {
        String className = getClass().getSimpleName();
        StringBuilder sb = new StringBuilder(className);
        sb.append("(");
        stringBuild(sb, root);
        sb.append(")");
        return sb.toString();
    }

    private static void stringBuild(StringBuilder sb, Node node) {
        if(node==null)
            sb.append("null");
        else {
            sb.append(node.getClass().getSimpleName());
            sb.append("(");
            sb.append(node.bin);
            sb.append(", ");
            sb.append(node.height);
            sb.append(", ");
            sb.append(node.maxRemainingCapacity);
            sb.append(", ");
            stringBuild(sb, node.left);
            sb.append(", ");
            stringBuild(sb, node.right);
            sb.append(")");
        }
    }
}

class LinearBinPacking {
    public static List<Bin> linearBinPacking(int initialCapacity, List<Integer> weights) {
        // todo
        //  SOLO PARA ALUMNOS SIN EVALUACION CONTINUA
        //  ONLY FOR STUDENTS WITHOUT CONTINUOUS ASSESSMENT
        return null;
    }
	
	public static Iterable<Integer> allWeights(Iterable<Bin> bins) {
        // todo
        //  SOLO PARA ALUMNOS SIN EVALUACION CONTINUA
        //  ONLY FOR STUDENTS WITHOUT CONTINUOUS ASSESSMENT
        return null;		
	}
}