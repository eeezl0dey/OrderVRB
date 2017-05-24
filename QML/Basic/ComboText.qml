import QtQuick 2.0
import Qt.labs.settings 1.0
import QtQuick.Controls 2.0

Item {
    id: root
//    property Component rootComp: root
    property alias comboInput: comboInput
//    property alias text: comboInput.te
//    property alias textVerticalAlignment: textInput.verticalAlignment
//    property alias textHorisontalAlignment: textInput.horizontalAlignment
    property string settinsCategory: "null_category"
    property bool isMoveMode: true
    property bool borderEnable: true
//    property var regExpString:/^\S+$/;
//    property bool regExpValid: regExpString.test(comboInput.text)

    x: 0;
    y: 0;
    width: 300;
    height: 30;

    Settings {
        category: settinsCategory
        property alias textX: comboInput.x
        property alias textY: comboInput.y
        property alias textWidth: root.width
        property alias textHeihgt: root.height
    }

//! [0]
        ComboBox{
            id: comboInput
//            text: "sdfsf"
            font.pointSize: 12
            width: root.width
            height: root.height

            Rectangle {
                id: tile
                visible: borderEnable

                    width: comboInput.width
                    height: root.height

//anchors.fill: parent
//            anchors.verticalCenter: parent.verticalCenter
        //            anchors.horizontalCenter: parent.horizontalCenter

                border.color: "blue";
                color: "transparent"
            }

            MouseArea {
                id: mouseArea
                enabled: isMoveMode
                anchors.fill: parent


                drag.target: comboInput

                onWheel:
                {
                    if (wheel.angleDelta.y > 0)
                    {
                        root.width++;
                    }
                    else
                    {
                        root.width--;
                    }
                    wheel.accepted=true
                }

//                onReleased: parent = tile.Drag.target !== null ? tile.Drag.target : rootComp


            }
        }
}
