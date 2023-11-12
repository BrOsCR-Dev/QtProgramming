import QtQuick
import QtQuick.Controls 2.5

Item {
    width: 100
    height: 50

    property string _text: "Btn"

    Button {
        text: _text
        onClicked: console.log("Clicked")
    }

}
