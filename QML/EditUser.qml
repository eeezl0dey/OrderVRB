import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1
import QtQuick.Window 2.0
import QtQuick.Controls.Styles 1.4
import "Basic"

ColumnLayout {
    id: mainColumn
    property int margin: 12
    property  int rowId: 0
    property bool isNew: false
    property alias uname: textLogin.text
    property alias upass: textPass.text
    property alias ufname: textFullName.text
    property alias isadm: checkIsAdmin.checked
    height: 230

    Label {
        id: labelInfo
        height: 50
        text: isNew ? qsTr("Введите данные нового пользователя") : qsTr("Редактирование пользователя");
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
                id: labelLogin
                text: qsTr("Логин:")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.bold: true
            }

            TextField {
                id: textLogin
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
                id: labelPass
                text: qsTr("Пароль:")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.bold: true
            }

            TextField {
                id: textPass
                Layout.fillWidth: true
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                echoMode: TextInput.Password
                onAccepted:  checkAccess();
            }

        }
        RowLayout {
            id: gridLayoutInput2
            anchors.topMargin: mainColumn.margin
            Layout.fillWidth: true
            Layout.fillHeight: true

            Label {
                id: labelFullName
                text: qsTr("Полное Ф.И.О.:")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                font.bold: true
            }

            TextField {
                id: textFullName
                Layout.fillWidth: true
                font.pixelSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                onAccepted:  checkAccess();
            }

            CheckBox{
                id: checkIsAdmin
                text: qsTr("Администратор:")
            }
        }

    }


    AcceptButton{

    }

    onFocusChanged:
        if(focus)textLogin.forceActiveFocus();
}

