import tuple.Tuple2;

import java.util.function.UnaryOperator;

public class BST <K extends Comparable<? super K>, V> implements SearchTree<K,V>{


    private static class Tree<C,D> {
        private C key;
        private D value;
        private Tree<C,D> left, right;

        public Tree(C k, D v) {
            key=k; //los nodos estan ordenados segun las claves
            value=v;
            left=null;
            right=null;
        }
    }

    private Tree<K,V> root; //raiz del arbol
    private int size; //num elementos del arbol

    public BST() {
        root = null;
        size = 0;
    }
    @Override
    public boolean isEmpty() {
        return size == 0; //o bien root == null;
    }

    @Override
    public int size() {
        return size;
    }

    @Override
    public int height() {
        return heightRec(root);
    }

    private int heightRec(Tree<?,?> tree) {
        //llamamos de forma recursiva y nos quedamos con la maxima altura
        return tree==null ? 0 : 1+Math.max(heightRec(root.left), heightRec(root.right));
    }

    @Override
    public void insert(K k, V v) {
        root = insertRec(root, k, v);
    }

    /*
        para hacer un insert en un BST, tenemos que ir comparando el nodo desde la raíz con cada uno de los nodos
        del árbol
        --> si el nodo que queremos insertar es MENOR al nodo en el que nos encontramos, vamos a la IZQUIERDA
        --> si el nodo es MAYOR al nodo en el que nos encontramos, vamos a la DERECHA
     */
    private Tree<K,V> insertRec(Tree<K,V> node, K key, V value) {
        //si el arbol es null, añadimos el elemento a la raiz
        if (node == null) {
            node = new Tree<>(key,value);
            size++;
        } else if (key.compareTo(node.key) == 0) {
            node.value = value;
        } else if (key.compareTo(node.key) < 0) {
            //si la clave es menor que el nodo en el que nos encontramos --> inserta por la IZQUIERDA
            node.left = insertRec(node.left,key,value);
        } else {
            //de lo contrario, INSERTA POR LA DERECHA
            node.right = insertRec(node.right,key,value);
        }

        return node;
    }

    //dada una clave devuelve el valor asociado a dicha clave
    @Override
    public V search(K k) {
        return searchRec(root, k);
    }

    private static <K extends Comparable<? super K>,V> V searchRec(Tree<K,V> tree, K key) {
        if (tree==null) {
            return null; //si el arbol esta vacio, devuelve null
        } else if (key.compareTo(tree.key) == 0) {
            return tree.value; //si la clave pasada por parametro y la clave del nodo es la misma, devuelve el valor
        } else if (key.compareTo(tree.key) < 0) {
            //si la clave pasada por parametro es menor que la clave del nodo
            return searchRec(tree.left,key); //SI ES MENOR, BUSCO POR LA IZQUIERDA
        } else {
            return searchRec(tree.right,key); //SI ES MAYOR, BUSCO POR LA DERECHA
        }
    }

    @Override
    public boolean isElem(K k) {
        return search(k) !=null;
    }

    @Override
    public void delete(K k) {
        root = deleteRec(root,k);
    }

    private Tree<K,V> deleteRec(Tree<K,V> node, K key) {
        if (node == null) {
            ; //si en nodo es nulo no se hace nada
        } else if (key.compareTo(node.key) == 0) {
            //estamos en el nodo que queremos borrar
            if (node.left == null) {
                node = node.right; //el nodo ahora se convierte en el nodo de la derecha
            } else if (node.right == null) {
                node = node.left; //el nodo ahora se convierte en el nodo de la izquierda
            } else { //en el caso de que tenga dos hijos
                node.right = split(node.right, node); //el node se actualiza con los cambios realizados en split
                //SE ACTUALIZA NODE PORQUE LA CLASE SPLIT ES STATIC !!!!!
            }
            size--;
        } else if (key.compareTo(node.key) < 0) {
            //si la clave es menor a la clave del nodo que queremos borrar
            node.left = deleteRec(node.left,key);
        } else {
            node.right = deleteRec(node.right,key);
        }
        return node;
    }

    /*
    si el nodo a borrar tiene dos hijos:
        --> el mínimo elemento del hijo derecho será el que sustituya al nodo
     */

    //eliminamos el minimo del arbol y lo ponemos donde iria el nodo, por lo que se guarda la info en temp
    private static <K extends Comparable<? super K>,V> Tree<K,V> split (Tree<K,V> node, Tree<K,V> temp) {
        //si no tiene hijo izquierdo, quiere decir que el menor elemento es el de la raiz
        if (node.left == null) {
            //guardamos el valor y la clave en temp y devolvemos el hijo derecho (eliminamos la raiz)
            temp.key = node.key;
            temp.value = node.value;
            return node.right;
        } else {
            //el minimo estará en el hijo izquierdo
            node.left = split (node.left,temp); //actuailizo node.left para quitar el minimo
            return node;
        }
    }
    @Override
    public V minim() {
        if (root == null) {
            throw new EmptySearchTreeException("arbol vacio");
        }
        Tree<K,V> node = root;
        while (node.left != null) {
            node=node.left;
        }
        return node.value;
    }

    @Override
    public V maxim() {
        if (root == null) {
            throw new EmptySearchTreeException("arbol vacio");
        }
        return maximRec(root);
    }

    private V maximRec(Tree<K,V> node) {
        return node.right == null ? node.value : maximRec(node.right);
    }

    @Override
    public void deleteMinim() {

    }

    @Override
    public void deleteMaxim() {

    }

    @Override
    public Iterable<K> inOrder() {
        return null;
    }

    @Override
    public Iterable<K> postOrder() {
        return null;
    }

    @Override
    public Iterable<K> preOrder() {
        return null;
    }

    @Override
    public Iterable<V> values() {
        return null;
    }

    @Override
    public Iterable<Tuple2<K, V>> keysValues() {
        return null;
    }

    @Override
    public void updateOrInsert(UnaryOperator<V> f, K k, V v) {

    }
}
