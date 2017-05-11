import QtQuick 2.0

Item {
    id: root
    property Component rootComp: root
    property alias text: textEdit.text
    property bool isMoveMode: true

    width: 300; height: 300

//! [0]
        TextEdit {
            id: textEdit
            text: "sdfsf"
            width: 200; height: 30


            Rectangle {
                id: tile

                    width: textEdit.width;
                    height: textEdit.height;

//anchors.fill: parent
//            anchors.verticalCenter: parent.verticalCenter
        //            anchors.horizontalCenter: parent.horizontalCenter

                border.color: "black"
                color: "transparent"
            }

            MouseArea {
                id: mouseArea
                enabled: isMoveMode
                anchors.fill: parent


                drag.target: textEdit

    //            onReleased: parent = tile.Drag.target !== null ? tile.Drag.target : rootComp

            }

            Keys.onPressed: {
                if(event.key === Qt.Key_Left)
                    textEdit.width++;
                if(event.key === Qt.Key_Right)
                    textEdit.width--
                if(event.key === Qt.Key_Up)
                    textEdit.height--;
                if(event.key === Qt.Key_Down)
                    textEdit.height++;
            }

        }
//! [1]
//        states: State {
//            when: mouseArea.drag.active
//            ParentChange { target: tile; parent: rootComp }
//            AnchorChanges { target: tile; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
//        }

}
