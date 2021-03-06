import QtQuick 2.0
import Qt.labs.settings 1.0

Item {
    id: root
//    property Component rootComp: root
    property alias textInput: textInput
    property alias text: textInput.text
    property alias font: textInput.font
    property alias textVerticalAlignment: textInput.verticalAlignment
    property alias textHorisontalAlignment: textInput.horizontalAlignment
    property string settinsCategory: "null_category"
    property int moveMode: 0
    property bool borderEnable: true
    property var regExpString:/^\S+$/;
    property bool regExpValid: regExpString.test(textInput.text)
    property int pixelDefaultSize: 14
//    property Rectangle rect: rect()

    x: 0;
    y: 0;
    width: 300;
    height: 30;

    Settings {
        category: settinsCategory
        property alias textX: textInput.x
        property alias textY: textInput.y
//        property alias textFontPixelSize: textInput.font.pixelSize
        property alias textWidth: root.width
        property alias textHeihgt: root.height
    }

    FontLoader { id: localFont; source: "qrc:/Font/Vharial.ttf" }

//! [0]
        TextInput {
            id: textInput
//            text: "sdfsf"
            width: root.width
            height: root.height
            wrapMode: Text.WordWrap
            renderType: Text.NativeRendering
            font { family: localFont.name; pixelSize: root.pixelDefaultSize; capitalization: Font.MixedCase; bold: false}

            Rectangle {
                id: tile
                visible: borderEnable

                    width: Math.max(textInput.contentWidth, textInput.width)
                    height: root.height

//anchors.fill: parent
//            anchors.verticalCenter: parent.verticalCenter
        //            anchors.horizontalCenter: parent.horizontalCenter

                border.color: !regExpValid ? "red" : "blue";
                color: "transparent"
            }


            MouseArea {
                id: mouseArea
                enabled: moveMode
                anchors.fill: parent


                drag.target: textInput

                onWheel:
                {
                    if(moveMode === 1)
                    {
                        if (wheel.angleDelta.y > 0)
                        {
                            root.width++;
                        }
                        else
                        {
                            root.width--;
                        }
                    }
                    if(moveMode === 2)
                    {
                        if (wheel.angleDelta.y > 0)
                        {
                            root.height++;
                        }
                        else
                        {
                            root.height--;
                        }
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
