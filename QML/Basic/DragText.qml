import QtQuick 2.0
import Qt.labs.settings 1.0

Item {
    id: root
//    property Component rootComp: root
    property alias textEdit: textEdit
    property alias text: textEdit.text
    property alias textVerticalAlignment: textEdit.verticalAlignment
    property alias textHorisontalAlignment: textEdit.horizontalAlignment
    property string settinsCategory: "null_category"
    property bool isMoveMode: true
    property bool borderEnable: true
    property var regExpValid:/^\S+$/;

    x: 0;
    y: 0;
    width: 300;
    height: 30;

    Settings {
        category: settinsCategory
        property alias textX: textEdit.x
        property alias textY: textEdit.y
        property alias textWidth: root.width
        property alias textHeihgt: root.height
    }

//! [0]
        TextEdit {
            id: textEdit
//            text: "sdfsf"
            font.pointSize: 12
            width: root.width
            height: root.height

            Rectangle {
                id: tile
                visible: borderEnable

                    width: Math.max(textEdit.contentWidth, textEdit.width)
                    height: textEdit.contentHeight

//anchors.fill: parent
//            anchors.verticalCenter: parent.verticalCenter
        //            anchors.horizontalCenter: parent.horizontalCenter

                border.color: (borderEnable & !regExpValid.test(textEdit.text))?"red":"blue";
                color: "transparent"
            }

            MouseArea {
                id: mouseArea
                enabled: isMoveMode
                anchors.fill: parent


                drag.target: textEdit

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

//            Keys.onPressed: {
//                if(event.key === Qt.Key_Left)
//                    textEdit.width++;
//                if(event.key === Qt.Key_Right)
//                    textEdit.width--
//                if(event.key === Qt.Key_Up)
//                    textEdit.height--;
//                if(event.key === Qt.Key_Down)
//                    textEdit.height++;
//            }

        }
//! [1]
//        states: State {
//            when: mouseArea.drag.active
//            ParentChange { target: tile; parent: rootComp }
//            AnchorChanges { target: tile; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
//        }

}
