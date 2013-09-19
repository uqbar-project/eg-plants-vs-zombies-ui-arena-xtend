package org.uqbar.arena.examples.plantsvszombies.mejoras

import org.uqbar.commons.model.Entity
import org.uqbar.commons.utils.Observable
import org.uqbar.arena.examples.plantsvszombies.planta.Planta

@Observable
abstract class Mejora extends Entity {
	protected String nombre
	protected int costo
	protected int valor

	new(int unValor, int unCosto) {
		costo = unCosto
		valor = unValor
		nombre = "Aumenta en " + valor + " su poder " + nombreDeMejora
	}

	def protected String getNombreDeMejora()

	def void mejorar(Planta planta)

	def getCosto() {
		costo
	}

	def getNombre() {
		nombre
	}
}
