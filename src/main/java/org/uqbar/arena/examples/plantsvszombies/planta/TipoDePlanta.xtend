package org.uqbar.arena.examples.plantsvszombies.planta

import org.uqbar.commons.utils.Observable

@Observable
abstract class TipoDePlanta {

	@Property String tipo

	override toString() {
		_tipo
	}

	def equals(TipoDePlanta unTipo) {
		getTipo == unTipo.getTipo
	}

	def equals(String unTipo) {
		getTipo == unTipo
	}

	def String nombreDePantalla()

}
