import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.3

import Qt.labs.platform 1.0

RowLayout {
    id: root

    property string pathToImage: ""

    TextField {
        id: textField

        Layout.fillWidth: true
        Layout.fillHeight: true
        selectByMouse: true

        text: fileDialog.file
        onTextChanged: {
            fileDialog.file = text;
        }

        placeholderText: "Enter image path..."
    }

    Button {
        id: openButton

        Layout.fillHeight: true

        text: "Open"

        onClicked: {
            fileDialog.open();
        }
    }

    Button {
        id: load

        Layout.fillHeight: true

        text: "Load"

        onClicked: {
            root.pathToImage = textField.text;
        }
    }

    FileDialog {
        id: fileDialog

        fileMode: FileDialog.OpenFile
        nameFilters: ["Image files (*.png *.jpg *jpeg)"]
    }
}
