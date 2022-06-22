using Test
using QML
using Qt5QuickControls_jll
using Qt5QuickControls2_jll
using Observables

# Load file main.qml
loadqml("main.qml")

# Run the app
exec()