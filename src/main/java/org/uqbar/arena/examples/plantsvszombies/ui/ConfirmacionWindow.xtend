package org.uqbar.arena.examples.plantsvszombies.ui

import org.uqbar.arena.examples.plantsvszombies.application.model.PlantsVsZombiesModel
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.windows.ErrorsPanel
import org.uqbar.arena.windows.WindowOwner

class ConfirmacionWindow extends Dialog<PlantsVsZombiesModel> {

	@Property String titulo = "Alerta"
	@Property String mensaje = "¿Estas seguro que deseas tomar esta accion?"
	@Property String aceptar = "Si"
	@Property String cancelar = "No"

	new(WindowOwner owner, PlantsVsZombiesModel model) {
		super(owner, model)
	}

	override protected createFormPanel(Panel mainPanel) {
		setTitle(titulo)
	
		mainPanel.setLayout(new ColumnLayout(1))
		new Label(mainPanel).setText(mensaje)

		var buttonsPanel = new Panel(mainPanel)
		buttonsPanel.setLayout(new ColumnLayout(3))

		new Label(buttonsPanel).setWidth(65) //Label utilizado para desplazar los botones hacia el centro de la pantalla
		new Button(buttonsPanel).setAsDefault.setCaption(cancelar).onClick[|this.cancel]
		new Button(buttonsPanel).setCaption(aceptar).onClick[|this.accept]
	}

	override protected ErrorsPanel createErrorsPanel(Panel mainPanel) {
	}

}
