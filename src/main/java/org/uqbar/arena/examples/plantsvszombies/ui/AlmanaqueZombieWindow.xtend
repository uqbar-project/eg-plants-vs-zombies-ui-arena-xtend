package org.uqbar.arena.examples.plantsvszombies.ui

import org.uqbar.arena.examples.plantsvszombies.application.model.PlantsVsZombiesModel
import org.uqbar.arena.examples.plantsvszombies.zombie.Zombie
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.windows.WindowOwner
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

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

		//Panel general de busqueda de panel
		val buscadorPanel = new Panel(mainPanel)

		//Cuadro de buscador de zombies
		val buscadorDeZombiePanel = new Panel(buscadorPanel)
		buscadorDeZombiePanel.layout = new HorizontalLayout
		new Label(buscadorDeZombiePanel).text = "Buscar Zombie:"
		new TextBox(buscadorDeZombiePanel).withFilter(new ZombieSearchFilter(modelObject))

		val busquedaPanel = new Panel(buscadorPanel)
		busquedaPanel.layout = new HorizontalLayout
		createResultsGrid(new Panel(busquedaPanel))
		val detalleZombiPanel = new Panel(busquedaPanel)
		detalleZombiPanel.layout = new ColumnLayout(2)
		addBuscadorPanel(detalleZombiPanel)

		addActions(mainPanel)
	}

	def addBuscadorPanel(Panel buscadorPanel) {
		//Panel de info del zombie
		new Label(buscadorPanel).text = "Nombre:"
		new Label(buscadorPanel) => [
			width = 90
			value <=> "zombieSeleccionado"
		]
		new Label(buscadorPanel).text = "Ataque:"
		new Label(buscadorPanel).value <=> "zombieSeleccionado.potenciaDeAtaque"
		new Label(buscadorPanel).text = "Defensa:"
		new Label(buscadorPanel).value <=> "zombieSeleccionado.resistencia"
	}

	override addActions(Panel mainPanel) {
		val panelDeBotones = new Panel(mainPanel)
		panelDeBotones.layout = new ColumnLayout(2)
		
		val botonera = new Panel(panelDeBotones)
		botonera.layout = new ColumnLayout(2)
		
		new Button(botonera) => [
			caption = "JardinZen"
			onClick[|irAlJardinZen()] 
		]
		new Button(botonera) => [
			setAsDefault
			caption = "Jugar"
			onClick[|salir]
		]
	}

	def showAllZombies() {
		modelObject.zombies = modelObject.repoZombies.search("")
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
			items <=> "zombies"
			value <=> "zombieSeleccionado"
		]
		this.describeResultsGrid(table)
	}

	def describeResultsGrid(Table<Zombie> table) {
		new Column<Zombie>(table) => [
			title = "Zombie"
			fixedSize = 75
			bindContentsToProperty("nombre")
		]
	}

}
