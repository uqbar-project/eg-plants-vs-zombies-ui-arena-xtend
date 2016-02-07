package org.uqbar.arena.examples.plantsvszombies.ui

import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.examples.plantsvszombies.application.model.PlantsVsZombiesModel
import org.uqbar.arena.examples.plantsvszombies.jardin.Fila
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.SimpleWindow
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class JardinDeJuegoWindow extends SimpleWindow<PlantsVsZombiesModel> {

	new(WindowOwner parent) {
		super(parent, new PlantsVsZombiesModel)
		title = "Plantas vs Zombies"
		taskDescription = "Seleccione el zombie y la fila a atacar."
	}

	override def createMainTemplate(Panel mainPanel) {
		mainPanel.layout = new VerticalLayout
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
			items <=> "recompensaObserver.log"
			height = 70
			width = 150
		]
	}

	override protected addActions(Panel actionsPanel) {
		new Button(actionsPanel) => [
			caption = "Ir al jardin Zen"
			onClick[|this.verJardinZen]
		]
		new Button(actionsPanel) => [
			caption = "Reiniciar"
			onClick(|this.reiniciarJuego) 
		]
		new Button(actionsPanel) => [
			caption = "Almanaque"
			onClick[|this.verAlmanaqueZombie]	
		]
	}

	def addPlantinesPanel(Panel mainPanel) {
		//Panel de pantines
		val plantinesPanelContenedor = new Panel(mainPanel) => [
			layout = new ColumnLayout(1)
		]

		val plantasPanel = new Panel(plantinesPanelContenedor) => [
			layout = new ColumnLayout(1)
		]
		new Label(plantasPanel).text = "Plantas"
		new Label(plantasPanel).text = "Elige el plantin y la posicion"

		val actionsPlantinesContenedor = new Panel(mainPanel)
		actionsPlantinesContenedor.layout = new ColumnLayout(1)
		val plantinesPanel = new Panel(actionsPlantinesContenedor)
		plantinesPanel.layout = new ColumnLayout(5)

		new Selector(plantinesPanel).allowNull(false) => [
			width = 100
			items <=> "jardinZenJuego.plantas"
			value <=> "plantinSeleccionado"
		]

		new Label(plantinesPanel).text = "Tipo de planta:"
		new Label(plantinesPanel) => [
			width = 90
			value <=> "plantinSeleccionado.tipo"
		]

		new Label(plantinesPanel).text = "Columna"
		new NumericField(plantinesPanel) => [
			value <=> "columnaAPlantar"	
		]

		new Button(plantinesPanel) => [
			caption = "Plantar"
			onClick[| modelObject.plantar ]
			bindEnabled(new NotNullObservable("plantinSeleccionado"))
			disableOnError
		]

		new Button(plantinesPanel) => [
			caption = "Mejorar"
			onClick[|verMejorarWindow]
			bindEnabled(new NotNullObservable("plantinSeleccionado"))
			disableOnError			
		]
	}

	def addButtons(Panel mainPanel) {
		val buttonsPanel = new Panel(mainPanel)
		buttonsPanel.layout = new ColumnLayout(7)
		new Label(buttonsPanel).text = "Zombie:"
		new Label(buttonsPanel) => [
			width = 90
			value <=> "zombieSeleccionado"
		]
		this.addActions(buttonsPanel)
		new Label(buttonsPanel).text = "Recursos: "
		new Label(buttonsPanel) => [
			width = 90
			value <=> "jugadorActual.recursos"
		]
		new Label(buttonsPanel).text = "Jardin"
	}

	def addPanelPlantasyZombies(Panel mainPanel) {
		//Planel de plantas
		val panelDePlantas = new Panel(mainPanel).setWidth(300)
		panelDePlantas.layout = new ColumnLayout(2)
		val panelGrillaPlantas = new Panel(panelDePlantas)
		this.createResultsGrid(panelGrillaPlantas)

		//Panel ZOMBIE
		val panelDeZombie = new Panel(panelDePlantas)
		panelDeZombie.layout = new ColumnLayout(2)
		new Label(panelDeZombie).text = "Zombies"
		new Label(panelDeZombie).text = "Elige el zombie y la fila"

		new Label(panelDeZombie).text = "Zombie:"
		new Selector(panelDeZombie).allowNull(false) => [
			width = 150
			items <=> "zombies"
			value <=> "zombieSeleccionado"			
		]

		new Button(panelDeZombie) => [
			caption = 'Atacar'
			onClick [|atacar]
			bindEnabled(new NotNullObservable("zombieSeleccionado"))
			disableOnError			
			setAsDefault
		]
	}

	def atacar() {
		if (!finalizoElJuego) {
			modelObject => [
				atacar
				actualizarListaZombies
				actualizarListaPlantas
			]
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
		val reiniciarWindow = new ConfirmacionWindow(this, modelObject) => [
			mensaje = "¿Estas seguro que deseas reiniciar el juego?"
			onAccept[|modelObject.inicializarElementosDeJuego]
			onAccept[|modelObject.actualizarListaPlantas]
		]
		this.openDialog(reiniciarWindow)
	}

	def openDialog(Dialog<?> dialog) {
		dialog.open
	}

	def protected createResultsGrid(Panel mainPanel) {
		this.describeResultsGrid(new Table<Fila>(mainPanel, typeof(Fila)) => [
			height = 375
			width = 500
			items <=> "jardinDeJuego.filas"
			value <=> "filaSeleccionada"
		])
	}

	def describeResultsGrid(Table<Fila> table) {
		new Column<Fila>(table) => [
			title = "Terreno"
			fixedSize = 75
			bindContentsToProperty("tipo")
		]

		val cantidadDeColumnas = modelObject.jardinDeJuego.numeroDeCasillerosPorFila
		for (Integer i : 0 .. cantidadDeColumnas - 1) {
			new Column<Fila>(table) => [
				title = (i + 1).toString
				weight = 50
				bindContentsToProperty("casilleros").transformer = new TransformerDeFila(i)
			]
		}
	}

	def finalizoElJuego() {
		val findDelJuegoWindow = new ConfirmacionWindow(this, modelObject) => [
			onAccept[|modelObject.inicializarElementosDeJuego]
			onAccept[|modelObject.actualizarListaPlantas]
		]

		var fin = false
		if (modelObject.ganoElJuego) {
			fin = true
			popupFinDelJuego(findDelJuegoWindow, "Felicitaciones!!! Has ganado el juego. ¿Jugar de nuevo?")
		} else if (modelObject.perdioElJuego) {
			fin = true
			popupFinDelJuego(findDelJuegoWindow, "Has perdido. ¿Jugar de nuevo?")
		}
		fin
	}
	
	def popupFinDelJuego(ConfirmacionWindow findDelJuegoWindow, String mensajeFin) {
		findDelJuegoWindow.mensaje = mensajeFin
		this.openDialog(findDelJuegoWindow)
	}

}
