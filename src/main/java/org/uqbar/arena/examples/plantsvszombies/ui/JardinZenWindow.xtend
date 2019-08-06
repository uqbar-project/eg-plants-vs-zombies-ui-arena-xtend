package org.uqbar.arena.examples.plantsvszombies.ui

import org.uqbar.arena.examples.plantsvszombies.application.model.PlantsVsZombiesModel
import org.uqbar.arena.examples.plantsvszombies.planta.Planta
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.arena.bindings.NotNullObservable

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class JardinZenWindow extends Dialog<PlantsVsZombiesModel> {

	new(WindowOwner owner, PlantsVsZombiesModel model) {
		super(owner, model)
		this.title = "JardinZen " + modelObject.tipoDePlantaSeleccionada
	}

	override protected createFormPanel(Panel mainPanel) {
		val infoPanel = new Panel(mainPanel)
		infoPanel.layout = new ColumnLayout(2)
		new Label(infoPanel).text = "JardinZen " + modelObject.tipoDePlantaSeleccionada.nombreDePantalla
		new Label(infoPanel).width = 90
		new Label(infoPanel).text = "Lugares libres: "
		new Label(infoPanel).value <=> "cantidadDeLugaresDisponibles"
		createResultsGrid(mainPanel)

		val seleccionPanel = new Panel(mainPanel)
		seleccionPanel.layout = new ColumnLayout(3)
		new Label(seleccionPanel).text = "Seleccionado: "
		new Label(seleccionPanel) => [
			width = 100
			value <=> "plantinSeleccionado.nombre"
		]
		new Button(seleccionPanel) => [
			caption = "Mejorar"
			onClick[|this.mejorarPlantas]
			bindEnabled(new NotNullObservable("plantinSeleccionado")) 
		]

		val accionesPanel = new Panel(mainPanel)
		accionesPanel.layout = new ColumnLayout(2)
		
		new Button(accionesPanel) => [
			setAsDefault
			caption = "Jugar"
			onClick[|this.close()]
		]

		modelObject.cambiarTipoDePlanta
		val otroTipoDeJardin = "Ir al jardin " + modelObject.tipoDePlantaSeleccionada.nombreDePantalla
		modelObject.cambiarTipoDePlanta
		new Button(accionesPanel) => [
			caption = otroTipoDeJardin
			onClick[|this.verJardinZen] 		
		]
	}

	def verJardinZen() {
		this.close()
		modelObject.cambiarTipoDePlanta
		openDialog(new JardinZenWindow(this, modelObject))
	}

	def mejorarPlantas() {
		this.close()
		modelObject.cambiarTipoDePlanta
		openDialog(new MejoraWindow(this, modelObject))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.open
	}

	def protected createResultsGrid(Panel mainPanel) {
		this.describeResultsGrid(
			new Table<Planta>(mainPanel, Planta) => [
				height = 180
				width = 300
				items <=> "plantas"
				value <=> "plantinSeleccionado"
			]
		)
	}

	def describeResultsGrid(Table<Planta> table) {
		new Column<Planta>(table) => [
			title = "Planta"
			fixedSize = 100
			bindContentsToProperty("nombre")
		]
		new Column<Planta>(table) => [
			title = "P. Defensivo"
			fixedSize = 110
			bindContentsToProperty("resistencia")
		]
		new Column<Planta>(table) => [
			title = "P. Ofensivo"
			fixedSize = 90 
			bindContentsToProperty("potenciaDeAtaque")
		]
	}

	override protected ErrorsPanel createErrorsPanel(Panel mainPanel) {
	}

}
