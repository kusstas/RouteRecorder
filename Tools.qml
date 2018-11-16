import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.4

Rectangle {
    id: root

    color: "transparent"
    border.color: "#D0D0D0"
    border.width: 2

    property alias folderName: folderNameField.text
    property alias msIntervalPaint: msIntervalPaintSpinBox.value

    property var routeCounts: []
    property int painterWidth: 0
    property int painterHeight: 0

    signal clearTriggered
    signal writeToFiles
    signal clearRoutes

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 5

        spacing: 5

        Button {
            id: clearButton

            Layout.fillWidth: true

            text: "Clear"

            onClicked: {
                root.clearTriggered();
            }
        }

        SpinBox {
            id: msIntervalPaintSpinBox

            Layout.fillWidth: true
            editable: true

            from: 1
            to: 200
        }

        TextField {
            id: folderNameField

            Layout.fillWidth: true

            selectByMouse: true
            placeholderText: "Folder name"
        }

        TextField {
            id: infoRoutesField

            Layout.fillWidth: true

            readOnly: true
            text: "Count of routes: " + root.routeCounts.length
        }

        TextField {
            id: infoPainterField

            Layout.fillWidth: true

            readOnly: true
            text: "Size of painter: %1x%2".arg(root.painterWidth).arg(root.painterWidth)
        }

        ListView {
            id: listView

            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 5

            model: root.routeCounts
            spacing: 5
            clip: true

            delegate: Rectangle {
                width: parent.width
                height: 25

                border.color: "grey"
                border.width: 2

                Text {
                    anchors.fill: parent
                    anchors.margins: 5
                    verticalAlignment: Text.AlignVCenter
                    text: "Points in route #%1: %2".arg(index).arg(modelData)
                }
            }
        }

        Button {
            id: clearRoutesButton

            Layout.fillWidth: true

            text: "Clear routes"

            onClicked: {
                root.clearRoutes();
            }
        }

        Button {
            id: writeButton

            Layout.fillWidth: true

            text: "Write to files"

            onClicked: {
                root.writeToFiles();
            }
        }
    }
}
