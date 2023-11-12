import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: _pokeDetail
    width: 480
    height: 635

    property var pokemon

    readonly property int itemHeight: 90

    Component {
        id: pokeDelegate

        Item {
            width: _pokeDetail.width - 2
            height: itemHeight
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                width: parent.width
                height: parent.height - 1
                anchors.top: parent.top
                anchors.topMargin: 1
                color: index % 2 === 0 ? "#e7b788" : "#fae7d9"

                Text {
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Nombre: \n " + name
                    font.pixelSize: 16
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    text: if (altura >= 10) {
                            "Altura: " + (altura * 0.1).toFixed(2) + " metros \n" +
                            "Peso: " + (peso * 0.1).toFixed(1) + " kilos"
                          } else {
                            "Altura: " + altura + "0 centimetros \n" +
                            "Peso: " + (peso * 0.1).toFixed(1) + " kilos"
                          }
                    font.pixelSize: 16
                }

                Image {
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    source: image
                }
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        anchors.centerIn: parent
        color: "white"
        border.color: "black"
        clip: true

        Flickable {
            width: parent.width
            height: parent.height - 1

            contentWidth: _list.width
            contentHeight: _list.contentHeight

            ListView {
                id: _list
                width: _pokeDetail.width
                height: count * itemHeight
                model: pokemon
                delegate: pokeDelegate
                focus: true
            }
        }
    }
}
