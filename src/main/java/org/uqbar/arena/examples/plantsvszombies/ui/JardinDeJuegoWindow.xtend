package org.uqbar.arena.examples.plantsvszombies.ui

import org.apache.commons.lang.StringUtils
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.examples.plantsvszombies.application.model.PlantsVsZombiesModel
import org.uqbar.arena.examples.plantsvszombies.jardin.Fila
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

class JardinDeJuegoWindow extends SimpleWindow<PlantsVsZombiesModel> {

	new(WindowOwner parent) {
		super(parent, new PlantsVsZombiesModel)
		title = "Plantas vs Zombies"
		taskDescription = "Seleccione el zombie y la fila a atacar."
	}

	override def createMainTemplate(Panel mainPanel) {
		mainPanel.setLayout(new VerticalLayout)
		createFormPanel(mainPanel)
	}

	override protected createFormPanel(Panel mainPanel) {
		addButtons(mainPanel)
		addPanelPlantasyZombies(mainPanel)
		addPlantinesPanel(mainPanel)
		addActionsPanel(mainPanel)
	}

	def addActionsPanel(Panel mainPanel) {
		new List<String>(mainPanel) => [
			bindItemsToProperty("recompensaObserver.log")
			height = 70
			width = 150
		]
	}

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel).setCaption("Ir al jardin Zen").onClick[|this.verJardinZen]
		new Button(actionsPanel).setCaption("Reiniciar").onClick(|this.reiniciarJuego)
		new Button(actionsPanel).setCaption("Almanaque").onClick[|this.verAlmanaqueZombie]
	}

	def addPlantinesPanel(Panel mainPanel) {
		//Panel de pantines
		val plantinesPanelContenedor = new Panel(mainPanel)
		plantinesPanelContenedor.setLayout(new ColumnLayout(1))

		val plantasPanel = new Panel(plantinesPanelContenedor)
		plantasPanel.setLayout(new ColumnLayout(1))
		new Label(plantasPanel).setText("Plantas")
		new Label(plantasPanel).setText("Elige el plantin y la posicion")

		val actionsPlantinesContenedor = new Panel(mainPanel)
		actionsPlantinesContenedor.setLayout(new ColumnLayout(1))
		val plantinesPanel = new Panel(actionsPlantinesContenedor)
		plantinesPanel.setLayout(new ColumnLayout(5))

		new Selector(plantinesPanel).allowNull(false) => [
			width = 100
			bindItemsToProperty("jardinZen.plantas")
			bindValueToProperty("plantinSeleccionado")
		]

		new Label(plantinesPanel).setText("Tipo de planta:")
		new Label(plantinesPanel).setWidth(90).bindValueToProperty("plantinSeleccionado.tipo")

		new Label(plantinesPanel).setText("Columna")
		new TextBox(plantinesPanel) => [
			withFilter[event|StringUtils.isNumeric(event.potentialTextResult)]
			bindValueToProperty("columnaAPlantar")	
		]

		new Button(plantinesPanel).setCaption("Plantar") => [
			onClick[| modelObject.plantar ]
			bindEnabled(new NotNullObservable("plantinSeleccionado"))
			disableOnError
		]

		new Button(plantinesPanel).setCaption("Mejorar") => [
			onClick[|verMejorarWindow]
			bindEnabled(new NotNullObservable("plantinSeleccionado"))
			disableOnError			
		]
	}

	def addButtons(Panel mainPanel) {
		val buttonsPanel = new Panel(mainPanel)
		buttonsPanel.setLayout(new ColumnLayout(7))
		new Label(buttonsPanel).setText("Zombie:")
		new Label(buttonsPanel).setWidth(90).bindValueToProperty("zombieSeleccionado")
		this.addActions(buttonsPanel)
		new Label(buttonsPanel).setText("Recursos: ")
		new Label(buttonsPanel).setWidth(90).bindValueToProperty("jugador.recursos")
		new Label(buttonsPanel).setText("Jardin")
	}

	def addPanelPlantasyZombies(Panel mainPanel) {
		//Planel de plantas
		val panelDePlantas = new Panel(mainPanel).setWidth(300)
		panelDePlantas.setLayout(new ColumnLayout(2))
		val panelGrillaPlantas = new Panel(panelDePlantas)
		this.createResultsGrid(panelGrillaPlantas)

		//Panel ZOMBIE
		val panelDeZombie = new Panel(panelDePlantas)
		panelDeZombie.setLayout(new ColumnLayout(2))
		new Label(panelDeZombie).setText("Zombies")
		new Label(panelDeZombie).setText("Elige el zombie y la fila")

		new Label(panelDeZombie).setText("Zombie:")
		new Selector(panelDeZombie).allowNull(false) => [
			width = 150
			bindItemsToProperty("zombies")
			bindValueToProperty("zombieSeleccionado")			
		]

		new Button(panelDeZombie).setAsDefault.setCaption("Atacar") => [
			onClick[|atacar]
			bindEnabled(new NotNullObservable("zombieSeleccionado"))
			disableOnError			
		]
	}

	def atacar() {
		if (!finalizoElJuego) {
			modelObject.atacar
			modelObject.actualizarListaZombies
			modelObject.actualizarListaPlantas
			finalizoElJuego
		}
	}

	def verMejorarWindow() {
		this.openDialog(new MejoraWindow(this, modelObject))
	}

	def verJardinZen() {
		this.openDialog(new JardinZenWindow(this, modelObject))
	}

	def verAlmanaqueZombie() {
		this.openDialog(new AlmanaqueZombieWindow(this, modelObject))
	}

	def reiniciarJuego() {
		val reiniciarWindow = new ConfirmacionWindow(this, modelObject)
		reiniciarWindow.mensaje = "¿Estas seguro que deseas reiniciar el juego?"
		reiniciarWindow.onAccept[|modelObject.inicializarElemntosDeJuego]
		reiniciarWindow.onAccept[|modelObject.actualizarListaPlantas]
		this.openDialog(reiniciarWindow)
	}

	def openDialog(Dialog<?> dialog) {
		dialog.open
	}

	def protected createResultsGrid(Panel mainPanel) {
		this.describeResultsGrid(new Table<Fila>(mainPanel, typeof(Fila)) => [
			height = 375
			width = 500
			bindItemsToProperty("jardinDeJuego.filas")
			bindValueToProperty("filaSeleccionada")
		])
	}

	def describeResultsGrid(Table<Fila> table) {
		new Column<Fila>(table).setTitle("Terreno").setFixedSize(75).bindContentsToProperty("tipo")

		val cantidadDeColumnas = modelObject.jardinDeJuego.numeroDeCasillerosPorFila
		for (Integer i : 0 .. cantidadDeColumnas - 1) {
			new Column<Fila>(table).setTitle((i + 1).toString).setWeight(50).
				bindContentsToTransformer(new TransformerDeFila(i))
		}
	}

	def finalizoElJuego() {
		val findDelJuegoWindow = new ConfirmacionWindow(this, modelObject)
		findDelJuegoWindow.onAccept[|modelObject.inicializarElemntosDeJuego]
		findDelJuegoWindow.onAccept[|modelObject.actualizarListaPlantas]

		var fin = false
		if (modelObject.ganoElJuego) {
			findDelJuegoWindow.mensaje = "Felicitaciones!!! Has ganado el juego. ¿Jugar de nuevo?"
			fin = true
			this.openDialog(findDelJuegoWindow)
		} else if (modelObject.perdioElJuego) {
			findDelJuegoWindow.mensaje = "Has perdido. ¿Jugar de nuevo?"
			fin = true
			this.openDialog(findDelJuegoWindow)
		}
		return fin
	}

}
