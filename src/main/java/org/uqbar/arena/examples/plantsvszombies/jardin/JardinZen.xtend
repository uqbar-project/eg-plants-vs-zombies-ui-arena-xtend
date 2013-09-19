package org.uqbar.arena.examples.plantsvszombies.jardin

import java.util.List
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoDePlanta
import org.uqbar.commons.utils.Observable

@Observable
class JardinZen implements Jardin {
	@Property List<Planta> plantas

	override cantidadDePlantasDeUnTipo(TipoDePlanta unTipo) {
		_plantas.filter[p|p.tipo.equals(unTipo)].size
	}

	def cantidadDeLugaresLibres(TipoDePlanta unTipo) {
		cantidadMaximaDePlantas - cantidadDePlantasDeUnTipo(unTipo)
	}

	def agregarPlanta(Planta planta) {
		_plantas.add(planta)
	}

	def List<Planta> getPlantasDeUnTipo(TipoDePlanta unTipo) {
		_plantas.filter[p|p.tipo.equals(unTipo)].toList()
	}

}
