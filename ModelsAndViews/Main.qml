import QtQuick 2.15
import QtQuick.Controls 2.15
import QtWebView 1.0


ApplicationWindow {
    id: mainItem
    width: 500
    height: 700
    minimumWidth: width
    minimumHeight: height
    maximumWidth: width
    maximumHeight: height
    title: "PokeAPI Viewer"
    color: "lightgray"
    visible: true

    property bool loading
    property var dialog

    ListModel {
        id: pokemonData
    }

    function listProperty(item) {
        for (var p in item) console.log(p + ": " + item[p])
    }

    //onDialogChanged: listProperty(dialog)

    Connections {
        target: _textInput
        onTextChanged: if (_textInput.text > 1017) _textInput.text = 1017
    }

    Dialog_Template {
        id: errorId
        title: "Error - Id"
        textToDisplay: "El id no puede estar vacio o ser 0"
        width: 200
        height: 150
        anchors.centerIn: parent
    }

    Dialog_Template {
        id: error404
        title: "Error 404: Not Found"
        textToDisplay: "No se encontró el id"
        width: 200
        height: 150
        anchors.centerIn: parent
    }

    Item {
        width: parent.width
        height: 30
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 15

        Row {
            anchors.centerIn: parent
            spacing: 5
            enabled: !loading

            TextField {
                id: _textInput
                width: 100
                placeholderText: "Ingresa un id"
                validator: IntValidator {
                    bottom: 0
                    top: 1000
                }
                inputMethodHints: Qt.ImhDigitsOnly
            }

            Button {
                text: "Obtener Pokemon"
                onClicked: if (_textInput.text < 1 || _textInput.text === "") {
                               errorId.show()
                           } else {
                               _webview.getPokemon(_textInput.text)
                               _textInput.text = ""
                           }
            }

            Button {
                text: "Abrir Ventana de Diálogo"
                onClicked: {
                    _webview.getPokemon(_textInput.text, true)
                    _textInput.text = ""
                }
            }
        }
    }

    WebView {
        id: _webview
        anchors.fill: parent
        url: "about:blank"

        function getPokemon(id, openInNewWindow=false) {
            //max 1017
            loading = true

            var apiUrl = "https://pokeapi.co/api/v2/pokemon/" + id

            var xhr = new XMLHttpRequest()
            xhr.open("GET", apiUrl, true)

            xhr.onreadystatechange = function() {
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    if (xhr.status === 404) {
                        error404.show()
                    } else if (xhr.status === 200) {
                        var response = JSON.parse(xhr.responseText)
                        pokemonData.append({
                                               name: response.name,
                                               altura: response.height,
                                               peso: response.weight,
                                               image: response.sprites.front_default
                                           })
                    }
                    loading = false

                    if (openInNewWindow) {
                        var dialogWindow = Qt.createComponent("./DialogWindow.qml")
                        if (dialogWindow.status === Component.Ready) {
                            dialog = dialogWindow.createObject(mainItem)
                            dialog.show()
                            dialog.data = pokemonData
                        }
                    }
                }
            }

            xhr.send()
        }
    }

    PokeDetail {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 22
        pokemon: pokemonData
    }
}
