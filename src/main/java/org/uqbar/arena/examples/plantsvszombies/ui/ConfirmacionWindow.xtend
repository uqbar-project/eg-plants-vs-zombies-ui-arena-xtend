package org.uqbar.arena.examples.plantsvszombies.ui

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.examples.plantsvszombies.application.model.PlantsVsZombiesModel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.windows.WindowOwner

@Accessors
class ConfirmacionWindow extends Dialog<PlantsVsZombiesModel> {

	String titulo = "Alerta"
	String mensaje = "¿Estas seguro que deseas tomar esta accion?"
	String aceptar = "Si"
	String cancelar = "No"

	new(WindowOwner owner, PlantsVsZombiesModel model) {
		super(owner, model)
	}

	override protected createFormPanel(Panel mainPanel) {
		setTitle(titulo)
	
		mainPanel.layout = new ColumnLayout(1)
		new Label(mainPanel).text = mensaje

		var buttonsPanel = new Panel(mainPanel)
		buttonsPanel.layout = new ColumnLayout(3)

		new Label(buttonsPanel).width = 65 //Label utilizado para desplazar los botones hacia el centro de la pantalla
		new Button(buttonsPanel) => [
			setAsDefault
			caption = cancelar
			onClick[|this.cancel]
		]
		new Button(buttonsPanel) => [
			caption = aceptar
			onClick[|this.accept]
		]
	}

	override protected ErrorsPanel createErrorsPanel(Panel mainPanel) {
	}

}
