import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: dialogTemplate
    width: 100
    height: 100
    property alias title: dialog.title
    property alias standardButtons: dialog.standardButtons
    property string textToDisplay: ""
    signal show()

    onShow: dialog.open()

    Dialog {
            id: dialog
            width: dialogTemplate.width
            height: dialogTemplate.height

            title: "Titulo Generico"
            standardButtons: Dialog.Ok

            contentItem: Item {
                width: parent.width
                height: parent.height
                Text {
                    text: textToDisplay
                    anchors.centerIn: parent
                }
            }

            onAccepted: {
                console.log("Botón Aceptar presionado.")
            }

            onRejected: {
                console.log("Botón Cancelar presionado.")
            }
        }
}
