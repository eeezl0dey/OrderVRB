import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import "Basic"

Window {
    id: connectWnd
    width: 640
    height: connectForm.implicitHeight
    visible: true
    flags: Qt.FramelessWindowHint
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    title: qsTr("Соединение с базой данных")
    signal signalAcceptDbPass
    property alias errInfo: labelInfo.text
    property alias hostAddress: textFieldHostName.text
    property alias dbName: textFieldBaseName.text
    property alias dbUserName: textFieldLogin.text
    property alias dbPasswd: textFieldPass.text

    // Задаём сигнал выхода
    WindowFone {
    }

    Column {
        id: connectForm
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
            text: qsTr("Введите параметры подключения")
            anchors.left: parent.left
            anchors.right: parent.right
            font.bold: true
            font.pointSize: 14
            font.family: "Tahoma"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            id: labelInfo
            height: 10
            visible: text.length>0
            text: qsTr("ошибка")
            anchors.left: parent.left
            anchors.right: parent.right
//            font.bold: true
            font.pointSize: 10
            font.family: "Tahoma"
            color: "darkred"
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
                anchors.topMargin: connectForm.margin
                columns: 2
                anchors.fill: parent

                Label {
                    id: labelHostName
                    Layout.preferredWidth: 150
                    text: qsTr("Хост:")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    font.bold: true
                }

                TextField {
                    id: textFieldHostName
                    x: 142
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    placeholderText: qsTr("Хост")
                    font.pixelSize: 12
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    onAccepted: checkAccess()
                    text: "localhost"
                }

                Label {
                    id: labelBaseName
                    Layout.preferredWidth: 150
                    text: qsTr("Имя базы:")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    font.bold: true
                }

                TextField {
                    id: textFieldBaseName
                    x: 142
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    placeholderText: qsTr("Наименование базы")
                    font.pixelSize: 12
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    onAccepted: checkAccess()
                    text: "OrderVRB"
                }


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
                    onAccepted: checkAccess()
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
                    echoMode: TextInput.Password
                    onAccepted: checkAccess()
                    text: "admin"
                }
            }
        }

        GroupBox {
            id: groupBoxBottom
            flat: true
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 2 * connectForm.margin
            anchors.bottomMargin: connectForm.margin

            RowLayout {
                id: rowLayout1
                anchors.leftMargin: parent.width/2
                anchors.left: parent.left
                anchors.right: parent.right
                spacing: 5

                Button {
                    id: buttonOk
                    text: qsTr("Принять")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    activeFocusOnPress: true
                    isDefault: true
                    tooltip: qsTr("Вход в программу")
                    iconSource: "qrc:/Image/48/Symbol Check 2.png"
                    style: ProjectButtonStyle {
                    }

                    onClicked: checkAccess()
                }

                Button {
                    id: buttonCancel
                    text: qsTr("Отмена")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    clip: false
                    tooltip: qsTr("Завершение программы")
                    iconSource: "qrc:/Image/48/Symbol Stop 2.png"
                    style: ProjectButtonStyle {
                    }
                    onClicked: Qt.quit()
                }
            }
        }
    }

    function checkAccess() {
        if (dataBase.setConnect(hostAddress, dbName, dbUserName, dbPasswd)) {
            signalAcceptDbPass()
        } else
        {
            errInfo = dataBase.getConnectError();
        }
    }

    onActiveChanged: {
        if (active) {
            textFieldHostName.forceActiveFocus()
        }
    }
}
