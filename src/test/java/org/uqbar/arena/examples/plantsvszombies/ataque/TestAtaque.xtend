package org.uqbar.arena.examples.plantsvszombies.ataque

import org.junit.Before
import org.junit.Test
import org.uqbar.arena.examples.plantsvszombies.jardin.Fila
import org.uqbar.arena.examples.plantsvszombies.planta.TipoAcuatica
import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.commons.model.UserException

class TestAtaque {

	Zombie unZombie
	Fila unaFila

	@Before
	def void init() {
		unZombie = new Zombie
		unZombie.potenciaDeAtaque = 90
		unZombie.resistencia = 50
		unZombie.nombre = "Cerebrito"
		unZombie.validar

		unaFila = new Fila(5)
		unaFila.setTipo(new TipoAcuatica)

	}
	
	@Test(expected=typeof(UserException))
	def void atacarFilaSinPlantas(){
		new Ataque(unaFila, unZombie)
	}
	
	
}
