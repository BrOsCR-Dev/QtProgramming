import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQml.XmlListModel

ApplicationWindow {
    visible: true
    width: 400
    height: 400
    title: "Ejemplo de lectura de XML en QML"

    XmlListModel {
        id: xmlModel
        source: "https://www.qt.io/blog/rss.xml"
        query: "/rss/channel/item"

        XmlListModelRole { name: "titulo"; elementName: "title" }
        XmlListModelRole { name: "fecha"; elementName: "pubDate" }
        XmlListModelRole { name: "autor"; elementName: "author" }
        XmlListModelRole { name: "link"; elementName: "link" }
    }

    ListView {
        width: parent.width
        height: parent.height

        model: xmlModel

        delegate: Item {
            width: parent.width
            height: 80

            Rectangle {
                width: parent.width
                height: 80
                color: index % 2 === 0 ? "lightgray" : "white"

                Text {
                     text: "<html><style type=\"text/css\"></style><a href=\"" + model.link +"\">" + model.titulo + "</a></html>"
                     onLinkActivated: Qt.openUrlExternally(link)
                     MouseArea {
                         id: mouseArea
                         anchors.fill: parent
                         acceptedButtons: Qt.NoButton // Don't eat the mouse clicks
                         cursorShape: Qt.PointingHandCursor
                     }
                 }

                Text {
                    anchors.centerIn: parent
                    text: "Autor: " + model.autor + "\n" + model.fecha
                }
            }
        }
    }
}
