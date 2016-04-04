import QtQuick 2.0
import SddmComponents 2.0

Rectangle {

    Image {
        id: powerBackground
        anchors.fill: parent
        source: "background.jpg"
    }

    Item {
        id: centerArea
        anchors.centerIn: parent
        width: parent.width
        height: parent.height / 3

        Item {
            id: loginItem
            anchors.fill: parent

            Rectangle {
                id: userIconRec
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }

                width: radius
                height: radius
                radius: 130
                border {
                    width: 3
                    color: "#ffffff"
                }
                color: "#999999"
                Image {
                    id: userIcon
                    source: ""
                    anchors.centerIn: parent
                    width: parent.width
                    height: parent.height
                    Component.onCompleted: {
                        source = getIconByName(userNameText.text)
                    }
                }
            }

            Text {
                id: userNameText
                anchors {
                    top: userIconRec.bottom
                    topMargin: 10
                    horizontalCenter: parent.horizontalCenter
                }

                text: userModel.lastUser
                color: textColor
                font.pointSize: 15
            }

            Rectangle {
                id: passwdInputRec
                anchors {
                    top: userNameText.bottom
                    topMargin: 10
                    horizontalCenter: parent.horizontalCenter
                }
                width: 300
                height: 35
                radius: 3
                color: "#55000000"

                TextInput {
                    id: passwdInput
                    anchors.fill: parent
                    anchors.leftMargin: 8
                    anchors.rightMargin: 8 + 36
                    clip: true
                    focus: true
                    color: textColor
                    font.pointSize: 15
                    selectByMouse: true
                    selectionColor: "#a8d6ec"
                    echoMode: TextInput.Password
                    verticalAlignment: TextInput.AlignVCenter

                    KeyNavigation.backtab: userButton; KeyNavigation.tab: shutdownButton
                    Keys.onPressed: {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.login(userNameText.text, passwdInput.text, 1/*session.index*/)
                            event.accepted = true
                        }
                    }
                }
                ImageButton {
                    id: loginButton
                    anchors {
                        right: parent.right
                        verticalCenter: parent.verticalCenter
                    }

                    // Fixme, This is vary strange
                    source: "icons/login_normal.png"
                    onClicked: {
                        sddm.login(userNameText.text, passwdInput.text, 1/*session.index*/)
                    }
                }
            }
        }
    }

    Item {
        id: timeArea

        anchors {
            bottom: parent.bottom
            left: parent.left
        }
        width: parent.width / 3
        height: parent.height / 5

        Text {
            id: timeText
            anchors {
                left: parent.left
                leftMargin: hMargin
                bottom: dateText.top
                bottomMargin: 5
            }

            font.pointSize: 50
            color: textColor

            function updateTime() {
                text = new Date().toLocaleString(Qt.locale("en_US"), "hh:mm")
            }
        }

        Text {
            id: dateText
            anchors {
                left: parent.left
                leftMargin: hMargin
                bottom: parent.bottom
                bottomMargin: vMargin
            }

            font.pointSize: 18
            color: textColor

            function updateDate() {
                text = new Date().toLocaleString(Qt.locale("en_US"), "yyyy-MM-dd dddd")
            }
        }

        Timer {
            interval: 1000
            repeat: true
            running: true
            onTriggered: {
                timeText.updateTime()
                dateText.updateDate()
            }
        }

        Component.onCompleted: {
            timeText.updateTime()
            dateText.updateDate()
        }
    }

    Item {
        id: powerArea
        anchors {
            bottom: parent.bottom
            right: parent.right
        }
        width: parent.width / 3
        height: parent.height / 5

        readonly property int itemSpacing: 20;

        ImageButton {
            id: userButton
            visible: userModel.count > 1
            anchors {
                right: shutdownButton.left
                rightMargin: powerArea.itemSpacing
                verticalCenter: parent.verticalCenter
            }

            source: "icons/switchframe/userswitch_normal.png"
            onClicked: {
                console.log("Switch User...")
            }
        }

        ImageButton {
            id: shutdownButton
            visible: sddm.canPowerOff
            anchors {
                right: parent.right
                rightMargin: hMargin + powerArea.itemSpacing
                verticalCenter: parent.verticalCenter
            }

            source: "icons/switchframe/powermenu.png"
            onClicked: {
                console.log("Show shutdown menu")
                root.state = "statePower"
            }
        }
    }
}
