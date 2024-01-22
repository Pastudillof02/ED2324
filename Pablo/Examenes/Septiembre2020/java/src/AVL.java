/**
 * Student's name:
 *
 * Student's group:
 */

import dataStructures.list.ArrayList;
import dataStructures.list.List;
import dataStructures.list.LinkedList;
import dataStructures.list.ListException;

import java.util.Iterator;


class Bin {
    private int remainingCapacity; // capacity left for this bin
    private List<Integer> weights; // weights of objects included in this bin

    public Bin(int initialCapacity) {
        this.remainingCapacity = initialCapacity;
        this.weights = new ArrayList<>();
    }

    // returns capacity left for this bin
    public int remainingCapacity() {
        return this.remainingCapacity;
    }

    // adds a new object to this bin
    public void addObject(int weight) {
        if(remainingCapacity < weight) throw new ListException("Bin.addObject: not enough capacity");
        else
        {
            remainingCapacity -= weight;
            weights.append(weight);
        }
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

        // recomputes height of this node
        void setHeight() {
            height = 1 + Math.max(height(left), height(right));
        }

        // recomputes max capacity among bins in tree rooted at this node
        void setMaxRemainingCapacity() {
            if(left == null && right == null) maxRemainingCapacity = bin.remainingCapacity();
            else maxRemainingCapacity = Math.max(maxRemainingCapacity(left), maxRemainingCapacity(right));
        }

        // left-rotates this node. Returns root of resulting rotated tree
        Node rotateLeft() {
            Node x = this.right;
            Node r1 = x.left;

            this.right = r1;
            x.left = this;
            this.setHeight();
            x.setHeight();

            return x;
        }
    }

    private static int height(Node node) {
        if(node == null) return 0;
        else return node.height;
    }

    private static int maxRemainingCapacity(Node node) {
        if (node == null) return 0;
        else return node.maxRemainingCapacity;
    }

    private Node root; // root of AVL tree

    public AVL() {
        this.root = null;
    }

    // adds a new bin at the end of right spine.
    private void addNewBin(Bin bin) {
        root = addNewBinRec(root, bin);
    }

    private Node addNewBinRec(Node node, Bin bin)
    {
        if(node == null) {
            node = new Node();
            node.bin = bin;
        }
        else
        {
            node.right = addNewBinRec(node.right, bin);
            node.setHeight();
            node.setMaxRemainingCapacity();

            if(node.right.height - node.left.height > 1) node = node.rotateLeft();
        }

        return node;
    }

    // adds an object to first suitable bin. Adds
    // a new bin if object cannot be inserted in any existing bin
    public void addFirst(int initialCapacity, int weight) {
        root = addFirstRec(root, initialCapacity, weight);
    }

    public Node addFirstRec(Node node, int initialCapacity, int weight)
    {
        if(node == null)
        {
            Bin bin = new Bin(initialCapacity);
            bin.addObject(weight);
            return addNewBinRec(node, bin);
        }
        else if (maxRemainingCapacity(node.left) >= weight)
            node.left = addFirstRec(node.left, initialCapacity, weight);
        else if (node.bin.remainingCapacity() >= weight)
            node.bin.addObject(weight);
        else {
            node.right = addFirstRec(node.right, initialCapacity, weight);
        }
        return node;
    }

    public void addAll(int initialCapacity, int[] weights) {
        for(int w : weights) addFirst(initialCapacity, w);
    }

    public List<Bin> toList() {
        List<Bin> list = new ArrayList<>();
        list = toListRec(root, list);
        return list;
    }

    public List<Bin> toListRec(Node node, List<Bin> list)
    {
        if(node != null)
        {
            list.append(node.bin);
            toListRec(node.left, list);
            toListRec(node.right, list);
        }
        return list;
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