import QtQuick
import QtQuick.Window
import QtQuick.Controls

import "./qml/Widgets"

Window {
    id: win
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    // property var lista: ["Primero", "Segundo", "Tercero"]
    property var lista: [
        {
            text: "Primero",
            textcolor: "red",
            bgColor: "black"
        },
        {
            text: "Segundo",
            textcolor: "blue",
            bgColor: "gray"
        },
        {
            text: "Tercero",
            textcolor: "white",
            bgColor: "pink"
        }
    ]

    Component.onCompleted: {
        delay.restart()
    }

    Timer {
        id: delay
        interval: 3000
        repeat: true
        onTriggered: {
            win.title = "Hola Mundo"
        }
    }


    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            orientation: Gradient.Horizontal
            GradientStop { position: 0; color: "red" }
            GradientStop { position: 0.33 * (_slider.value / 100); color: "yellow" }
            GradientStop { position: 1.0 * (_slider.value / 100); color: "green" }
            GradientStop { position: 1.0 * (_slider.value / 100) + 0.0001; color: "transparent" }
        }
    }

    Item {
        width: 320
        height: 240
        anchors.centerIn: parent

        Rectangle {
            anchors.fill: parent
            anchors.centerIn: parent
            color: "transparent"
            border.color: "green"
        }


        Row {
        Repeater {
            model: lista
                Btn {
                    // Array/List
                    //_text: modelData
                    //_text: model[index]

                    // Object
                    _text: modelData.text

                    button_id: index



                    // practica
                    /*
                    cambiar el background con los colores del objeto
                    */
                }
            }
        }
    }

    Slider {
        id: _slider
        width: 240
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 180
        from: 1
        value: 100
        to: 100
    }
}
