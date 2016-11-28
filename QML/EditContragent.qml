import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0
import "Style"

ColumnLayout {
    id: maincolumn
    property int margin: 12
    property  int rowId: 0

    Label {
        id: labelInfo
        height: 50
        text: qsTr("Введите данные нового контрагента")
        anchors.left: parent.left
        anchors.right: parent.right
        font.bold: true
        font.pointSize: 14
        font.family: "Tahoma"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }


    GroupBox {
        id: groupBoxBody
        flat: true
        checkable: false
        checked: false
        anchors.left: parent.left
        anchors.right: parent.right
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

            Label {
                id: labelIDNumber
                Layout.fillWidth: true
                Layout.fillHeight: true
                text: qsTr("№")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
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
        }
    }


    GroupBox {
        id: groupBoxBottom
        flat: true
        Layout.fillWidth: true


        RowLayout {
            id: rowLayout1
            anchors.fill: parent
            spacing: 5
            anchors.bottomMargin: 20

            Button {
                id: buttonOk
                text: qsTr("Принять")
                anchors.right: parent.right
                anchors.rightMargin: 148
//                isDefault: false
                iconSource: "qrc:/Image/48/Symbol Check 2.png"
                style: ProjectButtonStyle {
                }
                onClicked:  checkAccess();
            }

            Button {
                id: buttonCancel
                text: qsTr("Отмена")
                anchors.right: parent.right
                anchors.rightMargin: 42
                iconSource: "qrc:/Image/48/Symbol Stop 2.png"
                style: ProjectButtonStyle {
                }
                onClicked: cancelEdit();
            }
        }
    }

    onFocusChanged:
        if(focus)textContrName.forceActiveFocus();
}

