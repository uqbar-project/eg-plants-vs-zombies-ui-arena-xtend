package org.uqbar.arena.examples.plantsvszombies.home

import org.uqbar.commons.model.CollectionBasedHome
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoDePlanta
import java.util.List
import java.util.ArrayList
import java.util.Random
import org.uqbar.arena.examples.plantsvszombies.planta.TipoAcuatica
import org.uqbar.arena.examples.plantsvszombies.planta.TipoTerrestre

class HomePLantas extends CollectionBasedHome<Planta> {

	List<Planta> plantasDeRecompensa = new ArrayList

	new() {
		this.init
	}

	def void init() {
		agregarPlanta(create("Meduza", 45, 20, new TipoAcuatica))
		agregarPlanta(create("Waterprof", 50, 1, new TipoAcuatica))
		agregarPlanta(create("Shooter", 49, 5, new TipoTerrestre))
		agregarPlanta(create("Water lettuce", 33, 80, new TipoAcuatica))
		agregarPlanta(create("Embriofitas", 41, 50, new TipoTerrestre))
		agregarPlanta(create("Helecho", 30, 40, new TipoTerrestre))
		agregarPlanta(create("Sesamo", 50, 20, new TipoTerrestre))
		agregarPlanta(create("Adelfa", 90, 50, new TipoAcuatica))
		agregarPlanta(create("Cyperus", 95, 60, new TipoAcuatica))
		crearPlantasDeRecompensa
	}

	def create(String nombre, int resistencia, int potenciaDeAtaque, TipoDePlanta tipoDePlanta) {
		var planta = new Planta
		planta.nombre = nombre.trim
		planta.resistencia = resistencia
		planta.potenciaDeAtaque = potenciaDeAtaque
		planta.tipo = tipoDePlanta
		planta.energia = resistencia
		planta
	}

	def agregarPlanta(Planta planta) {
		this.create(planta)
	}

	override protected getCriterio(Planta example) {
		null
	}

	override createExample() {
		new Planta
	}

	override getEntityType() {
		typeof(Planta)
	}

	def getPlantasDeUnTipo(TipoDePlanta tipo) {
		allInstances.filter[planta|planta.tipo.equals(tipo)].toList
	}

	def crearPlantasDeRecompensa() {
		plantasDeRecompensa.add(create("Maranta", 70, 40, new TipoTerrestre))
		plantasDeRecompensa.add(create("Alga", 50, 30, new TipoAcuatica))
		plantasDeRecompensa.add(create("Irupe", 50, 20, new TipoAcuatica))
		plantasDeRecompensa.add(create("Castus", 45, 20, new TipoTerrestre))
	}

	def getUnaPlantaDeRecompensa() {
		var rand = new Random();
		var numeroRandom = rand.nextInt(plantasDeRecompensa.size)
		plantasDeRecompensa.get(numeroRandom)
	}

}
