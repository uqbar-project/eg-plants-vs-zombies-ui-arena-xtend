package org.uqbar.arena.examples.plantsvszombies.ui

import org.uqbar.arena.Application
import org.uqbar.arena.examples.plantsvszombies.home.HomeMejoras
import org.uqbar.arena.examples.plantsvszombies.home.HomeZombies
import org.uqbar.arena.examples.plantsvszombies.mejoras.Mejora
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.arena.windows.Window
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.arena.examples.plantsvszombies.home.HomePlantas

class PlantsVsZombiesApplication extends Application {
	
	static def void main(String[] args) { 
		new PlantsVsZombiesApplication().start()
	}

	override protected Window<?> createMainWindow() {
		ApplicationContext.instance.configureSingleton(typeof(Planta), new HomePlantas)
		ApplicationContext.instance.configureSingleton(typeof(Mejora), new HomeMejoras)
		ApplicationContext.instance.configureSingleton(typeof(Zombie), new HomeZombies)
		return new JardinDeJuegoWindow(this)
	}
	
}