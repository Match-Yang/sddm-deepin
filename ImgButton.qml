import QtQuick 2.0

Image {
    id: button
    property url normalImg: ""
    property url hoverImg: normalImg
    property url pressImg: normalImg
    source: normalImg

    signal clicked()

    onNormalImgChanged: button.source = normalImg

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: button.source = hoverImg
        onPressed: button.source = pressImg
        onExited: button.source = normalImg
        onReleased: button.source = normalImg
        onClicked: button.clicked()
    }
}
