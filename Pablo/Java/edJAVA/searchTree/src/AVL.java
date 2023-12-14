import tuple.Tuple2;

import java.util.function.UnaryOperator;

public class AVL <K extends Comparable<? super K>, V> implements SearchTree<K,V>{

    private static class Tree<K,V> {
        K key;
        V value;
        int height;

        Tree<K,V> left;
        Tree<K,V> right;

        public Tree(K k, V v) {
            key = k;
            value = v;
            height = 1;
            left = null;
            right = null;
        }

        //los metodos de altura, inclinacion, rotacion y balanceado se incluyen en ESTA CLASE ESTATICA

        public static int height(Tree <?,?> tree) { return tree==null ? 0 : 1+tree.height; }

        public void setHeight() { height = 1 + Math.max(height(left), height(right)); }

        //inclinacion derecha
        public boolean rightLeaning() { return height(right)>=height(left);}

        //inclinacion izquierda
        public boolean leftLeaning() { return height(left)>=height(right); }

        //rotacion derecha
        public Tree<K,V> rotR() {
            Tree<K,V> lt = this.left;
            Tree<K,V> lrt = lt.right;

            this.left = lrt;
            this.setHeight(); //aseguramos la altura

            lt.right = this;
            lt.setHeight();

            return lt; //esta es ahora nuestra raíz
             /*
               ARBOL ENTRADA		   ARBOL ROTADO
                    this			        lt
                lt		    0    =>     0	       this
             0     lrt			                lrt       0
            *
            */
        }

        public Tree<K,V> rotL () {

            Tree<K,V> rt = this.right;
            Tree<K,V> rlt = rt.left;

            this.right = rlt;
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

        public Tree<K,V> balance() {
            int lh = height(left);
            int rh = height(right);

            Tree<K,V> balanced;

            if (lh-rh > 1 && leftLeaning()) {
                //si la altura se diferencia en más de uno dejaría de ser AVL
                //si la altura de la izquierda es mayor que la derecha está inclinado hacia la izquierda
                //HACEMOS UNA ROTACIÓN SIMPLE
                balanced = this.rotR();
            } else if (lh-rh>1) { //rotacion doble
                left = left.rotL();
                balanced = this.rotR();
            } else if (rh-lh>1 && rightLeaning()) {
                //ROTACION SIMPLE
                balanced = this.rotL();
            } else if (rh-lh>1) {
                //no está inclinado hacia la derecha
                //DOBLE ROTACION
                right=right.rotR();
                balanced = this.rotL();
            } else {
                balanced = this;
                balanced.setHeight();
            }
            return balanced;
        }

    }

    private Tree<K,V> root;
    private int size;

    public AVL() {
        root=null;
        size=0;
    }
    @Override
    public boolean isEmpty() {
        return root==null;
    }

    @Override
    public int size() {
        return size;
    }

    @Override
    public int height() {
        return Tree.height(root);
    }

    @Override
    public void insert(K k, V v) {
        root=insertRec(root, k, v);
    }

    private <K extends Comparable<?super K>,V> Tree<K,V> insertRec(Tree<K,V> node, K key, V value) {
        if (node == null) {
            node = new Tree<>(key,value);
            size++;
        } else if (key.compareTo(node.key) == 0) {
            node.value = value;
        } else if (key.compareTo(node.key) < 0) {
            node.left = insertRec(node.left,key,value);
            node = node.balance(); //esto se ejecuta cuando salga de las llamadas recursivas para hacer el balanceo
        } else {
            node.right = insertRec(node.right,key,value);
            node = node.balance();
        }

        return node;
    }

    @Override
    public V search(K k) {
        return AVL.searchRec(root,k);
    } //ponemos el AVL para que no se meta en el metodo sear de BST
    //lo de poner AVL. solo se hace con los metodos static

    private static <K extends Comparable<? super K>, V> V searchRec (Tree<K,V> tree, K key) {
        if (tree == null) {
            return null;
        } else if (key.compareTo(tree.key) == 0) {
            return tree.value;
        } else if (key.compareTo(tree.key) < 0) {
            return searchRec(tree.left, key);
        } else {
            return searchRec(tree.right,key);
        }
    }

    @Override
    public boolean isElem(K k) {
        return search(k) != null;
    }

    @Override
    public void delete(K k) {
        root = deleteRec(root,k);
    }

    private Tree<K,V> deleteRec(Tree<K,V> node, K key) {
        if (node == null) {
            ;
        } else if (key.compareTo(node.key) < 0) {
            node.left = deleteRec(node.left,key);
            node = node.balance(); //se balancea una vez sale del bucle
        } else if (key.compareTo(node.key) > 0) {
            node.right = deleteRec(node.right,key);
            node = node.balance();
        } else {
            if (node.left == null) {
                //si el nodo solo tiene un hijo derecho, se convierte en el
                node = node.right;
            } else if (node.right == null) {
                //idem si solo tiene el hijo izquierdo
                node = node.left;
            } else {
                //si tiene los dos hijos, buscamos el menor hijo del hijo derecho y lo intercambiamos
                node.right = split(node.right,node);
                node = node.balance();
            }
            size--;
        }
        return node;
    }

    private Tree<K,V> split(Tree<K, V> node, Tree<K, V> temp) {
        //esto es igual que en los BST
        if (node.left == null) {
            temp.key = node.key;
            temp.value = node.value;
            return node.right;
        } else {
            //el minimo elemento del hijo derecho es el que sustituye
            node.left = split(node.left,temp);
            node = node.balance();
            return node;
        }
    }

    @Override
    public V minim() {
        return null;
    }

    @Override
    public V maxim() {
        return null;
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
