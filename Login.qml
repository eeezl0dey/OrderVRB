import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1

Window {
    id:loginWnd
    width: 640
    height: loginForm.implicitHeight
    visible: true
    flags: Qt.FramelessWindowHint
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    title: qsTr("Авторизация")
//    modality: Qt.ApplicationModal
    signal signalAcceptPass   // Задаём сигнал выхода

    WindowFone{}


    Column {
        id: loginForm
        anchors.fill: parent
        property int margin: 12
        width: 640
//            height: labelWelcome.implicitHeight + groupBoxBody.implicitHeight + groupBoxBottom.implicitHeight + margin*4;
//            property alias buttonCancel: buttonCancel
//            property alias buttonOk: buttonOk
//            property alias labelWelcome: labelWelcome
//            property alias textLogin: textFieldLogin.text
//            property alias textPass: textFieldPass.text
//            property alias textFieldPass: textFieldPass
//            property alias textFieldLogin: textFieldLogin



        Label {
            id: labelWelcome
            height: 50
            text: qsTr("Добро пожаловать в программу")
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
                anchors.topMargin: loginForm.margin
                columns: 2
                anchors.fill: parent

                Label {
                    id: labelLogin
                    Layout.preferredWidth: 150
                    text: qsTr("Пользователь:")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    font.bold: true
                }

                TextField {
                    id: textFieldLogin
                    x: 142
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    placeholderText: qsTr("имя пользователя")
                    font.pixelSize: 12
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    onAccepted:  checkAccess();
                    text: "admin"
                }

                Label {
                    id: labelPass
                    Layout.preferredWidth: labelLogin.width
                    text: qsTr("Пароль:")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    font.bold: true
                }

                TextField {
                    id: textFieldPass
                    x: 142
                    inputMask: qsTr("")
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    placeholderText: qsTr("пароль пользователя")
    //                text: qsTr("Text Input")
                    font.pixelSize: 12
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    echoMode: TextInput.Password;
                    onAccepted:  checkAccess();
                    text: "admin"
                }

            }
        }


        GroupBox {
            id: groupBoxBottom
            flat: true
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 2 * loginForm.margin
            anchors.bottomMargin: loginForm.margin

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
                    onClicked: Qt.quit();
                }
            }
        }
    }

    function checkAccess(){
        if(dataBase.login(textFieldLogin.text,textFieldPass.text))
        {
            signalAcceptPass()
        }
        else
            labelWelcome.text = qsTr("Имя пользователя или пароль введены не корректно");
    }

    onActiveChanged:  {
        if (active) {
            textFieldLogin.forceActiveFocus();
        }
    }

}
