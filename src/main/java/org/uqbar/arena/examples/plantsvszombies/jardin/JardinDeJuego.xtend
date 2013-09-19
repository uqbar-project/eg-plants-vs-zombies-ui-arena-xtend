package org.uqbar.arena.examples.plantsvszombies.jardin

import java.util.ArrayList
import java.util.List
import java.util.Random
import org.uqbar.commons.utils.Observable
import org.uqbar.arena.examples.plantsvszombies.planta.TipoDePlanta
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.examples.plantsvszombies.exception.ConfigurationException
import org.uqbar.arena.examples.plantsvszombies.planta.TipoTerrestre
import org.uqbar.arena.examples.plantsvszombies.planta.TipoAcuatica

@Observable
class JardinDeJuego implements Jardin {
	@Property val numeroDeCasillerosPorFila = 5
	int numeroDeFilas
	int numeroDeCasilleros
	@Property List<Fila> filas

	def void crearTablero(int numeroDeFilas, int numeroDeCasilleros) {
		_filas = new ArrayList
		this.setNumeroDeFilas(numeroDeFilas)
		this.setNumeroDeCasilleros(numeroDeCasilleros)
		for (i : 0 ..< numeroDeFilas) {
			var fila = new Fila(numeroDeCasilleros)
			setearTipoAlaFila(fila)
			fila.setNumeroDeDFila(i)
			_filas.add(fila)
		}
	}

	def setearTipoAlaFila(Fila fila) {
		val rand = new Random();
		val x = rand.nextInt(2);
		if (0 == x) {
			fila.setTipo(new TipoAcuatica)
		} else {
			fila.setTipo(new TipoTerrestre)
		}
	}

	def setNumeroDeFilas(int numeroDeFilasDelTablero) {
		if (numeroDeFilasDelTablero < 1)
			throw new ConfigurationException("Numero de filas del tablero no valido: " + numeroDeFilasDelTablero)
		this.numeroDeFilas = numeroDeFilasDelTablero
	}

	def setNumeroDeCasilleros(int numeroDeCasillerosDeCadaFila) {
		if (numeroDeCasillerosDeCadaFila < 1 || numeroDeCasillerosDeCadaFila > getNumeroDeCasillerosPorFila)
			throw new ConfigurationException(
				"Numero de casilleros de cada fila del tablero no valido: " + numeroDeCasillerosDeCadaFila)
		this.numeroDeCasilleros = numeroDeCasillerosDeCadaFila
	}

	def getNumeroDeFilasDelTablero() {
		_filas.length
	}

	def getNumeroDeFila(int numeroDeFila) {
		_filas.get(numeroDeFila)
	}

	def estaElCasilleroOcupado(int fila, int casillero) {
		_filas.get(fila).estaOcupadoElCasillero(casillero)
	}

	def agregarPlantaAlaFila(Planta planta, int numeroDeFila) {
		_filas.get(numeroDeFila).agregaUnaPlanta(planta)
	}

	def hayLugarEnLaFila(int fila) {
		_filas.get(fila).hayLugarDisponible
	}

	override cantidadDePlantasDeUnTipo(TipoDePlanta unTipo) {
		var plantasDeunTipo = _filas.filter[f|f.tipo.equals(unTipo)]
		var totalDePlantas = plantasDeunTipo.map[f|f.cantidadDeCasillerosOcupados].reduce[cantidadTotal, cantidadPorFila|
			cantidadTotal + cantidadPorFila]
		return totalDePlantas
	}

}
