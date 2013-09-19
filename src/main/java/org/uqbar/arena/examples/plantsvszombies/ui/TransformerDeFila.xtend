package org.uqbar.arena.examples.plantsvszombies.ui

import com.uqbar.commons.collections.Transformer;
import org.uqbar.arena.examples.plantsvszombies.jardin.Fila

class TransformerDeFila implements Transformer<Fila, String>{
	
	int numeroDeFila
	
	new(int numDeFila){
		numeroDeFila = numDeFila
	}
	
	override transform(Fila fila) {
		var casillero = fila.casilleros.get(numeroDeFila)
		if ( casillero.estasOcupado)
			casillero.planta.toString
		else
			""
	}
	
}