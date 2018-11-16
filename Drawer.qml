import QtQuick 2.0

Rectangle {
    id: root

    property color strokeColor: "green"
    property int lineWidth: 3
    property int msIntervalPaint: 5

    property alias background: background

    signal beginLine(real x, real y)
    signal snapshot(real x, real y)

    function clear() {
        canvas.clear();
    }

    color: "transparent"
    border.color: "#D0D0D0"
    border.width: 2

    Image {
        id: background

        anchors.fill: parent
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent

        function clamp(num, min, max) {
          return num <= min ? min : num >= max ? max : num;
        }

        property real nX: clamp(mouseX / width, 0, 1)
        property real nY: clamp(mouseY / height, 0, 1)

        onPressed: {
            timer.start();
        }

        onReleased: {
            timer.stop();
        }
    }

    Canvas {
        id: canvas

        property var points: []

        function startFrom(x, y) {
            points = [];
            points.push([x, y]);
        }

        function followLine(x, y) {
            points.push([x, y]);
            canvas.requestPaint();
        }

        function clear() {
            points = [];

            var ctx = getContext("2d")
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            canvas.requestPaint();
        }

        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");

            ctx.strokeStyle = root.strokeColor;
            ctx.lineWidth = root.lineWidth;

            ctx.beginPath();
            for (var i = 1; i < points.length; i++) {
                var from = points[i - 1];
                var to = points[i];
                ctx.moveTo(from[0], from[1]);
                ctx.lineTo(to[0], to[1])
            }
            if (points.length > 1) {
                var tmp = [points[points.length - 1]];
                points = tmp;
            }

            ctx.stroke();
        }
    }

    Timer {
        id: timer

        interval: root.msIntervalPaint
        repeat: true

        onRunningChanged: {
            if (running) {
                root.beginLine(mouseArea.nX, mouseArea.nY);
                canvas.startFrom(mouseArea.mouseX, mouseArea.mouseY);
            }
        }

        onTriggered: {
            root.snapshot(mouseArea.nX, mouseArea.nY);
            canvas.followLine(mouseArea.mouseX, mouseArea.mouseY);
        }
    }
}
