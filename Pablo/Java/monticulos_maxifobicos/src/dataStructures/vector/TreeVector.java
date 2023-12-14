/******************************************************************************
 * Student's name:
 * Student's group:
 * Data Structures. Grado en Informática. UMA.
******************************************************************************/

package dataStructures.vector;

import dataStructures.list.ArrayList;
import dataStructures.list.LinkedList;
import dataStructures.list.List;

public class TreeVector<T> {

    private final int size;
    private final Tree<T> root;

    private interface Tree<E> {
        E get(int index);

        void set(int index, E x);

        List<E> toList();
    }

    private static class Leaf<E> implements Tree<E> {
        private E value;

        public Leaf(E x) {
            value = x;
        }

        @Override
        public E get(int i) {
            return value;
        }

        @Override
        public void set(int i, E x) {
        	value = x;
        }

        @Override
        public List<E> toList() {
            List<E> l = new ArrayList<>();
            l.append(value);
            return l;
        }
    }

    private static class Node<E> implements Tree<E> {
        private Tree<E> left;
        private Tree<E> right;

        public Node(Tree<E> l, Tree<E> r) {
            left = l;
            right = r;
        }

        @Override
        public E get(int i) {
        	if(i % 2 == 0) return left.get(i/2);
            else return right.get(i/2);
        }

        @Override
        public void set(int i, E x) {
        	if(i % 2 == 0) left.set(i/2, x);
            else right.set(i/2, x);
        }

        @Override
        public List<E> toList() {
        	return intercalate(left.toList(), right.toList());
        }
    }

    public TreeVector(int n, T value) {
    	if(n < 0) throw new VectorException("Negative size");
        else
        {
            size = 2^n;
            root = mkTree(n, value);
        }
    }

    public Tree<T> mkTree(int n, T value)
    {
        if(n == 0) return new Leaf<T>(value);
        else return new Node<T>(mkTree(n-1, value), mkTree(n-1, value));
    }

    public int size() {
        if(size == 0) throw new VectorException("Empty vector");
        else return size;
    }

    public T get(int i) {
        if(i < 0 || i >= size) throw new VectorException("Index out of bounds");
        else return root.get(i);
    }

    public void set(int i, T x) {
        if(i < 0 || i >= size) throw new VectorException("Index out of bounds");
        else root.set(i, x);
    }

    public List<T> toList() {
        return root.toList();
    }

    protected static <E> List<E> intercalate(List<E> xs, List<E> ys) {
        if(xs.isEmpty()) return ys;
        else if(ys.isEmpty()) return xs;

        List<E> l = new ArrayList<>();
        while(!xs.isEmpty() && !ys.isEmpty())
        {
            l.append(xs.get(0));
            xs.remove(0);
            l.append(ys.get(0));
            ys.remove(0);
        }

        return l;
    }

    static protected boolean isPowerOfTwo(int n) {
        return n % 2 == 0;
    }

    public static <E> TreeVector<E> fromList(List<E> l) {
    	if(!isPowerOfTwo(l.size())) throw new VectorException("List size is not a power of two");
        else
        {
            TreeVector<E> v = null;
            for(int i = 0; i < l.size(); i++)
            {
                v = new TreeVector<>(l.size(), l.get(i));
            }
            return v;
        }
    }
}
