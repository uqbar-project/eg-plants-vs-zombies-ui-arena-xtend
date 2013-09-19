package org.uqbar.arena.examples.plantsvszombies.ui

import java.util.ArrayList
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.examples.plantsvszombies.application.model.PlantsVsZombiesModel
import org.uqbar.arena.examples.plantsvszombies.mejoras.Mejora
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.examples.plantsvszombies.exception.PlantsVsZombiesException
import org.uqbar.commons.model.UserException

class MejoraWindow extends Dialog<PlantsVsZombiesModel> {

	new(WindowOwner owner, PlantsVsZombiesModel model) {
		super(owner, model)
	}

	override def createMainTemplate(Panel mainPanel) {
		createFormPanel(mainPanel)
		this.setTitle("Mejoras");
	}

	override protected createFormPanel(Panel mainPanel) {
		println("Planta seleccionada: " + modelObject.plantinSeleccionado.nombre)
		createHead(mainPanel)
		crearTablasDeMejoras(mainPanel)
		crearButtonAction(mainPanel)
	}

	def createHead(Panel mainPanel) {
		var headPanel = new Panel(mainPanel)
		headPanel.setLayout(new ColumnLayout(2))

		new Label(headPanel).setText("Estas mejorando la planta:")
		new Label(headPanel).bindValueToProperty("plantinSeleccionado")

		new Label(headPanel).setText("Poder Ofensivo:")
		new Label(headPanel).setWidth(50).bindValueToProperty("plantinSeleccionado.potenciaDeAtaque")

		new Label(headPanel).setText("Poder Defensivo:")
		new Label(headPanel).setWidth(50).bindValueToProperty("plantinSeleccionado.resistencia")

		new Label(headPanel).setText("Recursos:")
		new Label(headPanel).setWidth(50).bindValueToProperty("jugador.recursos")
	}

	def crearTablasDeMejoras(Panel mainPanel) {
		var tablesPanel = new Panel(mainPanel)
		tablesPanel.setLayout(new ColumnLayout(2))

		new Label(tablesPanel).setText("Mejoras Disponibles")
		new Label(tablesPanel).setText("Mejoras Compradas")

		var tableDisponibles = createResultsGridMejoras(tablesPanel, "mejoras", "mejoraDisponibleSeleccionada", 320)
		describeResultsGridDisponibles(tableDisponibles)
		var tableCompradas = createResultsGridMejoras(tablesPanel, "mejorasCompradas", "mejoraCompradaSeleccionada", 250)
		describeResultsGridCompradas(tableCompradas)
	}

	def protected createResultsGridMejoras(Panel mainPanel, String itemProperty, String valueProperty, int witdth) {
		var table = new Table<Mejora>(mainPanel, typeof(Mejora))
		table.heigth = 180
		table.width = witdth
		table.bindItemsToProperty(itemProperty)
		table.bindValueToProperty(valueProperty)
		table
	}

	def describeResultsGridDisponibles(Table<Mejora> table) {
		new Column<Mejora>(table).setTitle("Mejora").bindContentsToProperty("nombre");
		new Column<Mejora>(table).setTitle("Costo").setFixedSize(70).bindContentsToProperty("costo");
	}

	def describeResultsGridCompradas(Table<Mejora> table) {
		new Column<Mejora>(table).setTitle("Mejora").bindContentsToProperty("nombre");
	}

	def crearButtonAction(Panel mainPanel) {
		var buttonPanel = new Panel(mainPanel)
		buttonPanel.setLayout(new ColumnLayout(2))

		var rightPanel = new Panel(buttonPanel)
		rightPanel.setLayout(new ColumnLayout(3))
		var comprarButton = new Button(rightPanel).setCaption("Comprar").onClick[|comprar]
		comprarButton.bindEnabled(new NotNullObservable("mejoraDisponibleSeleccionada"))
		comprarButton.disableOnError
		new Button(rightPanel).setAsDefault().setCaption("Cerrar").onClick[|this.close]
		new Button(rightPanel).setCaption("Jardin Zen").onClick[|verJardinZen]
	}

	def verJardinZen() {
		this.close
		new JardinZenWindow(this, modelObject).open
	}

	def comprar() {
		try {
			modelObject.mejorarPlanta
			actualizarTablas
		} catch (PlantsVsZombiesException e) {
			throw new UserException(e.message)
		}
	}

	def actualizarTablas() {
		var mejoras = modelObject.mejoras as ArrayList<Mejora>
		modelObject.mejoras = null
		modelObject.mejoras = mejoras

		mejoras = modelObject.mejorasCompradas as ArrayList<Mejora>
		modelObject.mejorasCompradas = null
		modelObject.mejorasCompradas = mejoras
	}
}
