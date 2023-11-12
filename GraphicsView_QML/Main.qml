import QtQuick
import QtQuick.Window

Window {
    width: 400
    height: 300
    visible: true
    title: "Ejemplo de Graphics View"

    // Ellipse
    Rectangle {
        width: 100
        height: 100
        x: 50
        y: 50
        radius: 100
        border.color: "black"
    }

    Rectangle {
        width: 100
        height: 100
        x: 200
        y: 50
        border.color: "black"
    }

    Text {
        x: 50
        y: 200
        text: "Hola, Graphics View!"
    }
}
