import java.util.Arrays;

public class BinaryHeap<T extends Comparable<? super T>> implements Heap<T>{

    private T elements[]; //array para almacenar los elementos del monticulo
    private int size; //numero de elementos del monticulo
    private static final int TAM = 128; //tam inicial del array

    public BinaryHeap() {
        elements =(T[]) new Comparable[TAM];
        size = 0;
    }

    //amplia el array en el caso de que sea necesario
    private void ensureCapacity(){
        if(size==elements.length){
            elements= Arrays.copyOf(elements, 2*elements.length);
        }
    }

    @Override
    public boolean isEmpty() {
        return size == 0;
    }

    @Override
    public int size() {
        return size;
    }

    private boolean lessThan(int id1, int id2) {
        return elements[id1].compareTo(elements[id2]) < 0;
    }

    private void swap(int id1, int id2) {
        T aux = elements[id1];
        elements[id1] = elements[id2];
        elements[id2] = aux;
    }

    private static final int ROOT = 0;
    private static boolean isRoot (int id){
        return id==ROOT;
    }
    private static int parent(int idx) { // index for parent of node with index idx
        return (idx-1) / 2; // integer division
    }
    private static int leftChild(int idx) { // index for left child of node with index idx
        return 2*idx + 1;
    }
    private static int rightChild(int idx) { // index for right child of node with index idx
        return 1 + leftChild(idx);
    }
    private boolean isNode(int idx) { // true if idx corresponds to index of a node in tree
        return idx<size;
    }
    private boolean hasLeftChild(int idx) { // true if node with index idx has a left child
        return isNode(leftChild(idx));
    }
    private boolean isLeaf(int idx) { // true if node with index idx is a leaf node
        return !hasLeftChild(idx); // !hasLeftChild(idx) ⇒ !hasRightChild(idx)
    }

    @Override
    public void insert(T x) {
        ensureCapacity(); //nos aseguramos de que hay capacidad suficiente
        elements[size] = x; //ponemos el nuevo nodo como último elemento más a la izquierda (o derecha si no queda hueco)
        heapifyUp(size); //vamos ascenidendo el nuevo nodo intercambiándolo con el padre hasta que tome el lugar que le corresponda
        size++; //ampliamos el tamaño ajustándolo al nuevo nodo insertado
    }

    private void heapifyUp(int id) {
        while(!isRoot(id)) { //mientras que el nuevo nodo no sea la raiz:
            int idPar = parent(id); //guardamos el nodo del padre
            //si el nodo que pasamos como parametro es menor que el nodo del padre
            if (lessThan(id,idPar)) { //less than compara el contenido del array de esos indices, NO LOS INDICES EN SI
                swap(id,idPar); //hacemos que el id sea el padre y el padre sea el hijo (cambiamos)
                id = idPar;//IMPORTANTE PARA LA SIGUIENTE ITERACION: el nuevo elemento esta en el indice del padre ahora
            }
            else break;
        }
    }

    @Override
    public T minElem() {
        if (isEmpty()) {
            throw new EmptyHeapException("monticulo vacio");
        }
        return elements[ROOT];
    }

    @Override
    public void delMin() {
        if (isEmpty()) {
            throw new EmptyHeapException("monticulo vacio");
        }
        elements[ROOT] = elements[size-1]; //IMPORTANTE: size-1 porque en size no hay ningun elemento
        //PONEMOS EL ULTIMO ELEMENTO COMO RAIZ
        heapifyDown();
        size--;
    }

    private void heapifyDown() {
        //baja el elemento puesto en la raiz hasta que se cumple la propiedad
        int id = ROOT;
        while (!isLeaf(id)) {
            int idChild = leftChild(id); //suponemos que el menor es el izquierdo
            int idr = rightChild(id);

            if(isNode(idr) && lessThan(idr,idChild)) {
                //como resulta que le dcho es menor que el izq lo cambiamos
                idChild = idr;
            }

            //ya tenemos el menor hijo, asi que hacemos el swap si es menor que la raiz
            if (lessThan(idChild,id)) {
                swap(idChild,id);
                id=idChild;
            } else break;
        }
    }
}
