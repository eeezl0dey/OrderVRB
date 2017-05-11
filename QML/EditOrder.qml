import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
import "Basic"

ColumnLayout {
    id: mainColumn
    property int margin: 12
    property  int rowId: 0
    property bool isNew: false

    property int pictureWidth: 300
    Settings {
        property alias editOrderPictureWidth: mainColumn.pictureWidth
    }

    GroupBox{
        id: groupOrder
        Layout.fillWidth: true
        Layout.fillHeight: true
        Rectangle{
            id: rectangleOrder
            Layout.fillWidth: true
            Layout.fillHeight: true
            border.color: "black"
            color: "transparent"
            property bool ctrlPressed: false
            Image {
                id: imageOrder
                sourceSize.width: mainColumn.pictureWidth
//                sourceSize.height: 100
                source: "qrc:/Image/vrbpay.jpg"
                Keys.onPressed: {
                    if(event.key === Qt.Key_Control)
                        rectangleOrder.ctrlPressed = true;
                }
                Keys.onReleased: {
                    if(event.key === Qt.Key_Control)
                        rectangleOrder.ctrlPressed = false;
                }
                MouseArea {
                    id: mouse
                    anchors.fill: parent
                    onEntered: {
                        parent.forceActiveFocus();
                    }

                    onWheel:
                    {
                        if (rectangleOrder.ctrlPressed){
                                    if (wheel.angleDelta.y > 0)
                                    {
                                        pictureWidth++;
                                    }
                                    else
                                    {
                                        pictureWidth--;
                                    }
                                    wheel.accepted=true
                                }
                    }
                }
            }

            DragText{
                id: dragTest
                isMoveMode: rectangleOrder.ctrlPressed
                height: 20
                width: 100
            }
        }
    }

    RowLayout{
        id: rowButton
//        Layout.fillWidth: true
       Layout.bottomMargin: 20
       Layout.topMargin: 10
       Layout.rightMargin: 50
       Layout.alignment: Qt.AlignRight
       spacing: 20



       Button {
            id: buttonOk
//            anchors.right: parent.right
//            anchors.rightMargin: 130
            text: qsTr("Пeчать")
            iconSource: "qrc:/Image/48/Printer 2.png"
            style: ProjectButtonStyle {
            }
            onClicked:  checkAccess();
        }

        Button {
            id: buttonCancel
//            anchors.right: parent.right
//            anchors.rightMargin: 30
            text: qsTr("Отмена")
            iconSource: "qrc:/Image/48/Symbol Stop 2.png"
            style: ProjectButtonStyle {
            }
            onClicked: cancelEdit();
        }
    }

//    onFocusChanged:
//        if(focus)textBankName.forceActiveFocus();
}

