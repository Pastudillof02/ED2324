/******************************************************************************
 * Student's name:
 * Student's group:
 * Data Structures. Grado en Informática. UMA.
******************************************************************************/

package dataStructures.vector;

import dataStructures.list.List;

public class TreeVector<T> {

    /*
    Un vector es una colección homogénea de elementos a los que se accede a través de su índice (número natural).
    El tamaño (size) de un vector es el número de elementos que almacena --> para simplificar, suponemos que es potencia de 2
     *** tamaño de la forma 2^n, para n>=0
    Como podemos observar, no existe un vector vacio: ->indice del primer elemento de un vector es 0
                                                      ->indice del último elemento de un vector es size-1
                                                      ->si se intenta acceder a un vector con indice fuera de rango,
                                                      saltará un error
    Implementar vectores mediante árboles binarios perfectos con información solo en las hojas.
    Desciende por la izquierda si i es par, y por la derecha si i es impar. Se debe dividir en cada paso por 2 hasta
    alcanzar la hoja, que es donde se almacena la información
     */
    private int size;
    private Tree<T> root;

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

        //podemos suponer que los indices pasados como parametro son validos (rango 0->size-1)
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
        	List<E> l = new dataStructures.list.ArrayList<>();
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
            //desciende por la izquierda si el indice es par
            //de lo contrario, desciende por la derecha
        	if (i%2 == 0) {
                return left.get(i/2);
            } else {
                return right.get(i/2);
            }
        }

        @Override
        public void set(int i, E x) {
        	//idem que en el get
            if (i%2==0) {
                left.set(i/2,x);
            } else {
                right.set(i/2,x);
            }
        }

        @Override
        public List<E> toList() {
        	List<E> l = new dataStructures.list.ArrayList<>();
            l = intercalate(left.toList(), right.toList()); //intercalamos elementos de ambos
            return l;
        }
    }

    //inicializamos el vector de manera que su tamaño es 2^n y sus valores son todos iguales a value
    //si n es negativo, se debe elevar a una excepcion del tipo VectorException
    public TreeVector(int n, T value) {
    	if(n<0) {
            throw new VectorException("n negativo");
        } else {
            size = (int) Math.pow(2,n); //tamaño es 2^n
            root = mkTree(n,value);
        }
    }

    private Tree<T> mkTree (int n, T value) {
        if (n == 0) {
            return new Leaf<>(value);
        } else {
            return new Node<> (mkTree(n-1,value), mkTree(n-1,value));
        }
    }

    public int size() {
    	if (size==0) {
            throw new VectorException("el tamaño es 0");
        } else {
            return size;
        }
    }

    //devuelve el elemento situado en la posicion i del vector
    //ai el indice no es valido, salta una excepcion VectorException
    public T get(int i) {
    	if (i<0 || i > size-1) {
            throw new VectorException("el indice es incorrecto");
        } else {
            return this.root.get(i);
        }
    }

    //asigna el valor x al elemento del vector almacenado en la posicion i
    public void set(int i, T x) {
    	if (i<0 || i>=size) {
            throw new VectorException("indice incorrecto");
        } else {
            this.root.set(i,x);
        }
    }

    public List<T> toList() {
    	return intercalate(root.toList(), (List) null);
    }

    //dadas dos listas devuelve la intercalacion
    protected static <E> List<E> intercalate(List<E> xs, List<E> ys) {
    	List<E> res = null;
        if (xs == null) {
            res = ys;
        } else if (ys == null) {
            res = xs;
        } else {
            int min = Math.min(xs.size(),ys.size());
            res = new dataStructures.list.ArrayList<>();
            for (int i = 0 ; i < min ; i++) {
                res.append(xs.get(i));
                res.append(ys.get(i));
            }
        }
        return res;
    }

    //dado un entero no negativo devuelve true si es potencia de 2 (falso en caso contrario)
    static protected boolean isPowerOfTwo(int n) {
    	if (n==0) {
            return false;
        } else {
            while(n%2 == 0) {
                n = n/2;
            }
            return n==1;
        }
    }

    //toma una lista cuya longitud debe ser potencia de 2 y devuelve un vector de manera que el elemento iesimo
    //de la lista aparezca en la posición iesima del vector.
    //si la longitud de la lista no es potencia de 2 debe saltar una excepción de tipo VectorException
    public static <E> TreeVector<E> fromList(List<E> l) {
        TreeVector<E> res = null;
        if (!isPowerOfTwo(l.size())) {
            throw new VectorException("la lista no es potencia de 2");
        } else {
            for (int i = 0; i < l.size(); i++) {
                res = new TreeVector<>(l.size(), l.get(i));
            }
            return res;
        }
    }
}
