package org.uqbar.arena.examples.plantsvszombies.ui

import org.uqbar.arena.examples.plantsvszombies.application.model.PlantsVsZombiesModel
import org.uqbar.arena.widgets.TextFilter
import org.uqbar.arena.widgets.TextInputEvent
import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import java.util.List

class ZombieSearchFilter implements TextFilter {

	PlantsVsZombiesModel gameModel
	List<Zombie> zombies

	new(PlantsVsZombiesModel model) {
		gameModel = model
		zombies = model.zombies
	}

	override accept(TextInputEvent event) {
		val unZombie = event.potentialTextResult
		
		var todos = zombies
		if (unZombie.nullOrEmpty) {
			todos = todos.toList
		} else {
			 todos = todos.filter[z|z.toString().toLowerCase().contains(unZombie.trim.toLowerCase())].toList
		}
		
		gameModel.zombies = todos.toList
		true
	}
}
