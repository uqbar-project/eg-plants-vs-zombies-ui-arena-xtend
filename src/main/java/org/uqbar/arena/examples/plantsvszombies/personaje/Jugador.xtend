package org.uqbar.arena.examples.plantsvszombies.personaje

import org.uqbar.commons.utils.Observable
import org.uqbar.commons.model.UserException

@Observable
class Jugador {
	String nombre
	@Property int recursos

	new(String nombreDelJugador) {
		nombre = nombreDelJugador
		_recursos = 400
	}

	def getNombre() {
		nombre
	}

	def agregarRecursos(int nuevosRecursos) {
		if (0 >= nuevosRecursos) {
			throw new UserException("Los nuevos recursos deben ser positivos. Recursos: " + nuevosRecursos)
		}
		_recursos = _recursos + nuevosRecursos
	}
}
