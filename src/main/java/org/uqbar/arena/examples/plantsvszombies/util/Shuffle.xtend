package org.uqbar.arena.examples.plantsvszombies.util

import java.util.List
import java.util.Random

class Shuffle<T> {

	//Algortimo de shuffle
	def doTask(List<T> elementos) {
		var cantidadDeElementos = elementos.size
		var rand = new Random();
		for (i : 0 ..< cantidadDeElementos) {
			var numeroRandom = rand.nextInt(i + 1);
			var swp = elementos.get(numeroRandom)
			elementos.set(numeroRandom, elementos.get(i))
			elementos.set(i, swp)
		}
		elementos
	}

}
