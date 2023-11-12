import QtQuick 2.15
import QtQuick.Controls 2.5

ApplicationWindow {
    visible: true
    width: 400
    height: 200

    // Importar el objeto C++
    Connections {
        target: backend
        onMessageChanged: {
            console.log("Received message from C++:", backend.message);
        }
    }

    Rectangle {
        anchors.fill: parent

        TextField {
            id: textField
            anchors.centerIn: parent
            width: parent.width - 20
            placeholderText: "Type a message"
        }

        Button {
            text: "Send to C++"
            anchors.top: textField.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: {
                backend.message = textField.text
            }
        }
    }
}
