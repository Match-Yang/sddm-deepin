import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: frame
    signal selected(var index)
    signal needClose()

    property var sessionTypeList: ["deepin", "enlightenment", "fluxbox", "gnome", "kde", "lxde", "ubuntu"]
    function getIconName(sessionName) {
        for (var item in sessionTypeList) {
            var str = sessionTypeList[item]
            var index = sessionName.toLowerCase().indexOf(str)
            if (index >= 0) {
                return str
            }
        }

        return "unknow"
    }

    function getCurrentSessionIconPath() {
        return sessionList.currentItem.iconPath
    }

    function isMultipleSessions() {
        return sessionList.count > 1
    }

    ListView {
        id: sessionList
        anchors.centerIn: parent
        width: childrenRect.width
        height: 80
        model: sessionModel
        currentIndex: sessionModel.lastIndex
        orientation: ListView.Horizontal
        delegate: Item {
            property string iconPath: iconButton.normalImg

            width: 150
            height: 120

            ImageButton {
                id: iconButton
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                property var prefix: ("icons/%1_indicator_").arg(getIconName(name));
                normalImg: ("%1normal.png").arg(prefix)
                hoverImg: ("%1hover.png").arg(prefix)
                pressImg: ("%1press.png").arg(prefix)
                onClicked: {
                    selected(index)
                    sessionList.currentIndex = index
                }
            }

            Text {
                width: parent.width
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                text: name
                font.pointSize: 15
                color: "white"
                wrapMode: Text.WordWrap
            }
        }
    }

    MouseArea {
        z: -1
        anchors.fill: parent
        onClicked: needClose()
    }
}
