import static java.util.Collections.max;

public class AugmentedBST <T extends Comparable<? super T>>{
    private static class Tree<E> {
        E key;
        int weight;
        Tree<E> left;
        Tree<E> right;

        public Tree(E k) {
            key = k;
            weight = 1;
            left = null;
            right = null;
        }
    }

    private Tree<T> root;

    public AugmentedBST() {
        root = null;
    }

    public boolean isEmpty() {
        return root == null;
    }

    private static <T> int weight (Tree <T> node) {
        return node == null ? 0 : node.weight;
    }

    public int size() {
        return weight(root);
    }

    public void insert(T k) {
        root = insertRec(root, k);
    }

    private Tree<T> insertRec(Tree<T> node, T key) {
        if (node == null) {
            node = new Tree<T>(key);
        } else if (key.compareTo(node.key) < 0) {
            node.left = insertRec(node.left, key);
        } else if (key.compareTo(node.key) > 0) {
            node.right = insertRec(node.right, key);
        } else {
            node.key = key;
        }
        node.weight = 1 + weight(node.left) + weight(node.right);

        return node;
    }

    public T search (T key) {
        return searchRec(root,key);
    }

    private static <T extends Comparable<? super T>> T searchRec(Tree<T> node, T key) {
        if (node == null) {
            return null;
        } else if (key.compareTo(node.key) < 0) {
            return searchRec(node.left, key);
        } else if (key.compareTo(node.key) > 0) {
            return searchRec(node.right, key);
        } else {
            return node.key;
        }
    }

    public boolean isElem(T key) {
        return search(key) != null;
    }

    private static <T extends Comparable<? super T>> Tree<T> split (Tree<T> node, Tree<T> temp) {
        if (node.left == null) {
            //min node found, so copy min key in temp node
            temp.key = node.key;
            return node.right;
        } else {
            node.left = split(node.left, temp);
            return node;
        }
    }

    public void delete(T key) {
        root = deleteRec(root,key);
    }

    private Tree<T> deleteRec(Tree<T> node, T key) {
        if (node == null){
            ; //key not found, do nothing
        } else {
            if (key.compareTo(node.key) < 0) {
                node.left = deleteRec(node.left, key);
            } else if (key.compareTo(node.key) > 0) {
                node.right = deleteRec(node.right, key);
            } else {
                if (node.left == null) {
                    node = node.right;
                } else if (node.right == null) {
                    node = node.left;
                } else {
                    node.right = split(node.right,node);
                }
            }
            node.weight = 1 + weight(node.left) + weight(node.right);
        }
        return node;
    }

   /* @Override
    public String toString() {
        String classname = getClass().getName().substring(getClass().getPackage().getName().length() + 1);
        return classname + "(" + toStringRec(this.root) + ")";
    }

    private static String toStringRec(Tree<?> tree) {
        return tree == null ? "null" : "Node<" + toStringRec(tree.left) + "," + tree.key + "," + tree.weight + "," +
                toStringRec(tree.right) + ">";
    }*/

    @Override
    public String toString() {
        return toStringRec(root, 0);
    }

    private static String toStringRec(Tree<?> tree, int depth) {
        StringBuilder result = new StringBuilder();

        if (tree == null) {
            result.append("null");
        } else {
            result.append(toStringRec(tree.right, depth + 1)); // Print right subtree
            result.append("\n");

            // Add indentation based on the depth of the node
            for (int i = 0; i < depth; i++) {
                result.append("    ");
            }

            result.append(tree.key).append(" (").append(tree.weight).append(")\n"); // Print node
            result.append(toStringRec(tree.left, depth + 1)); // Print left subtree
        }

        return result.toString();
    }


    //A COMPLETAR
    //métodos:
    /* -> select
    *  -> floor
    *  -> ceiling
    *  -> rank
    *  -> size  */

    //select
    /*
        devuelve la i-esima key (clave) mas pequeña en el arbol (i=0 --> clave mas pequeña de todas)
    */

    public T select(int i) {
        //los pesos son los nodos que componen el arbol
        //por ello, si estamos en la raiz y el peso es menor, entonces debemos explorar las otras ramas
        if (i>=0 && i < root.weight) {
            return selectRec(root,i);
        } else {
            return null;
        }
    }

    private static <T extends Comparable<? super T>> T selectRec (Tree<T> node, int i) {
        if (node == null) {
            return null;
        } else if (node.weight == 1) {
            return node.key;
        } else if (node.left.weight == i) {
            return node.key;
        } else if (node.left.weight > i) {
            return selectRec(node.left,i);
        } else {
            return selectRec(node.right, i-node.left.weight-1); //no entiendo muy bien por qué es -1
        }
    }

    /*
    FLOOR

    devuelve la clave más grande en el arbol cuyo valor es menor o igual a k
     */

    public T floor(T k) {
        return floorRec(root,k);
    }

    /*
        bst . floor (4) = null --> no existe una clave menor o igual a 4, por tanto es null
        bst . floor (5) = 5 --> existe una clave igual a k
        bst . floor (6) = 5 --> 6 es menor que la clave 5, por tanto devuelve 5
        bst . floor (9) = 5 --> idem
        bst . floor (10) = 10
        bst . floor (27) = 25
        bst . floor (50) = 35
     */
    private static <T extends Comparable<? super T>> T floorRec(Tree<T> node, T key) {
        if (node == null) {
            return null;
        } else if (node.key.compareTo(key) == 0) {
            return key; // key tiene el mismo valor que node.key, por tanto devolvemos key (da igual)
        } else if (key.compareTo(node.key) < 0) {
            return floorRec(node.left,key);
        } else {
            return maximo(node.key, floorRec(node.right,key));
        }
    }

    private static <T extends Comparable<? super T>> T maximo(T key, T key2) {
        if (key2 == null) {
            return key; //cuando hacemos floor(6) se mete en este caso y devuelve 5
        } else {
            return key2;
        }
    }

    /*
    METODO CEILING
        -- devuelve la clave mas pequeña en el BST cuyo valor es mayor o igual a k
     */

    public T ceiling (T k) {
        return ceilingRec(root,k);
    }

    /*
            bst . ceiling (4) = 5
            bst . ceiling (5) = 5
            bst . ceiling (6) = 10
            bst . ceiling (9) = 10
            bst . ceiling (10) = 10
            bst . ceiling (27) = 30
            bst . ceiling (50) = null
     */
    private static <T extends Comparable<? super T>> T ceilingRec (Tree<T> node, T key) {
        if (node == null) {
            return null;
        } else if (key.compareTo(node.key) == 0) {
            return key;
        } else if (key.compareTo(node.key) > 0) {
            //si k es mayor que la clave del nodo
            return ceilingRec(node.right,key);
        } else {
            return maximo(node.key, ceilingRec(node.left, key));
        }
    }

    /*
    METODO RANK
        -- devuelve el numero de claves en el BST cuyos valores son menores a k
     */

    public int rank(T k) {
        return rankRec (root,k);
    }

    /*
        bst . rank (4) = 0
        bst . rank (5) = 0
        bst . rank (6) = 1
        bst . rank (9) = 1
        bst . rank (10) = 1
        bst . rank (27) = 5
        bst . rank (50) = 7
     */

    private static <T extends Comparable<? super T>> int rankRec(Tree<T> node, T key) {
        if (node == null) {
            return 0;
        } else if (key.compareTo(node.key) > 0) {
            if (node.left == null && node.right == null) {
                return 1;
            } else if (node.right == null) {
                return rankRec(node.left, key) +1;
            } else if (node.left == null) {
                return rankRec(node.right, key) + 1;
            } else {
                return rankRec(node.left, key) + rankRec(node.right, key) + 1;
            }
        } else {
            return rankRec(node.left, key);
        }
    }

    /*
    METODO SIZE
        --devuelve el numero de claves en el BST cuyos valores estan entre un intervalo dado
        bst . size (1 ,4) = 0
        bst . size (1 ,5) = 1
        bst . size (5 ,5) = 1
        bst . size (5 ,6) = 1
     */

    public int size (T low, T high) {
        if (low.compareTo(high) < 0) {
            return sizeRec(low, high, root);
        } else {
            return 0;
        }
    }

    private static <T extends Comparable<? super T>> int sizeRec(T low, T high, Tree<T> node) {
        if (node == null) {
            return 0;
        } else if (node.key.compareTo(low) < 0) {
            return sizeRec(low, high, node.right);
        } else if (node.key.compareTo(high) > 0) {
            return sizeRec(low,high, node.left);
        } else if (node.key.compareTo(high) == 0) {
            return sizeRec(low,high,node.left) + 1;
        } else if (node.key.compareTo(low) == 0) {
            return sizeRec(low,high,node.right) + 1;
        } else {
            return sizeRec(low,high,node.left) + sizeRec(low,high,node.right) + 1;
        }
    }
}
