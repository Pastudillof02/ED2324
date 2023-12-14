/**
 * Estructuras de Datos. 2º Curso. ETSI Informática. UMA
 *
 * PRACTICA 5ª. Ejercicio 9 de la cuarta relación (montículos maxifóbicos en Java)
 *
 * (completa y sustituye los siguientes datos)
 * Titulación: Grado en Ingeniería …………………………………… [Informática | del Software | de Computadores].
 * Alumno: APELLIDOS, NOMBRE
 * Fecha de entrega:  DIA | MES | AÑO
 */

package dataStructures.heap;


/**
 * Heap implemented using maxiphobic heap-ordered binary trees.
 * @param <T> Type of elements in heap.
 */

// un montículo maxifóbico mantiene la propiedad HOP (cada cadena que tiene desde la raíz hasta la hoja es ascendente)
public class MaxiphobicHeap<T extends Comparable<? super T>> implements	Heap<T> {

	private static class Tree<E> {
		private E elem;
		private int size;
		private Tree<E> left;
		private Tree<E> right;
	}

	private static int size(Tree<?> heap) {
		return heap == null ? 0 : heap.size;
	}

	//se debe comparar las raices de los dos arboles; el valor minimo se convierte en la raiz del nuevo monticulo (hm)
	//resto de info en 3 arboles:
	//winner --> tiene la clave mayor
	//lhl --> hijo izquierdo perdedor
	//rhl --> hijo derecho perdedor
	//de esos 3 arboles, el que tenga más nodo (mayor peso) se convierte en uno de los hijos del monticulo mezcla (hm)
	//los otros 2 arboles se mezclan y se convierten en el otro hijo del monticulo hm
	private static <T extends Comparable<? super T>> Tree<T> merge(Tree<T> h1,	Tree<T> h2) {
		if (h1 == null)
			return h2;
		if (h2 == null)
			return h1;

		//primero debemos comparar ambos arboles y ver cual de los dos tiene una raiz menor
		//y despues lo convertimos en hm
		Tree<T> hm = new Tree<>();
		Tree<T> winner;
		Tree<T> lhl;
		Tree<T> rhl;

		if (h1.elem.compareTo(h2.elem) < 0) {
			//en el caso de que h1 sea menor que h2
			hm.elem = h1.elem;
			winner = h2;
			lhl = h1.left;
			rhl = h1.right;
		} else {
			hm.elem = h2.elem;
			winner = h1;
			lhl = h2.left;
			rhl = h2.right;
		}

		//ajustamos el tamaño del nuevo monticulo
		hm.size = 1 + size(hm.left) + size(hm.right);

		//establecemos que el hijo izquierdo sea aquel que tiene un mayor numero de nodos
		//usamos size(...) por si acaso son nulos para que no nos salte un error
		if (winner.size >= size(lhl) && winner.size >= size(rhl)) {
			hm.left = winner;
			hm.right = merge(lhl,rhl);
		} else if (size(lhl) >= winner.size && size(lhl) >= size(rhl)) {
			hm.left = lhl;
			hm.right = merge(winner,rhl);
		} else {
			hm.left = rhl;
			hm.right = merge(winner,lhl);
		}

		//ajustamos el tamaño del monticulo mezclado
		hm.size = 1 + size(hm.left) + size(hm.right);

		return hm;
	}

	private Tree<T> root;

	// copies a tree
	private static <T extends Comparable<? super T>> Tree<T> copy(Tree<T> h) {
		if (h==null)
			return null;
		else {
			Tree<T> h1 = new Tree<>();
			h1.elem = h.elem;
			h1.size = h.size;
			h1.left = copy(h.left);
			h1.right = copy(h.right);			
			return h1;		
		}
	}

	/**
	 * Creates an empty Maxiphobic Heap.
	 * <p>Time complexity: O(1)
	 */
	public MaxiphobicHeap() {
		root = null;
	}

	/**
	 * Copy constructor for Maxiphobic Heap. 
	 * <p>Time complexity: O(n)
	 */	
	public MaxiphobicHeap(MaxiphobicHeap<T> h) {
		root = copy(h.root);
	}
	

	/**
	 * {@inheritDoc}
	 * <p>Time complexity: O(1)
	 */
	public boolean isEmpty() {
		return root == null;
	}

	/**
	 * {@inheritDoc}
	 * <p>Time complexity: O(1)
	 */
	public int size() {
		return root == null ? 0 : root.size;
	}

	/**
	 * {@inheritDoc}
	 * <p>Time complexity: O(1)
	 * @throws <code>EmptyHeapException</code> if heap stores no element.
	 */
	public T minElem() {
		if (isEmpty())
			throw new EmptyHeapException("minElem on empty heap");
		else
			return root.elem;
	}

	/**
	 * {@inheritDoc}
	 * <p>Time complexity: O(log n)
	 * @throws <code>EmptyHeapException</code> if heap stores no element.
	 */
	public void delMin() {
		if (isEmpty())
			throw new EmptyHeapException("delMin on empty heap");
		else
			root = merge(root.left, root.right);
	}

	/**
	 * {@inheritDoc}
	 * <p>Time complexity: O(log n)
	 */
	public void insert(T value) {
		Tree<T> newHeap = new Tree<T>();
		newHeap.elem = value;
		newHeap.size = 1;
		newHeap.left = null;
		newHeap.right = null;

		root = merge(root, newHeap);
	}

	public void clear() {
		root = null;
	}

	private static String toStringRec(Tree<?> tree) {
		return tree == null ? "null" : "Node<" + toStringRec(tree.left) + ","
				+ tree.elem + "," + toStringRec(tree.right) + ">";
	}

	/**
	 * Returns representation of heap as a String.
	 */
  @Override public String toString() {
    String className = getClass().getName().substring(getClass().getPackage().getName().length()+1);

  	return className+"("+toStringRec(this.root)+")";
  }

}
