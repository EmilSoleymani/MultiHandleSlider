import QtQuick 2.0
import QtQuick.Window 2.12

Window {
    id: mainWindow
    width: 800
    height: 600
    visible: true
    title: qsTr("MultiHandleSlider: " + testSlider.backend)

    MultiHandleSlider {
        id: testSlider
        property double backend: 0
    
        maximum:  10
        value:    backend
        minimum: -10
        anchors.centerIn: parent
        onClicked: backend = value
    }
}

