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
		this.setTitle("Almanaque Zombie");
	}

	override protected createFormPanel(Panel mainPanel) {
		var zombieSeleccionadoPanel = new Panel(mainPanel)
		zombieSeleccionadoPanel.setLayout(new ColumnLayout(1))
		new Label(zombieSeleccionadoPanel).setText("Almanaque Zombie")

		//Panel general de busqueda de panel
		var buscadorPanel = new Panel(mainPanel)
		buscadorPanel.setLayout(new ColumnLayout(2))

		//Cuadro de buscador de zombies
		var buscardorDeZombiePanel = new Panel(buscadorPanel)
		buscardorDeZombiePanel.setLayout(new ColumnLayout(2))
		new Label(buscardorDeZombiePanel).setText("Buscar Zombie:")
		new TextBox(buscardorDeZombiePanel).withFilter(new ZombieSearchFilter(modelObject))
		createResultsGrid(buscardorDeZombiePanel)

		addBuscadorPanel(buscadorPanel)
		addActions(mainPanel)

	}

	def addBuscadorPanel(Panel buscadorPanel) {

		//Panel de info del zombie
		var panelDeInfoDelZombie = new Panel(buscadorPanel)
		panelDeInfoDelZombie.setLayout(new ColumnLayout(2))
		new Label(panelDeInfoDelZombie).setText("Nombre:")
		new Label(panelDeInfoDelZombie).setWidth(90).bindValueToProperty("zombieSeleccionado")
		new Label(panelDeInfoDelZombie).setText("Ataque:")
		new Label(panelDeInfoDelZombie).bindValueToProperty("zombieSeleccionado.potenciaDeAtaque")
		new Label(panelDeInfoDelZombie).setText("Defensa:")
		new Label(panelDeInfoDelZombie).bindValueToProperty("zombieSeleccionado.resistencia")
		new Label(panelDeInfoDelZombie).bindValueToProperty("zombieSeleccionado.descripcion")

	}

	override addActions(Panel mainPanel) {
		var panelDeBotones = new Panel(mainPanel)
		panelDeBotones.setLayout(new ColumnLayout(2))
		var botonera = new Panel(panelDeBotones)
		botonera.setLayout(new ColumnLayout(2))
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
		var table = new Table<Zombie>(mainPanel, typeof(Zombie))
		table.heigth = 160
		table.width = 120
		table.bindItemsToProperty("zombies")
		table.bindValueToProperty("zombieSeleccionado")
		this.describeResultsGrid(table)
	}

	def describeResultsGrid(Table<Zombie> table) {
		new Column<Zombie>(table).setTitle("Zombie").setFixedSize(75).bindContentsToProperty("nombre").setWeight(70)
	}

}
