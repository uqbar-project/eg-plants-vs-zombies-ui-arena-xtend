package org.uqbar.arena.examples.plantsvszombies.ui

import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.arena.examples.plantsvszombies.mejoras.Mejora
import org.uqbar.arena.examples.plantsvszombies.mejoras.MejoraDefensiva
import org.uqbar.arena.examples.plantsvszombies.mejoras.MejoraOfensiva
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoAcuatica
import org.uqbar.arena.examples.plantsvszombies.planta.TipoTerrestre
import org.uqbar.arena.examples.plantsvszombies.repo.RepoMejoras
import org.uqbar.arena.examples.plantsvszombies.repo.RepoPlantas
import org.uqbar.arena.examples.plantsvszombies.repo.RepoZombies
import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.commons.applicationContext.ApplicationContext

class PlantsVsZombiesBootstrap extends CollectionBasedBootstrap {

	override run() {
		(ApplicationContext.instance.getSingleton(typeof(Planta)) as RepoPlantas) => [
			// Plantas
			create(create("Meduza", 45, 20, new TipoAcuatica))
			create(create("Waterprof", 50, 1, new TipoAcuatica))
			create(create("Shooter", 49, 5, new TipoTerrestre))
			create(create("Water lettuce", 33, 80, new TipoAcuatica))
			create(create("Embriofitas", 41, 50, new TipoTerrestre))
			create(create("Helecho", 30, 40, new TipoTerrestre))
			create(create("Sesamo", 50, 20, new TipoTerrestre))
			create(create("Adelfa", 90, 50, new TipoAcuatica))
			create(create("Cyperus", 95, 60, new TipoAcuatica))
			
			// Plantas de Recompensa
			agregarPlantaDeRecompensa(create("Maranta", 70, 40, new TipoTerrestre))
			agregarPlantaDeRecompensa(create("Alga", 50, 30, new TipoAcuatica))
			agregarPlantaDeRecompensa(create("Irupe", 50, 20, new TipoAcuatica))
			agregarPlantaDeRecompensa(create("Castus", 45, 20, new TipoTerrestre))
		]

		// Mejoras
		(ApplicationContext.instance.getSingleton(typeof(Mejora)) as RepoMejoras) => [
			create(new MejoraDefensiva(10, 100))
			create(new MejoraDefensiva(20, 200))
			create(new MejoraDefensiva(30, 300))
			create(new MejoraOfensiva(10, 100))
			create(new MejoraOfensiva(20, 200))
			create(new MejoraOfensiva(30, 300))
		]
		
		// Mejoras
		(ApplicationContext.instance.getSingleton(typeof(Zombie)) as RepoZombies) => [
			create("Valeent", 90, 20)
			create("Vitto", 88, 45)
			create("Yahn", 79, 83)
			create("Nemessis", 98, 20)
			create("Gravecrawler", 89, 33)
			create("Carnophage", 93, 50)
	
			create("Black Cat", 84, 50)
			create("Blackcleave Goblin", 96, 65)
			create("Blind Creeper", 91, 90)
			create("Skinthinner", 98, 34)
			create("Thraximundar", 91, 27)
			create("Woebearer", 86, 53)
			create("Ghoultree", 93, 71)
		]
		
	}

}
