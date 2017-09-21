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

    property alias aSumm: summ.text
    property alias aSummText: summText.text
    property alias aTextCurrency: summTextCurrency.text
    property alias aDescription: discriptionText.text
    property alias aBeneficiaryIndex: beneficiaryCombo.currentIndex
    property alias aContragentIndex: contragentCombo.currentIndex

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
        property int movePressed: 0 //  1 - нажата ctrl (горизонтальный масштаб); 2 - нажата shift (масштаб по вертикали); 3 - и вертикали и горизонтали
        clip: true
        Image {
            id: imageOrder
            x: pictureX
            y: pictureY
            sourceSize.width: 754
            source: "qrc:/Image/vrbpay.png"
            Keys.onPressed: {
                if(event.key === Qt.Key_Control)
                    rectangleOrder.movePressed |= 1;
                if(event.key === Qt.Key_Shift)
                    rectangleOrder.movePressed |= 2;
            }
            Keys.onReleased: {
                if(event.key === Qt.Key_Control || event.key === Qt.Key_Shift){
                    rectangleOrder.movePressed = 0;
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
                    if(rectangleOrder.movePressed){
                        return imageOrder
                    }
                    else{
                        return null;
                    }
                }


                onWheel:
                {
                    if (rectangleOrder.movePressed){
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
            moveMode: rectangleOrder.movePressed
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
                    summText.text = Digit2vn.transform(text) + " " + summTextCurrency.text;

            }

        }
        DragText{
            id: summTextCurrency
            moveMode: rectangleOrder.movePressed
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
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderSumText"
//            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            regExpString:/^(\D|\S|\s)+$/;
            x: 29
            y: 97
            width: 520
            height: 40
//            borderEnable: false
        }

        DragText{
            id: discriptionText
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderDiscriptionText"
//            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            regExpString:/^.+$/;
            x: 105
            y: 144
            width: 632
            height: 20
//            borderEnable: false
        }

        ComboText{
            id: beneficiaryCombo
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderBeneficiaryCombo"
//            textVerticalAlignment: TextInput.AlignVCenter
//            extHorisontalAlignment: TextInput.AlignLeft
//            regExpString:/^\D+$/;
            model: dataBase.modelProxyKontr
            textRole: "fname"
            x: 89
            y: 162
            width: 270
            height: 20

            onCurrentIndexChanged: {
                bankBeneficiaryText.text = dataBase.modelKontr.getDataFromKey(beneficiaryCombo.textAt(currentText), textRole, 'bankname')
                accBankBeneficiaryText.text = dataBase.modelKontr.getDataFromKey(currentText, textRole, 'naccount')

//                bankBeneficiaryText.text = dataBase.modelProxyKontr.index(currentText,0x0100 + 8).data
//                accBankBeneficiaryText.text = dataBase.modelProxyKontr.data(currentIndex,0x0100 + 5)
//                bankBeneficiaryText.text = dataBase.modelKontr.getData(currentIndex, 'bankname')
//                accBankBeneficiaryText.text = dataBase.modelKontr.getData(currentIndex,'naccount')
            }

        }

        DragText{
            id: accBankBeneficiaryText
            moveMode: rectangleOrder.movePressed
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
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderBankBeneficiaryText"
//            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            x: 90
            y: 266
            width: 286
            height: 20
            textInput.readOnly: true
            regExpString:/^.+$/;
//            borderEnable: false
        }

        ComboText{
            id: contragentCombo
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderContragentCombo"
//            textVerticalAlignment: TextInput.AlignVCenter
//            extHorisontalAlignment: TextInput.AlignLeft
//            regExpString:/^\D+$/;
            model: dataBase.modelKontr
            textRole: 'fname'
            x: 454
            y: 172
            width: 270
            height: 20

            onCurrentIndexChanged: {
                bankcontragentText.text = dataBase.modelKontr.getData(currentIndex, 'bankname')
                accBankcontragentText.text = dataBase.modelKontr.getData(currentIndex,'naccount')
            }

        }

        DragText{
            id: accBankcontragentText
            moveMode: rectangleOrder.movePressed
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
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderBankContragentText"
//            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            x: 450
            y: 266
            width: 286
            height: 20
            textInput.readOnly: true
            regExpString:/^.+$/;
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


       HelpMoving{

       }


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

