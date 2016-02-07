package org.uqbar.arena.examples.plantsvszombies.ui

import java.util.List
import org.apache.commons.collections15.Transformer
import org.uqbar.arena.examples.plantsvszombies.jardin.Casillero

class TransformerDeFila implements Transformer<List<Casillero>, String> {

	int numeroDeFila

	new(int numDeFila) {
		numeroDeFila = numDeFila
	}

	override transform(List<Casillero> casilleros) {
		val casillero = casilleros.get(numeroDeFila)
		if (casillero.estasOcupado) {
			casillero.planta.toString
		} else {
			""
		}
	}

}
