package org.uqbar.arena.examples.plantsvszombies.mejoras

import org.uqbar.arena.examples.plantsvszombies.mejoras.Mejora
import org.uqbar.arena.examples.plantsvszombies.planta.Planta

class MejoraOfensiva extends Mejora {

	new(int unValor, int unCosto) {
		super(unValor, unCosto)
	}

	override protected getNombreDeMejora() {
		"Ofensiva"
	}

	override mejorar(Planta planta) {
		planta.potenciaDeAtaque = planta.potenciaDeAtaque + valor
	}

}
