import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Window 2.2

import BackendImpls 1.0


Window {
    id: root

    visible: true
    minimumWidth: 900
    minimumHeight: 640
    color: "#F0F0F0"

    title: qsTr("Route Recorder")

    RouteWriter {
        id: routeWriter

        folder: tools.folderName
    }

    ColumnLayout {
        anchors.fill: parent

        BackgroundImageInput {
            id: backgroundImageInput

            Layout.fillWidth: true
            Layout.maximumHeight: 30
            Layout.margins: 5
        }

        RowLayout {
            Layout.fillHeight: true
            Layout.fillWidth: true

            Painter {
                id: painter

                Layout.fillWidth: true
                Layout.fillHeight: true

                background.source: backgroundImageInput.pathToImage
                msIntervalPaint: tools.msIntervalPaint

                onBeginLine: {
                    routeWriter.createRoute(x, y);
                }

                onSnapshot: {
                    routeWriter.addPointToLastRoute(x, y);
                }
            }

            Tools {
                id: tools

                Layout.preferredWidth: 300
                Layout.fillHeight: true

                painterWidth: painter.width
                painterHeight: painter.height

                routeCounts: routeWriter.routeCounts

                onWriteToFiles: {
                    routeWriter.writeToFiles();
                }

                onClearRoutes: {
                    routeWriter.clear();
                }

                onClearTriggered: {
                    painter.clear();
                }
            }
        }
    }
}
