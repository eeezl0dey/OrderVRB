import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import Qt.labs.settings 1.0
import "Basic"
import "qrc:/Script/digit2vn.js" as Digit2vn

ColumnLayout {
    id: mainColumn
    property int margin: 12
    property  int rowId: 0
    property bool isNew: false

//    property int pictureWidth: 30
    property int pictureX: 0
    property int pictureY: 0

    Settings {
        category: "EditOrderPicture"
        property alias editOrderPictureWidth: imageOrder.sourceSize.width
        property alias editOrderPictureX: mainColumn.pictureX
        property alias editOrderPictureY: mainColumn.pictureY
    }


    Rectangle{
       id: rectangleOrder
        Layout.fillWidth: true
        Layout.fillHeight: true
//        anchors.margins: 4
//        border.color: "black"
        color: "transparent"
        property bool ctrlPressed: false
        clip: true
        Image {
            id: imageOrder
            x: pictureX
            y: pictureY
            sourceSize.width: 700
            source: "qrc:/Image/vrbpay.png"
            Keys.onPressed: {
                if(event.key === Qt.Key_Control)
                    rectangleOrder.ctrlPressed = true;
            }
            Keys.onReleased: {
                if(event.key === Qt.Key_Control){
                    rectangleOrder.ctrlPressed = false;
                    pictureX = imageOrder.x;
                    pictureY = imageOrder.y;
                }
            }
            MouseArea {
                id: mouse
                anchors.fill: parent
                onEntered: {
                    parent.forceActiveFocus();
                }

                drag.target: {
                    if(rectangleOrder.ctrlPressed){
                        return imageOrder
                    }
                    else{
                        return null;
                    }
                }


                onWheel:
                {
                    if (rectangleOrder.ctrlPressed){
                                if (wheel.angleDelta.y > 0)
                                {
                                    imageOrder.sourceSize.width++;
                                }
                                else
                                {
                                    imageOrder.sourceSize.width--;
                                }
                                wheel.accepted=true
                            }
                }
            }
        }

        DragText{
            id: summ
            isMoveMode: rectangleOrder.ctrlPressed
            settinsCategory: "EditOrderSum"
            textVerticalAlignment: TextEdit.AlignRight
            x: 159
            y: 80
            width: 220
            height: 30
            regExpString:/^\d+$/;
//            borderEnable: false

            textEdit.onTextChanged: {
                if(regExpString.test(textEdit.text))
                    summText.text = Digit2vn.transform(text);

            }

        }
        DragText{
            id: summTextCurrency
            isMoveMode: rectangleOrder.ctrlPressed
            settinsCategory: "EditOrderSumCurrency"
            textVerticalAlignment: TextEdit.AlignHCenter
            x: 381
            y: 80
            width: 53
            height: 30
            textEdit.font.capitalization: Font.AllUppercase
            regExpString:/^VND|USD$/i;
            text: "VND"
//            borderEnable: false
        }
        DragText{
            id: summText
            isMoveMode: rectangleOrder.ctrlPressed
            settinsCategory: "EditOrderSumText"
            textVerticalAlignment: TextEdit.AlignLeft
            x: 118
            y: 100
            width: 425
            height: 30
//            borderEnable: false
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

