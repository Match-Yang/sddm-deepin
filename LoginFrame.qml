import QtQuick 2.0
import QtGraphicalEffects 1.0
import SddmComponents 2.0

Item {
    id: frame
    property int sessionIndex: sessionModel.lastIndex
    property string userName: userModel.lastUser
    property bool isProcessing: glowAnimation.running

    function captureFocus() {
        passwdInput.focus = true
    }

    Connections {
        target: sddm
        onLoginSucceeded: {
//            glowAnimation.running = false
        }
        onLoginFailed: {
            passwdInput.echoMode = TextInput.Normal
            passwdInput.text = textConstants.loginFailed
            passwdInput.focus = false
            passwdInput.color = "#e7b222"
            glowAnimation.running = false
        }
    }

    Item {
        id: centerArea
        anchors.centerIn: parent
        width: parent.width
        height: parent.height / 3

        Item {
            id: loginItem
            anchors.fill: parent

            UserAvatar {
                id: userIconRec
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }
                width: 130
                height: 130
                source: userFrame.currentIconPath()
            }

            Glow {
                id: avatarGlow
                anchors.fill: userIconRec
                radius: 0
                samples: 17
                color: "#99ffffff"
                source: userIconRec

                SequentialAnimation on radius {
                    id: glowAnimation
                    running: false
                    alwaysRunToEnd: true
                    loops: Animation.Infinite
                    PropertyAnimation { to: 20 ; duration: 1000}
                    PropertyAnimation { to: 0 ; duration: 1000}
                }
            }

            Text {
                id: userNameText
                anchors {
                    top: userIconRec.bottom
                    topMargin: 10
                    horizontalCenter: parent.horizontalCenter
                }

                text: userName
                color: textColor
                font.pointSize: 15
            }

            Rectangle {
                id: passwdInputRec
                visible: ! isProcessing
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
                    onFocusChanged: {
                        if (focus) {
                            color = textColor
                            echoMode = TextInput.Password
                            text = ""
                        }
                    }
                    onAccepted: {
                        glowAnimation.running = true
                        sddm.login(userNameText.text, passwdInput.text, sessionIndex)
                    }

                    KeyNavigation.backtab: userButton; KeyNavigation.tab: shutdownButton
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
                        glowAnimation.running = true
                        sddm.login(userNameText.text, passwdInput.text, sessionIndex)
                    }
                }
            }
        }
    }
}
