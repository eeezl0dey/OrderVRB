import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.0

Column {
    id: maincolumn
    property int margin: 12

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
                id: labelINN
                Layout.preferredWidth: labelID.width
                text: qsTr("Код нологоплательщика:")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.bold: true
            }

            TextField {
                id: textINN
                x: 142
                Layout.fillWidth: true
                Layout.fillHeight: true
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
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 2 * maincolumn.margin
        anchors.bottomMargin: maincolumn.margin

        RowLayout {
            id: rowLayout1
            anchors.fill: parent
            spacing: 5

            Button {
                id: buttonOk
                text: qsTr("Принять")
                Layout.fillWidth: false
                z: 1
                anchors.right: parent.right
                anchors.rightMargin: 148
                tooltip: qsTr("Вход в программу")
//                isDefault: false
                checkable: false
                onClicked:  checkAccess();
            }

            Button {
                id: buttonCancel
                text: qsTr("Отмена")
                anchors.right: parent.right
                anchors.rightMargin: 42
                z: 0
                rotation: 0
                antialiasing: false
                transformOrigin: Item.Center
                clip: false
                tooltip: qsTr("Завершение программы")
                onClicked: cancelEdit();
            }
        }
    }

    onFocusChanged:
        if(focus)textContrName.forceActiveFocus();
}

