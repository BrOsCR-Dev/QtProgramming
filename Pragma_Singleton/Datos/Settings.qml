pragma Singleton

import QtQuick

QtObject {
    property string titulo: "Hola mundo desde Pragma Singleton"
    readonly property color colorTest: "azure"
    readonly property string someWords: "Rectangle color and these words are from Base/MyConstants.qml"
}
