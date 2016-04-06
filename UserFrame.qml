import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: frame
    signal selected(var userName)
    signal needClose()

    function currentIconPath() {
        return usersList.currentItem.iconPath
    }

    function currentUserName() {
        return usersList.currentItem.userName
    }

    function isMultipleUsers() {
        return usersList.count > 1
    }

    ListView {
        id: usersList
        anchors.centerIn: parent
        width: childrenRect.width
        height: 80
        model: userModel
        orientation: ListView.Horizontal
        delegate: Item {
            property string iconPath: icon
            property string userName: nameText.text

            width: 150
            height: 150

            UserAvatar {
                id: iconButton
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                width: 100
                height: 100
                source: icon
                onClicked: {
                    selected(name)
                    usersList.currentIndex = index
                    selected(name)
                }
            }

            Text {
                id: nameText
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
