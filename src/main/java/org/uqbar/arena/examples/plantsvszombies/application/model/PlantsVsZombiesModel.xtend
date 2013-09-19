package org.uqbar.arena.examples.plantsvszombies.application.model

import java.util.ArrayList
import java.util.List
import java.util.Random
import org.uqbar.arena.examples.plantsvszombies.ataque.Ataque
import org.uqbar.arena.examples.plantsvszombies.home.HomeMejoras
import org.uqbar.arena.examples.plantsvszombies.home.HomePLantas
import org.uqbar.arena.examples.plantsvszombies.home.HomeZombies
import org.uqbar.arena.examples.plantsvszombies.jardin.Fila
import org.uqbar.arena.examples.plantsvszombies.jardin.JardinDeJuego
import org.uqbar.arena.examples.plantsvszombies.jardin.JardinZen
import org.uqbar.arena.examples.plantsvszombies.mejoras.Mejora
import org.uqbar.arena.examples.plantsvszombies.mejoras.MejoradorDePlantas
import org.uqbar.arena.examples.plantsvszombies.personaje.Jugador
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoDePlanta
import org.uqbar.arena.examples.plantsvszombies.recompensa.Recompensador
import org.uqbar.arena.examples.plantsvszombies.util.Shuffle
import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.commons.utils.ApplicationContext
import org.uqbar.commons.utils.Observable
import org.uqbar.arena.examples.plantsvszombies.planta.TipoTerrestre
import org.uqbar.arena.examples.plantsvszombies.planta.TipoAcuatica

@Observable
class PlantsVsZombiesModel {

	@Property Jugador jugador

	//Actores principales del juego
	@Property JardinDeJuego jardinDeJuego
	@Property JardinZen jardinZen
	@Property List<Zombie> zombies

	//Selecciones
	@Property Zombie zombieSeleccionado
	@Property Fila filaSeleccionada
	@Property Planta plantinSeleccionado
	@Property Integer filaAPlantar
	@Property Integer columnaAPlantar
	@Property Mejora mejoraDisponibleSeleccionada
	@Property Mejora mejoraCompradaSeleccionada

	//Para mostrar el jardinZen
	@Property TipoDePlanta tipoDePlantaSeleccionada
	@Property Planta plantaSeleccionada

	@Property Recompensador recompensaObserver
	@Property List<Mejora> mejoras
	@Property List<Mejora> mejorasCompradas

	new() {
		inicializarElemntosDeJuego
	}

	def inicializarElemntosDeJuego() {
		_jardinDeJuego = new JardinDeJuego()
		_jardinZen = new JardinZen
		_recompensaObserver = new Recompensador
		_jugador = new Jugador("nombre x default")
		_jardinDeJuego.crearTablero(5, 5)
		agregarPlantasAlJardinDeJuego
		_tipoDePlantaSeleccionada = new TipoTerrestre
		_jardinZen.plantas = homePlantas.allInstances.toList
		_plantinSeleccionado = _jardinZen.plantas.get(0)
		crearZombies
		crearMejoras
	}

	def crearMejoras() {
		_mejoras = new ArrayList
		_mejorasCompradas = new ArrayList
		homeMejoras.allInstances.toList.forEach[m|_mejoras.add(m)]
	}

	def getCantidadDeLugaresDisponibles() {
		_jardinZen.cantidadDeLugaresLibres(_tipoDePlantaSeleccionada)
	}

	def getPlantas() {
		jardinZen.getPlantasDeUnTipo(_tipoDePlantaSeleccionada)
	}

	def atacar() {
		var ataque = new Ataque(_filaSeleccionada, _zombieSeleccionado)
		var recompensaObserver = createRecompensaObserver
		ataque.addRecompensaObserver(recompensaObserver)
		ataque.comenzarAtaque
	}

	def agregarPlantasAlJardinDeJuego() {
		var filas = jardinDeJuego.filas
		filas.forEach[fila|agregarPlantasAlaFila(fila)]
	}

	def agregarPlantasAlaFila(Fila fila) {
		var plantas = homePlantas.getPlantasDeUnTipo(fila.tipo)
		var shuffle = new Shuffle<Planta>
		plantas = shuffle.doTask(plantas)
		var cantidadDeCasilleros = fila.getCantidadDeCasilleros

		var plantasAgregadas = 0
		for (i : 0 ..< cantidadDeCasilleros) {
			var rand = new Random();
			var numeroRandom = rand.nextInt(2);
			if (numeroRandom == 1 && plantasAgregadas < plantas.size) {
				fila.casilleros.get(i).planta = plantas.get(plantasAgregadas).clone as Planta
				plantasAgregadas = plantasAgregadas + 1
			}
		}
	}

	def void crearZombies() {
		var shuffle = new Shuffle<Zombie>
		var zombies = shuffle.doTask(homeZombies.allInstances)
		var rand = new Random();
		var numeroRandom = rand.nextInt(2) + 2; //Entre 2 y 2 zombies
		_zombies = zombies.subList(0, numeroRandom)
		seleccionarZombieNumeroUno
	}

	def seleccionarZombieNumeroUno() {
		if (_zombies.size > 0)
			_zombieSeleccionado = _zombies.get(0)
	}

	def HomeZombies getHomeZombies() {
		ApplicationContext::instance.getSingleton(typeof(Zombie))
	}

	def HomePLantas getHomePlantas() {
		ApplicationContext::instance.getSingleton(typeof(Planta))
	}

	def HomeMejoras getHomeMejoras() {
		ApplicationContext::instance.getSingleton(typeof(Mejora))
	}

	def cambiarTipoDePlanta() {
		if (getTipoDePlantaSeleccionada.equals(new TipoTerrestre)) {
			_tipoDePlantaSeleccionada = new TipoAcuatica
		} else {
			_tipoDePlantaSeleccionada = new TipoTerrestre
		}
	}

	def createRecompensaObserver() {
		_recompensaObserver = new Recompensador
		_recompensaObserver.zombie = _zombieSeleccionado
		_recompensaObserver.homePlantas = homePlantas
		_recompensaObserver.jugador = _jugador
		_recompensaObserver.jardinZen = _jardinZen
		_recompensaObserver
	}

	def perdioElJuego() {
		_jardinDeJuego.filas.filter[f|f.estaVacia].size > 0
	}

	def ganoElJuego() {
		0 == _zombies.size
	}

	def mejorarPlanta() {
		var mejorador = new MejoradorDePlantas(_jugador)
		mejorador.mejorar(plantinSeleccionado, mejoraDisponibleSeleccionada)
		_mejorasCompradas.add(mejoraDisponibleSeleccionada)
	}

}
