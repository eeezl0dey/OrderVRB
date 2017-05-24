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
            sourceSize.width: 754
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
//            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignRight
            x: 160
            y: 75
            width: 230
            height: 20
            regExpString:/^\d+$/;
//            borderEnable: false

            textInput.onTextChanged: {
                if(regExpString.test(textInput.text))
                    summText.text = Digit2vn.transform(text);

            }

        }
        DragText{
            id: summTextCurrency
            isMoveMode: rectangleOrder.ctrlPressed
            settinsCategory: "EditOrderSumCurrency"
            textHorisontalAlignment: TextInput.AlignHCenter
            x: 392
            y: 77
            width: 60
            height: 20
            textInput.font.capitalization: Font.AllUppercase
            regExpString:/^VND|USD$/i;
            text: "VND"
//            borderEnable: false
        }
        DragText{
            id: summText
            isMoveMode: rectangleOrder.ctrlPressed
            settinsCategory: "EditOrderSumText"
//            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            regExpString:/^\D+$/;
            x: 29
            y: 97
            width: 520
            height: 40
//            borderEnable: false
        }

        DragText{
            id: discriptionText
            isMoveMode: rectangleOrder.ctrlPressed
            settinsCategory: "EditOrderDiscriptionText"
//            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            regExpString:/^\D+$/;
            x: 105
            y: 144
            width: 632
            height: 20
//            borderEnable: false
        }

        ComboText{
            id: beneficiaryCombo
            isMoveMode: rectangleOrder.ctrlPressed
            settinsCategory: "EditOrderBeneficiaryCombo"
//            textVerticalAlignment: TextInput.AlignVCenter
//            extHorisontalAlignment: TextInput.AlignLeft
//            regExpString:/^\D+$/;
            x: 94
            y: 172
            width: 270
            height: 20

        }

        DragText{
            id: accBankBeneficiaryText
            isMoveMode: rectangleOrder.ctrlPressed
            settinsCategory: "EditOrderAccBankBeneficiaryText"
//            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            x: 90
            y: 250
            width: 286
            height: 20
            textInput.readOnly: true
//            borderEnable: false
        }

        DragText{
            id: bankBeneficiaryText
            isMoveMode: rectangleOrder.ctrlPressed
            settinsCategory: "EditOrderBankBeneficiaryText"
//            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            x: 90
            y: 266
            width: 286
            height: 20
            textInput.readOnly: true
//            borderEnable: false
        }

        ComboText{
            id: contragentCombo
            isMoveMode: rectangleOrder.ctrlPressed
            settinsCategory: "EditOrderContragentCombo"
//            textVerticalAlignment: TextInput.AlignVCenter
//            extHorisontalAlignment: TextInput.AlignLeft
//            regExpString:/^\D+$/;
            x: 454
            y: 172
            width: 270
            height: 20

        }

        DragText{
            id: accBankcontragentText
            isMoveMode: rectangleOrder.ctrlPressed
            settinsCategory: "EditOrderAccBankContragentText"
//            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            x: 450
            y: 250
            width: 286
            height: 20
            textInput.readOnly: true
//            borderEnable: false
        }

        DragText{
            id: bankcontragentText
            isMoveMode: rectangleOrder.ctrlPressed
            settinsCategory: "EditOrderBankContragentText"
//            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            x: 450
            y: 266
            width: 286
            height: 20
            textInput.readOnly: true
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

