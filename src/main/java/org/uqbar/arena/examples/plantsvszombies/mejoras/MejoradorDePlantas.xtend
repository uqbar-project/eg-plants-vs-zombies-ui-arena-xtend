package org.uqbar.arena.examples.plantsvszombies.mejoras

import org.uqbar.arena.examples.plantsvszombies.personaje.Jugador
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.exception.PlantsVsZombiesException

class MejoradorDePlantas {
	Jugador jugador
	
	new(Jugador unJugador){
		jugador = unJugador
	}
	
	def mejorar(Planta unaPlanta, Mejora unaMejora){
		validarRecursos(unaMejora.costo)
		unaMejora.mejorar(unaPlanta)
		jugador.recursos = jugador.recursos - unaMejora.costo
	}
	
	def validarRecursos(int costo){
		if ( costo > jugador.recursos){
			throw new PlantsVsZombiesException("Recursos insuficientes para mejorar esta planta.")
		}
	}
}