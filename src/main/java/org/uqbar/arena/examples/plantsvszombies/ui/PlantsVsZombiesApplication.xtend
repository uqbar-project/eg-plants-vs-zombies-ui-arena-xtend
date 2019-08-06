package org.uqbar.arena.examples.plantsvszombies.ui

import org.uqbar.arena.Application
import org.uqbar.arena.examples.plantsvszombies.mejoras.Mejora
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.repo.RepoMejoras
import org.uqbar.arena.examples.plantsvszombies.repo.RepoPlantas
import org.uqbar.arena.examples.plantsvszombies.repo.RepoZombies
import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.arena.windows.Window
import org.uqbar.commons.applicationContext.ApplicationContext

class PlantsVsZombiesApplication extends Application {
	
	new(PlantsVsZombiesBootstrap bootstrap) {
		super(bootstrap)
	}
	
	static def void main(String[] args) { 
		ApplicationContext.instance.configureSingleton(Planta, new RepoPlantas)
		ApplicationContext.instance.configureSingleton(Mejora, new RepoMejoras)
		ApplicationContext.instance.configureSingleton(Zombie, new RepoZombies)
		new PlantsVsZombiesApplication(new PlantsVsZombiesBootstrap).start()
	}

	override protected Window<?> createMainWindow() {
		return new JardinDeJuegoWindow(this)
	}
	
}