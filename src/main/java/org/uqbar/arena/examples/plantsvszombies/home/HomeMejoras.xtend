package org.uqbar.arena.examples.plantsvszombies.home

import org.uqbar.arena.examples.plantsvszombies.mejoras.Mejora
import org.uqbar.commons.model.CollectionBasedHome
import org.uqbar.arena.examples.plantsvszombies.mejoras.MejoraDefensiva
import org.uqbar.arena.examples.plantsvszombies.mejoras.MejoraOfensiva

class HomeMejoras extends CollectionBasedHome<Mejora> {

	new() {
		this.init
	}

	def void init() {
		this.create(new MejoraDefensiva(10, 100))
		this.create(new MejoraDefensiva(20, 200))
		this.create(new MejoraDefensiva(30, 300))

		this.create(new MejoraOfensiva(10, 100))
		this.create(new MejoraOfensiva(20, 200))
		this.create(new MejoraOfensiva(30, 300))
	}

	override protected getCriterio(Mejora example) {
		null
	}

	override createExample() {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override getEntityType() {
		typeof(Mejora)
	}
}
