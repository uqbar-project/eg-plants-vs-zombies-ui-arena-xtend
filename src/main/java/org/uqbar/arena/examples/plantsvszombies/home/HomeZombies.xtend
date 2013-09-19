package org.uqbar.arena.examples.plantsvszombies.home

import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.commons.model.CollectionBasedHome

class HomeZombies extends CollectionBasedHome<Zombie> {

	new() {
		this.init
	}

	def void init() {
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
	}

	def create(String nombre, int resistencia, int potenciaDeAtaque) {
		var zombie = new Zombie
		zombie.nombre = nombre.trim
		zombie.resistencia = resistencia
		zombie.potenciaDeAtaque = potenciaDeAtaque
		zombie.energia = resistencia
		this.create(zombie)
	}

	override protected getCriterio(Zombie example) {
		null
	}

	override createExample() {
		new Zombie
	}

	override getEntityType() {
		typeof(Zombie)
	}

	def search(String unZombie) {
		var todos = allInstances
		if (unZombie.nullOrEmpty) {
			return todos.toList
		} else {
			return  todos.filter[z|z.toString().toLowerCase().contains(unZombie.trim.toLowerCase())].toList
		}
		
	}

}
