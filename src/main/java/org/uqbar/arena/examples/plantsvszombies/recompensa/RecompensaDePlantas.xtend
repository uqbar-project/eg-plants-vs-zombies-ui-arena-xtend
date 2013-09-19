package org.uqbar.arena.examples.plantsvszombies.recompensa

import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.arena.examples.plantsvszombies.home.HomePLantas
import org.uqbar.arena.examples.plantsvszombies.jardin.JardinZen

class RecompensaDePlantas extends Recompensa {

	HomePLantas homePlantas
	JardinZen jardinZen

	new(Zombie zombie, JardinZen unJardin, HomePLantas laHomePlantas) {
		super(zombie)
		homePlantas = laHomePlantas
		jardinZen = unJardin
	}

	def getPlantaDeRecompensa() {
		var planta = homePlantas.getUnaPlantaDeRecompensa
		jardinZen.agregarPlanta(planta)
		planta
	}

	override generarRecompensa() {
		var planta = plantaDeRecompensa
		log.add("Obtuviste la planta " + planta.nombre + " de recompensa del tipo " + planta.tipo)
	}

}
