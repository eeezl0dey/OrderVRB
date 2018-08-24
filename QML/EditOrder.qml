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
    property int rowId: 0

    property alias aSumm: summ.text
    property alias aSummText: summText.text
    property alias aTextCurrency: summTextCurrency.text
    property alias aDescription: discriptionText.text
    property alias aBeneficiaryText: beneficiaryCombo.currentText
    property alias aContragentText: contragentCombo.currentText
    property alias aBeneficiaryCombo: beneficiaryCombo
    property alias aContragentCombo: contragentCombo
    property alias aOrder: rectangleOrder
    property bool forPrint: false

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

    Rectangle {
        id: rectangleOrder
        Layout.fillWidth: true
        Layout.fillHeight: true
        //        anchors.margins: 4
        //        border.color: "black"
        color: "transparent"
        property int movePressed: 0 //  1 - нажата ctrl (горизонтальный масштаб); 2 - нажата shift (масштаб по вертикали); 3 - и вертикали и горизонтали; 4 - шрифт, когда нажат Alt
        clip: true
        Image {
            id: imageOrder
            x: pictureX
            y: pictureY

            sourceSize.width: 754
            source: forPrint ? "" : "qrc:/Image/vrbpay.png"
            Keys.onPressed: {
                if (event.key === Qt.Key_Control)
                    rectangleOrder.movePressed |= 1
                if (event.key === Qt.Key_Shift)
                    rectangleOrder.movePressed |= 2
            }
            Keys.onReleased: {
                if (event.key === Qt.Key_Control
                        || rectangleOrder.movePressed > 0) {
                    rectangleOrder.movePressed = 0
                    pictureX = imageOrder.x
                    pictureY = imageOrder.y
                }
            }
            MouseArea {
                id: mouse
                anchors.fill: parent
                onEntered: {
                    parent.forceActiveFocus()
                }

                drag.target: {
                    if (rectangleOrder.movePressed) {
                        return imageOrder
                    } else {
                        return null
                    }
                }

                onWheel: {
                    if (rectangleOrder.movePressed) {
                        if (wheel.angleDelta.y > 0) {
                            imageOrder.sourceSize.width++
                        } else {
                            imageOrder.sourceSize.width--
                        }
                        wheel.accepted = true
                    }
                }
            }
        }

        DragText {
            id: summ
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderSum"
            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignRight
            borderEnable: !forPrint
            x: 160
            y: 75
            width: 230
            height: 20
            font.bold: true
            regExpString: /^\d+$/

            //            borderEnable: false
            textInput.onTextChanged: {
                if (regExpString.test(textInput.text))
                    summText.text =
                            "                    " +
                            Digit2vn.transform(text) +
                            " " +
                            summTextCurrency.text
            }
        }
        DragText {
            id: summTextCurrency
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderSumCurrency"
            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignHCenter
            borderEnable: !forPrint
            x: 392
            y: 77
            width: 60
            height: 20
            font.bold: true
            textInput.font.capitalization: Font.AllUppercase
            regExpString: /^VND|USD$/i
            text: "VND"
            //            borderEnable: false
        }
        DragText {
            id: summText
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderSumText"
            //            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            regExpString: /^(\D|\S|\s)+$/
            borderEnable: !forPrint
            x: 29
            y: 97
            width: 520
            height: 40
            //            borderEnable: false
        }

        DragText {
            id: discriptionText
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderDiscriptionText"
            //            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            regExpString: /^.+$/
            borderEnable: !forPrint
            x: 105
            y: 144
            width: 632
            height: 20
            //            borderEnable: false
        }

        ComboText {
            id: beneficiaryCombo
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderBeneficiaryCombo"
            //            textVerticalAlignment: TextInput.AlignVCenter
            //            extHorisontalAlignment: TextInput.AlignLeft
            //            regExpString:/^\D+$/;
            model: dataBase.modelProxyKontr
            borderEnable: !forPrint
            textRole: "fname"
            x: 89
            y: 162
            width: 270
            height: 20

            onCurrentIndexChanged: {
                bankBeneficiaryText.text = dataBase.modelKontr.getDataFromKey(
                            beneficiaryCombo.textAt(currentText), textRole,
                            'bankname')
                accBankBeneficiaryText.text = dataBase.modelKontr.getDataFromKey(
                            currentText, textRole, 'naccount')

                //                bankBeneficiaryText.text = dataBase.modelProxyKontr.index(currentText,0x0100 + 8).data
                //                accBankBeneficiaryText.text = dataBase.modelProxyKontr.data(currentIndex,0x0100 + 5)
                //                bankBeneficiaryText.text = dataBase.modelKontr.getData(currentIndex, 'bankname')
                //                accBankBeneficiaryText.text = dataBase.modelKontr.getData(currentIndex,'naccount')
            }
        }

        DragText {
            id: accBankBeneficiaryText
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderAccBankBeneficiaryText"
            //            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            borderEnable: !forPrint
            x: 90
            y: 250
            width: 286
            height: 20
            textInput.readOnly: true
            //            borderEnable: false
        }

        DragText {
            id: bankBeneficiaryText
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderBankBeneficiaryText"
            //            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            borderEnable: !forPrint
            x: 90
            y: 266
            width: 286
            height: 20
            textInput.readOnly: true
            regExpString: /^.+$/
            //            borderEnable: false
        }

        ComboText {
            id: contragentCombo
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderContragentCombo"
            //            textVerticalAlignment: TextInput.AlignVCenter
            //            extHorisontalAlignment: TextInput.AlignLeft
            //            regExpString:/^\D+$/;
            model: dataBase.modelKontr
            textRole: 'fname'
            borderEnable: !forPrint
            x: 454
            y: 172
            width: 270
            height: 20

            onCurrentIndexChanged: {
                bankcontragentText.text = dataBase.modelKontr.getData(
                            currentIndex, 'bankname')
                accBankcontragentText.text = dataBase.modelKontr.getData(
                            currentIndex, 'naccount')
            }
        }

        DragText {
            id: accBankcontragentText
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderAccBankContragentText"
            //            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            borderEnable: !forPrint
            x: 450
            y: 250
            width: 286
            height: 20
            textInput.readOnly: true
            //            borderEnable: false
        }

        DragText {
            id: bankcontragentText
            moveMode: rectangleOrder.movePressed
            settinsCategory: "EditOrderBankContragentText"
            //            textVerticalAlignment: TextInput.AlignVCenter
            textHorisontalAlignment: TextInput.AlignLeft
            borderEnable: !forPrint
            x: 450
            y: 266
            width: 286
            height: 20
            textInput.readOnly: true
            regExpString: /^.+$/
            //            borderEnable: false
        }

        function printOrder() {
            lprint.addToPrintList(summ.x, summ.y, summ.width, summ.height,
                                  summ.text, summ.font)
            lprint.addToPrintList(summTextCurrency.x, summTextCurrency.y,
                                  summTextCurrency.width,
                                  summTextCurrency.height,
                                  summTextCurrency.text, summTextCurrency.font)
            lprint.addToPrintList(summText.x, summText.y, summText.width,
                                  summText.height, summText.text, summText.font)
            lprint.addToPrintList(discriptionText.x, discriptionText.y,
                                  discriptionText.width,
                                  discriptionText.height, discriptionText.text,
                                  discriptionText.font)
            lprint.addToPrintList(beneficiaryCombo.x, beneficiaryCombo.y,
                                  beneficiaryCombo.width,
                                  beneficiaryCombo.height,
                                  beneficiaryCombo.text, beneficiaryCombo.font)
            lprint.addToPrintList(accBankBeneficiaryText.x,
                                  accBankBeneficiaryText.y,
                                  accBankBeneficiaryText.width,
                                  accBankBeneficiaryText.height,
                                  accBankBeneficiaryText.text,
                                  accBankBeneficiaryText.font)
            lprint.addToPrintList(bankBeneficiaryText.x, bankBeneficiaryText.y,
                                  bankBeneficiaryText.width,
                                  bankBeneficiaryText.height,
                                  bankBeneficiaryText.text,
                                  bankBeneficiaryText.font)
            lprint.addToPrintList(contragentCombo.x, contragentCombo.y,
                                  contragentCombo.width,
                                  contragentCombo.height, contragentCombo.text,
                                  contragentCombo.font)
            lprint.addToPrintList(accBankcontragentText.x, accBankcontragentText.y,
                                  accBankcontragentText.width,
                                  accBankcontragentText.height, accBankcontragentText.text,
                                  accBankcontragentText.font)
            lprint.addToPrintList(bankcontragentText.x, bankcontragentText.y,
                                  bankcontragentText.width,
                                  bankcontragentText.height, bankcontragentText.text,
                                  bankcontragentText.font)

            lprint.printOrder()
        }
    }

    RowLayout {
        id: rowButton
        //        Layout.fillWidth: true
        Layout.bottomMargin: 20
        Layout.topMargin: 10
        Layout.rightMargin: 50
        Layout.alignment: Qt.AlignRight
        spacing: 20

        HelpMoving {
        }

        Button {
            id: buttonOk
            //            anchors.right: parent.right
            //            anchors.rightMargin: 130
            text: qsTr("Пeчать")
            iconSource: "qrc:/Image/48/Printer 2.png"
            style: ProjectButtonStyle {
            }
            onClicked: checkAccess()
        }

        Button {
            id: buttonCancel
            //            anchors.right: parent.right
            //            anchors.rightMargin: 30
            text: qsTr("Отмена")
            iconSource: "qrc:/Image/48/Symbol Stop 2.png"
            style: ProjectButtonStyle {
            }
            onClicked: cancelEdit()
        }
    }

    //    onFocusChanged:
    //        if(focus)textBankName.forceActiveFocus();
}
