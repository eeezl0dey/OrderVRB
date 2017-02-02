import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import "Basic"

ColumnLayout {
    id: mainColumn
    property int margin: 12
    property  int rowId: 0
    property alias bname: textBankName.text
    property alias baddress: textAddress.text
    property bool isNew: false
    height: 230

    Label {
        id: labelInfo
        height: 50
        text: isNew ? qsTr("Введите данные нового банка") : qsTr("Редактирование банка");
        anchors.left: parent.left
        anchors.right: parent.right
        font.bold: true
        font.pointSize: 14
        font.family: "Tahoma"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }


    ColumnLayout {
        id: groupBoxBody
        Layout.fillWidth: true
        Layout.leftMargin: margin
        Layout.rightMargin: margin

        RowLayout {
            id: gridLayoutInput
            anchors.topMargin: mainColumn.margin
            Layout.fillWidth: true
            Layout.fillHeight: true

            Label {
                id: labelID
                text: qsTr("Код:")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.bold: true
            }

            Label {
                id: labelIDNumber
                text: rowId
                Layout.minimumWidth: 70
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                font.bold: true
            }

            Label {
                id: labelBankName
                text: qsTr("Наименование банка:")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.bold: true
            }

            TextField {
                id: textBankName
                x: 142
//                Layout.fillWidth: true
//                Layout.fillHeight: true
                Layout.minimumWidth: 100
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                onAccepted:  checkAccess();
            }

            Label {
                id: labelAddress
                text: qsTr("Адрес банка:")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.bold: true
            }

            TextField {
                id: textAddress
                Layout.fillWidth: true
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
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
        if(focus)textBankName.forceActiveFocus();
}

