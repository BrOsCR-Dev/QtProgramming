import QtQuick
import QtQuick.Controls 2.5

Item {
    width: 75
    height: 25

    property alias button_instance: _button
    property alias rectangleBG: _rectangleBG.color
    property string _text: "Text"
    property int button_id

    Button {
        id: _button
        text: _text
        anchors.fill: parent

        background: Rectangle {
            id: _rectangleBG
            implicitWidth: parent.width
            implicitHeight: parent.height
            opacity: enabled ? 1 : 0.3
            color: "red"
        }

        onClicked: {
            console.log(`Botón ${button_id} personalizado fue clickeado`)
        }
    }
}
