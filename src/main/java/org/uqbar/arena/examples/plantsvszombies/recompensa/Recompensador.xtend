package org.uqbar.arena.examples.plantsvszombies.recompensa

import java.util.List
import java.util.Random
import org.uqbar.arena.examples.plantsvszombies.home.HomePLantas
import org.uqbar.arena.examples.plantsvszombies.jardin.JardinZen
import org.uqbar.arena.examples.plantsvszombies.personaje.Jugador
import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.commons.utils.Observable

@Observable
class Recompensador implements RecompensaObserver {

	@Property Zombie zombie
	@Property HomePLantas homePlantas
	@Property JardinZen jardinZen
	@Property Jugador jugador
	@Property Recompensa recompensa
	@Property List<String> log

	def getNumeroRandomEntreCeroYuno() {
		var rand = new Random();
		rand.nextFloat()
	}

	def private darRecompensa() {
		if (getNumeroRandomEntreCeroYuno <= 0.5) {
			_recompensa = new RecompensaVacia(zombie)
		} else if (getNumeroRandomEntreCeroYuno <= 0.5) {
			_recompensa = new RecompensaDePlantas(zombie, _jardinZen, _homePlantas)
		} else {
			_recompensa = new RecompensaZombie(zombie, jugador)
		}
	}

	override darPremio() {
		if (!zombie.estasVivo) {
			darRecompensa
		} else {
			_recompensa = new RecompensaPerdiste(zombie)
		}
		_recompensa.generarRecompensa
		_log = _recompensa.log
	}
	
	

}
