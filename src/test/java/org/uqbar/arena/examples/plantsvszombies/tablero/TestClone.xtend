package org.uqbar.arena.examples.plantsvszombies.tablero

import static org.junit.Assert.*
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.junit.Test

class TestClone {
	
	@Test
	def testclone(){
		var planta = new Planta
		planta.nombre = "a"
		println("Clonando...")
		var otraPlanta = planta.clone
		
		assertFalse(planta.equals(otraPlanta))
	}
}