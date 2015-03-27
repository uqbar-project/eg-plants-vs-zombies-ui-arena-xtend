package org.uqbar.arena.examples.plantsvszombies.ui

import org.uqbar.arena.examples.plantsvszombies.application.model.PlantsVsZombiesModel
import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.windows.WindowOwner

class AlmanaqueZombieWindow extends Dialog<PlantsVsZombiesModel> {

	new(WindowOwner owner, PlantsVsZombiesModel model) {
		super(owner, model)
	}

	override def createMainTemplate(Panel mainPanel) {
		createFormPanel(mainPanel)

		//Titulos
		title = "Almanaque Zombie"
	}

	override protected createFormPanel(Panel mainPanel) {
		val zombieSeleccionadoPanel = new Panel(mainPanel)
		zombieSeleccionadoPanel.layout = new ColumnLayout(1)
		new Label(zombieSeleccionadoPanel).text = "Almanaque Zombie"

		//Panel general de busqueda de panel
		val buscadorPanel = new Panel(mainPanel)
		buscadorPanel.setLayout(new ColumnLayout(2))

		//Cuadro de buscador de zombies
		val buscadorDeZombiePanel = new Panel(buscadorPanel)
		buscadorDeZombiePanel.layout = new ColumnLayout(2)
		new Label(buscadorDeZombiePanel).text = "Buscar Zombie:"
		new TextBox(buscadorDeZombiePanel).withFilter(new ZombieSearchFilter(modelObject))
		createResultsGrid(new Panel(buscadorDeZombiePanel))

		addBuscadorPanel(buscadorPanel)
		addActions(mainPanel)
	}

	def addBuscadorPanel(Panel buscadorPanel) {

		//Panel de info del zombie
		new Panel(buscadorPanel) => [
			it.setLayout(new ColumnLayout(2))
			new Label(it).setText("Nombre:")
			new Label(it).setWidth(90).bindValueToProperty("zombieSeleccionado")
			new Label(it).setText("Ataque:")
			new Label(it).bindValueToProperty("zombieSeleccionado.potenciaDeAtaque")
			new Label(it).setText("Defensa:")
			new Label(it).bindValueToProperty("zombieSeleccionado.resistencia")
			new Label(it).bindValueToProperty("zombieSeleccionado.descripcion")
		]

	}

	override addActions(Panel mainPanel) {
		val panelDeBotones = new Panel(mainPanel)
		panelDeBotones.layout = new ColumnLayout(2)
		val botonera = new Panel(panelDeBotones)
		botonera.layout = new ColumnLayout(2)
		new Button(botonera).setCaption("JardinZen").onClick[|irAlJardinZen()]
		new Button(botonera).setAsDefault.setCaption("Jugar").onClick[|salir]
	}

	def showAllZombies() {
		modelObject.zombies = modelObject.homeZombies.search("")
	}

	def salir() {
		showAllZombies
		close()
	}

	def irAlJardinZen() {
		showAllZombies
		this.close()
		this.openDialog(new JardinZenWindow(this, modelObject))
	}

	def openDialog(Dialog<?> dialog) {
		dialog.open
	}

	override protected ErrorsPanel createErrorsPanel(Panel mainPanel) {
	}

	def protected createResultsGrid(Panel mainPanel) {
		val table = new Table<Zombie>(mainPanel, typeof(Zombie)) => [
			height = 160
			width = 120
			bindItemsToProperty("zombies")
			bindValueToProperty("zombieSeleccionado")
		]
		this.describeResultsGrid(table)
	}

	def describeResultsGrid(Table<Zombie> table) {
		new Column<Zombie>(table).setTitle("Zombie").setFixedSize(75).bindContentsToProperty("nombre")
	}

}
