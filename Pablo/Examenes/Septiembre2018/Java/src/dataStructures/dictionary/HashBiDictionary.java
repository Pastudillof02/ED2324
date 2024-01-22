package dataStructures.dictionary;
import dataStructures.list.List;

import dataStructures.list.ArrayList;
import dataStructures.set.AVLSet;
import dataStructures.set.Set;
import dataStructures.tuple.Tuple2;

import java.util.Iterator;

/**
 * Estructuras de Datos. Grados en Informatica. UMA.
 * Examen de septiembre de 2018.
 *
 * Apellidos, Nombre:
 * Titulacion, Grupo:
 */
public class HashBiDictionary<K,V> implements BiDictionary<K,V>{
	private Dictionary<K,V> bKeys;
	private Dictionary<V,K> bValues;
	
	public HashBiDictionary() {
		bKeys = new HashDictionary<>();
		bValues = new HashDictionary<>();
	}
	
	public boolean isEmpty() {
		return bKeys.isEmpty() && bValues.isEmpty();
	}
	
	public int size() {
		return bKeys.size();
	}
	
	public void insert(K k, V v) {
		deleteByKey(k);
		deleteByValue(v);

		bKeys.insert(k,v);
		bValues.insert(v,k);
	}
	
	public V valueOf(K k) {
		return bKeys.isDefinedAt(k) ? bKeys.valueOf(k) : null;
	}
	
	public K keyOf(V v) {
		return bValues.isDefinedAt(v) ? bValues.valueOf(v) : null;
	}
	
	public boolean isDefinedKeyAt(K k) {
		return bKeys.isDefinedAt(k);
	}
	
	public boolean isDefinedValueAt(V v) {
		return bValues.isDefinedAt(v);
	}
	
	public void deleteByKey(K k) {
		if(bKeys.isDefinedAt(k))
		{
			V aux = bKeys.valueOf(k);
			bKeys.delete(k);
			bValues.delete(aux);
		}
	}
	
	public void deleteByValue(V v) {
		if (bValues.isDefinedAt(v))
		{
			K aux = bValues.valueOf(v);
			bValues.delete(v);
			bKeys.delete(aux);
		}
	}
	
	public Iterable<K> keys() {
		return bKeys.keys();
	}
	
	public Iterable<V> values() {
		return bValues.keys();
	}
	
	public Iterable<Tuple2<K, V>> keysValues() {
		return bKeys.keysValues();
	}
	
		
	public static <K,V extends Comparable<? super V>> BiDictionary<K, V> toBiDictionary(Dictionary<K,V> dict) {
		Iterator<K> iter = dict.keys().iterator();
		BiDictionary<K,V> biDi = new HashBiDictionary<>();

		for (K key : dict.keys())
		{
			for (K key2 : dict.keys())
			{
				if(!key.equals(key2) && dict.valueOf(key) == dict.valueOf(key2))
					throw new IllegalArgumentException("toBiDictionary: el diccionario no es biyectivo");
			}
		}

		while(iter.hasNext())
		{
			K key = iter.next();
			biDi.insert(key,dict.valueOf(key));
		}

		return biDi;
	}

	public <W> BiDictionary<K, W> compose(BiDictionary<V,W> bdic) {
		BiDictionary<K,W> res = new HashBiDictionary<>();
		for (K k : bKeys.keys())
		{
			for(V v : bdic.keys())
			{
				if(bKeys.valueOf(k).equals(v))
				{
					res.insert(k,bdic.valueOf(v));
				}
			}
		}
		return res;
	}
		
	public static <K extends Comparable<? super K>> boolean isPermutation(BiDictionary<K,K> bd) {
		boolean ok = true;
		for (K clave : bd.keys()) {
			for (K claveValor : bd.values()) {
				if (!bd.isDefinedKeyAt(claveValor)) {
					ok = false;
				}
			}
		}
		return ok;
	}
	
	// Solo alumnos con evaluación por examen final.
    // =====================================
	
	public static <K extends Comparable<? super K>> List<K> orbitOf(K k, BiDictionary<K,K> bd) {
		// TODO
		return null;
	}
	
	public static <K extends Comparable<? super K>> List<List<K>> cyclesOf(BiDictionary<K,K> bd) {
		// TODO
		return null;
	}

    // =====================================
	
	
	@Override
	public String toString() {
		return "HashBiDictionary [bKeys=" + bKeys + ", bValues=" + bValues + "]";
	}
	
	
}
