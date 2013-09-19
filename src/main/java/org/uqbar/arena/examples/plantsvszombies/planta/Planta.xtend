package org.uqbar.arena.examples.plantsvszombies.planta

import org.uqbar.arena.examples.plantsvszombies.personaje.Personaje
import org.uqbar.arena.examples.plantsvszombies.exception.ConfigurationException

class Planta extends Personaje implements Cloneable {
	@Property TipoDePlanta tipo

	override validar() {
		super.validar
		if (tipo == null) {
			throw new ConfigurationException("Debe configurar un tipo de planta valido")
		}
	}

	override poderDeAtaqueMinimo() {
		0
	}

	override poderDeAtaqueMaximo() {
		100
	}

	override resistenciaMinima() {
		1
	}

	override resistenciaMaxima() {
		50
	}

	def equals(TipoDePlanta unTipo) {
		unTipo.equals(getTipo)
	}

	override clone() {
		return super.clone
	}
	

}
