import QtQuick
import QtQuick.Controls
import QtQuick.Window
import Backend 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 320
    height: 240
    title: qsTr("ImageCompressor")
    color: "azure"

    maximumHeight: height
    maximumWidth: width
    minimumHeight: height
    minimumWidth: width

    Backend { id: backend
        onGeneratingChanged: if (!backend.generating) root.color = "azure"
    }

    DropArea {
        id: dropArea
        anchors.fill: parent
        enabled: !backend.generating

        onEntered: {
            root.color = "steelblue"
            drag.accept(Qt.LinkAction)
        }

        onDropped: {
            root.color = "darkslategray"
            let cleanUrls = []
            drop.urls.forEach(url => cleanUrls.push(decodeURIComponent(url.toString().replace(/^(file:\/{3})/,""))))
            if (!cleanUrls.filter(url => url.includes(" ")).length > 0) {
                backend.compress(cleanUrls)
            }
        }

        onExited: root.color = "azure"
    }

    BusyIndicator {
        id: loadingIndicator
        width: 80
        height: 80
        anchors.centerIn: parent
        running: backend.generating
    }
}
