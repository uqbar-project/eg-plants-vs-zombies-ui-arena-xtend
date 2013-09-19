package org.uqbar.arena.examples.plantsvszombies.recompensa

import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie

class RecompensaPerdiste extends Recompensa {

	new(Zombie unZombie) {
		super(unZombie)
	}

	override generarRecompensa() {
		log.clear
		log.add("El zombie " + zombie.nombre + " vencio a todas tus plantas del jardin.")
		log.add("Intenta nuevamente.")
	}

}
