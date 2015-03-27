package org.uqbar.arena.examples.plantsvszombies.ui

import org.apache.commons.collections15.Transformer;
import org.uqbar.arena.examples.plantsvszombies.jardin.Fila

class TransformerDeFila implements Transformer<Fila, String> {

	int numeroDeFila

	new(int numDeFila) {
		numeroDeFila = numDeFila
	}

	override transform(Fila fila) {
		val casillero = fila.casilleros.get(numeroDeFila)
		if (casillero.estasOcupado) {
			casillero.planta.toString
		} else {
			""
		}
	}

}
