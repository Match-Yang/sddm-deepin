/***********************************************************************/

import QtQuick 2.0
import SddmComponents 2.0


Rectangle {
    id: root
    width: 640
    height: 480
    state: "stateLogin"

    readonly property int hMargin: 40
    readonly property int vMargin: 40
    readonly property color textColor: "#ffffff"

    TextConstants { id: textConstants }

    states: [
        State {
            name: "statePower"
            PropertyChanges { target: loginFrame; opacity: 0}
            PropertyChanges { target: powerFrame; opacity: 1}
            PropertyChanges { target: sessionFrame; opacity: 0}
        },
        State {
            name: "stateSession"
            PropertyChanges { target: loginFrame; opacity: 0}
            PropertyChanges { target: powerFrame; opacity: 0}
            PropertyChanges { target: sessionFrame; opacity: 1}
        },
        State {
            name: "stateLogin"
            PropertyChanges { target: loginFrame; opacity: 1}
            PropertyChanges { target: powerFrame; opacity: 0}
            PropertyChanges { target: sessionFrame; opacity: 0}
        }

    ]
    transitions: Transition {
        PropertyAnimation { duration: 500; properties: "opacity";  }
    }

    Repeater {
        model: screenModel
        Background {
            x: geometry.x; y: geometry.y; width: geometry.width; height:geometry.height
            source: config.background
            fillMode: Image.Tile
            onStatusChanged: {
                if (status == Image.Error && source != config.defaultBackground) {
                    source = config.defaultBackground
                }
            }
        }
    }

    PowerFrame {
        id: powerFrame
        enabled: root.state == "statePower"
        property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x; y: geometry.y; width: geometry.width; height: geometry.height
        opacity: 1
        onNeedClose: root.state = "stateLogin"
        onNeedShutdown: sddm.powerOff()
        onNeedRestart: sddm.reboot()
        onNeedSuspend: sddm.suspend()
    }

    SessionFrame {
        id: sessionFrame
        enabled: root.state == "stateSession"
        property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x; y: geometry.y; width: geometry.width; height: geometry.height
        onSelected: {
            console.log("Selected :", index)
            root.state = "stateLogin"
            loginFrame.m_sessionIndex = index
        }
        onNeedClose: root.state = "stateLogin"
    }

    LoginFrame {
        id: loginFrame
        enabled: root.state == "stateLogin"
        property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x; y: geometry.y; width: geometry.width; height: geometry.height
        color: "transparent"
        opacity: 0
        transformOrigin: Item.Top
    }

}
