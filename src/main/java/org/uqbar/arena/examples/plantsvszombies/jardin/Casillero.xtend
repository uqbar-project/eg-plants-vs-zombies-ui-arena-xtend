package org.uqbar.arena.examples.plantsvszombies.jardin

import org.uqbar.commons.utils.Observable
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.exception.ConfigurationException

@Observable
class Casillero {
	@Property Planta planta
	int numeroDeCasillero

	new(int elNumeroDeCasillero) {
		numeroDeCasillero = elNumeroDeCasillero
	}

	def validar() {
		if (numeroDeCasillero <= 0) {
			throw new ConfigurationException(
				"El numero del casillero debe ser mayor igual a cero. Valor: " + numeroDeCasillero)
		}
	}

	def estasOcupado() {
		getPlanta != null
	}

	def estasLibre() {
		!estasOcupado
	}

	def getNumeroDeCasillero() {
		numeroDeCasillero
	}

	def eliminaLaPlanta() {
		_planta = null
	}

	def estaMuertaLaPlanta() {
		estasOcupado && !_planta.estasVivo 
	}

}
