import QtQuick 2.0
import QtGraphicalEffects 1.0

Rectangle {
    signal needClose()
    signal needShutdown()
    signal needRestart()
    signal needSuspend()

    Image {
        id: powerBackground
        anchors.fill: parent
        source: "background.jpg"
    }

    FastBlur {
        anchors.fill: powerBackground
        source: powerBackground
        radius: 20
    }

    Row {
        spacing: 70

        anchors.centerIn: parent

        Item {
            width: 100
            height: 150

            ImageButton {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                normalImg: "icons/powerframe/shutdown_normal.png"
                hoverImg: "icons/powerframe/shutdown_hover.png"
                pressImg: "icons/powerframe/shutdown_press.png"
                onClicked: needShutdown()
            }

            Text {
                text: qsTr("Shutdown")
                font.pointSize: 15
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
            }
        }

        Item {
            width: 100
            height: 150

            ImageButton {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                normalImg: "icons/powerframe/restart_normal.png"
                hoverImg: "icons/powerframe/restart_hover.png"
                pressImg: "icons/powerframe/restart_press.png"
                onClicked: needRestart()
            }

            Text {
                text: qsTr("Reboot")
                font.pointSize: 15
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
            }
        }

        Item {
            width: 100
            height: 150

            ImageButton {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                normalImg: "icons/powerframe/suspend_normal.png"
                hoverImg: "icons/powerframe/suspend_hover.png"
                pressImg: "icons/powerframe/suspend_press.png"
                onClicked: needSuspend()
            }

            Text {
                text: qsTr("Suspend")
                font.pointSize: 15
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
            }
        }
    }

    MouseArea {
        z: -1
        anchors.fill: parent
        onClicked: needClose()
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Escape) {
            needClose()
        }
    }
}
