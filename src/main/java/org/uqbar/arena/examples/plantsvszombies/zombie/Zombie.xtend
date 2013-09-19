package org.uqbar.arena.examples.plantsvszombies.zombie

import org.uqbar.arena.examples.plantsvszombies.personaje.Personaje

class Zombie extends Personaje {

	override poderDeAtaqueMinimo() {
		10
	}

	override poderDeAtaqueMaximo() {
		100
	}

	override resistenciaMinima() {
		50
	}

	override resistenciaMaxima() {
		100
	}

	

}
