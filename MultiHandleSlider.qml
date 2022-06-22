import QtQuick 2.0
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4

Item {
    id: root
   
    // public
    property double maximum: 10
    property double value:    0
    property double minimum:  0
   
    signal clicked(double value);  //onClicked:{root.value = value;  print('onClicked', value)}
       
    // private
    width: 100;  height: 500 // default size
    opacity: enabled  &&  !mouseArea.pressed? 1: 0.3 // disabled/pressed state
   
    // Bounding Box for testing
    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border.color: "red"
        border.width: 3
    }

    Repeater { // left and right trays (so tray doesn't shine through pill in disabled state)
        model: 2
       
        delegate: Rectangle {
            y: !index ? 0 : pill.y + pill.height - radius
            width: 0.1 * root.width
            height: !index? pill.y + radius: root.height - y
            radius: 0.5 * width
            color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
   
    Rectangle { // pill
        id: pill
       
        y: (value - minimum) / (maximum - minimum) * (root.height - pill.height) // pixels from value
        height: parent.width;  width: height
        border.width: 0.05 * root.width
        radius: 0.5 * width
    }
   
    MouseArea {
        id: mouseArea

        anchors.fill: parent
   
        drag {
            target:   pill
            axis:     Drag.YAxis
            maximumY: root.height - pill.height
            minimumY: 0
        }
       
        onPositionChanged:  if(drag.active) setPixels(pill.y + 0.5 * pill.height) // drag pill
        onClicked:                          setPixels(mouse.y) // tap tray
    }
   
    function setPixels(pixels) {
        var value = (maximum - minimum) / (root.height - pill.height) * (pixels - pill.height / 2) + minimum // value from pixels
        clicked(Math.min(Math.max(minimum, value), maximum)) // emit
    }
}
