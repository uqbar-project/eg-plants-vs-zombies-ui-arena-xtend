package org.uqbar.arena.examples.plantsvszombies.tablero

import org.junit.Before
import org.junit.Test
import org.uqbar.arena.examples.plantsvszombies.jardin.Casillero
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoAcuatica

import static org.junit.Assert.*

class TestCasilleros {

	Casillero casillero
	Planta planta

	@Before
	def void init() {
		casillero = new Casillero(1)
		planta = new Planta()
		planta.potenciaDeAtaque = 15
		planta.resistencia = 15
		planta.nombre = "Meduza"
		planta.setTipo= new TipoAcuatica
		planta.validar
		
	}

	@Test
	def void estaOcupadoElCasillero() {
		casillero.setPlanta(planta)
		assertTrue(casillero.estasOcupado)
	}

	@Test
	def void estaLibreElCasillero() {
		assertTrue(casillero.estasLibre)
	}
}
