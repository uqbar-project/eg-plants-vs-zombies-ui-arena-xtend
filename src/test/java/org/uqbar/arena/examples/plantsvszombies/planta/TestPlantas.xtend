package org.uqbar.arena.examples.plantsvszombies.planta

import org.junit.Test

import static org.junit.Assert.*
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.exception.ConfigurationException

class TestPlantas {
	Planta planta
	
	@Test(expected=typeof(ConfigurationException))
	def void plantaConPoderDeAtaqueCero() {
		planta = new Planta()
		planta.potenciaDeAtaque = 0
		planta.resistencia = 0
		planta.nombre = "Meduza"
		planta.validar
	}
	
	@Test 
	def void plantaTienePoderDeAtaque(){
		planta = new Planta()
		planta.potenciaDeAtaque = 1
		planta.resistencia = 1
		planta.nombre = "Sirasol"
		assertTrue(planta.resistencia == 1)
	}
	
}