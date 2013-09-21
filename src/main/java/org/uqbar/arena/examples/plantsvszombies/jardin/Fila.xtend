package org.uqbar.arena.examples.plantsvszombies.jardin

import java.util.ArrayList
import java.util.List
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.planta.TipoDePlanta
import org.uqbar.commons.utils.Observable
import org.uqbar.arena.examples.plantsvszombies.exception.ConfigurationException
import org.uqbar.arena.examples.plantsvszombies.exception.TipoInvalidoDePlantaException
import org.uqbar.arena.examples.plantsvszombies.exception.NoHayLugarException

@Observable
class Fila {
	int cantidadDeCasilleros
	@Property TipoDePlanta tipo
	@Property List<Casillero> casilleros = new ArrayList
	@Property int numeroDeDFila

	new(int cantidadDeCasilleros) {
		this.setCantidadDeCasilleros(cantidadDeCasilleros)
		this.crearCasilleros()
	}

	def setCantidadDeCasilleros(int cantidadDeCasillerosPorFila) {
		if (cantidadDeCasillerosPorFila < 1)
			throw new ConfigurationException("Cantidad de casilleros por fila no valido: " + cantidadDeCasillerosPorFila)
		cantidadDeCasilleros = cantidadDeCasillerosPorFila
	}

	def void crearCasilleros() {
		(1 .. cantidadDeCasilleros).forEach[numeroDeCasillero|getCasilleros.add(new Casillero(numeroDeCasillero))]
	}

	def getCantidadDeCasilleros() {
		getCasilleros.length
	}

	def estaOcupadoElCasillero(int numeroDeCasillero) {
		getCasilleros.get(numeroDeCasillero).estasOcupado()
	}

	def agregaUnaPlantaAlCasillero(Planta planta, int numeroDeCasillero) {
		if (!getTipo.equals(planta.getTipo))
			throw new TipoInvalidoDePlantaException(
				"La fila es de tipo " + getTipo.toString + " y la planta de tipo " + planta.getTipo.toString)
		if (numeroDeCasillero < 0 || numeroDeCasillero > getCantidadDeCasilleros)
			throw new NoHayLugarException("El numero de casillero debe ser entre 1 y " + getCantidadDeCasilleros)

		var casillero = _casilleros.get(numeroDeCasillero)
		if (casillero.estasOcupado)
			throw new NoHayLugarException(
				"No hay lugar en la fila para agregar una nueva planta en el casillero " + (numeroDeCasillero + 1))

		casillero.setPlanta(planta.clone as Planta)
	}

	def hayLugarDisponible() {
		(_casilleros.filter[c|c.estasLibre]).size > 0
	}

	def setTipo(TipoDePlanta tipoDePlanta) {
		_tipo = tipoDePlanta
	}

	def cantidadDeCasillerosLibres() {
		(getCasilleros.filter[c|c.estasLibre]).size
	}

	def int cantidadDeCasillerosOcupados() {
		_casilleros.size - this.cantidadDeCasillerosLibres
	}

	def List<Casillero> getCasilleros() {
		_casilleros
	}

	def casillerosOcupados() {
		_casilleros.filter[c|c.estasOcupado].toList
	}

	def estaVacia() {
		var casillerosLibres = _casilleros.filter[c|c.estasLibre].size
		casillerosLibres == _casilleros.size
	}

	def removerPlantasMuertas() {
		for (Casillero c : _casilleros) {
			if (c.estaMuertaLaPlanta) {
				c.eliminaLaPlanta
			}
		}
	}
	
	def agregaUnaPlanta(Planta planta){
		var casilleroLibre = _casilleros.filter[c| c.estasLibre].toList
		if ( casilleroLibre.size == 0){
			throw new NoHayLugarException("No hay lugar para agregar a la planta " + planta.nombre)
		}
		casilleroLibre.get(0).planta = planta
	}

}