package org.uqbar.arena.examples.plantsvszombies.mejoras

import org.uqbar.arena.examples.plantsvszombies.mejoras.Mejora
import org.uqbar.arena.examples.plantsvszombies.planta.Planta

class MejoraDefensiva extends Mejora {

	new(int unValor, int unCosto) {
		super(unValor, unCosto)
	}

	override protected getNombreDeMejora() {
		"Defensivo"
	}

	override mejorar(Planta planta) {
		planta.resistencia = planta.resistencia + valor
	}

}
