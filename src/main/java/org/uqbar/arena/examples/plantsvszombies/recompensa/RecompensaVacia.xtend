package org.uqbar.arena.examples.plantsvszombies.recompensa

import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie

class RecompensaVacia extends Recompensa {

	new(Zombie zombie) {
		super(zombie)
	}

	override generarRecompensa() {
		log.add("Pero lamentablemente no obtuviste ninguna recompensa.")
		log.add("Intenta nuevamente")
	}

}
