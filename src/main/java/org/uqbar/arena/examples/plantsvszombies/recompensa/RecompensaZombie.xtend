package org.uqbar.arena.examples.plantsvszombies.recompensa

import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import java.util.Random
import org.uqbar.arena.examples.plantsvszombies.personaje.Jugador

class RecompensaZombie extends Recompensa {

	Jugador jugador

	new(Zombie zombie, Jugador unJugador) {
		super(zombie)
		jugador = unJugador
	}

	override generarRecompensa() {
		var rand = new Random();
		var recursos = rand.nextInt(zombie.resistencia / 3)

		jugador.agregarRecursos(recursos)
		log.add("Obtuviste " + recursos + " puntos de recompensa.")
	}

}
