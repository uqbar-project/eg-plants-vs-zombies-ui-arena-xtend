package org.uqbar.arena.examples.plantsvszombies.recompensa

import java.util.List
import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import java.util.ArrayList
import org.uqbar.commons.utils.Observable

@Observable
abstract class Recompensa {
	@Property List<String> log = new ArrayList
	protected Zombie zombie

	new(Zombie unZombie) {
		zombie = unZombie
		addDefaultLog
	}

	def protected addDefaultLog() {
		_log.add("Felicitaciones!!. Venciste al zombie: " + zombie.nombre)
	}

	def void generarRecompensa()
}
