package main

import (
	"fyne.io/fyne/v2"
	"fyne.io/fyne/v2/app"
	"fyne.io/fyne/v2/container"
	"fyne.io/fyne/v2/widget"
)

func main() {
	w := getWindow()

	tabs := container.NewAppTabs(
		container.NewTabItem("Main", widget.NewLabel("Main")),
		container.NewTabItem("Logs", widget.NewLabel("Logs")),
		container.NewTabItem("About", widget.NewLabel("About")),
	)

	tabs.SetTabLocation(container.TabLocationLeading)

	w.SetContent(tabs)
	w.ShowAndRun()
}

func getMainTab() fyne.CanvasObject {

}

func getWindow() fyne.Window {
	a := app.New()
	w := a.NewWindow("Recode 3000")

	w.Resize(fyne.Size{Width: 800, Height: 400})
	w.SetFixedSize(true)
	w.CenterOnScreen()

	return w
}
