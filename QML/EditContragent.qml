import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.0
import "Basic"

ColumnLayout {
    id: maincolumn
    property int margin: 5
    property alias rowId: labelIDNumber.text
    property alias isBeneficiary: checkIsBeneficiary.checked
    property alias contrName: textContrName.text
    property alias bankIndex: comboBoxBank.currentIndex
    property alias bankComboBox: comboBoxBank
    property alias accNum: textAcc.text
    property bool isNew: false


    Label {
        id: labelInfo
        height: 40
        Layout.fillWidth: true
        font.bold: true
        font.pointSize: 14
        font.family: "Tahoma"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: isNew ? qsTr("Введите данные нового контрагента") : qsTr("Редактирование контрагента");
    }


    GroupBox {
        id: groupBoxBody
        flat: true
        checkable: false
        checked: false
        Layout.fillWidth: true
        height: 250

        GridLayout {
            id: gridLayoutInput
            anchors.topMargin: maincolumn.margin
            columns: 2
            anchors.fill: parent

            Label {
                id: labelID
                Layout.preferredWidth: 250
                text: qsTr("Код:")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.bold: true
            }

            RowLayout {
                Layout.fillWidth: true
                Layout.fillHeight: true
                Label {
                    id: labelIDNumber
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: qsTr("№")
//                    vertvicalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    font.bold: true
                }
                CheckBox {
                    id: checkIsBeneficiary
                    Layout.fillHeight: true
                    checked: true
                    width: 100
                    text: qsTr("Получатель")
                }
            }

            Label {
                id: labelContrName
                Layout.preferredWidth: labelID.width
                text: qsTr("Наименование контрагента:")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.bold: true
            }

            TextField {
                id: textContrName
                x: 142
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                onAccepted:  checkAccess();
            }

            Label {
                id: labelBank
                Layout.preferredWidth: labelID.width
                text: qsTr("Банк:")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.bold: true
            }


            ComboBox {
                id: comboBoxBank
                x: 142
                Layout.fillWidth: true
                Layout.fillHeight: true
                model: dataBase.modelBank
                textRole: 'name'

                onAccepted:  checkAccess();
            }

            Label {
                id: labelAcc
                Layout.preferredWidth: labelID.width
                text: qsTr("Счет:")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.bold: true
            }


            TextField {
                id: textAcc
                x: 142
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                onAccepted:  checkAccess();
                validator: RegExpValidator { regExp: /\d{10,}\s\D\D\D/ }
            }

        }
    }


    AcceptButton{
        Layout.fillWidth: true
    }

    onFocusChanged:
        if(focus)textContrName.forceActiveFocus();
}

