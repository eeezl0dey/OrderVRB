import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2

ApplicationWindow {
    title: qsTr("Hello World")
    width: 640
    height: 480
    visible: true
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    id: mainApp

    menuBar: MenuBar {
        Menu {
            title: qsTr("Файл")
            MenuItem {
                text: qsTr("Выход")
                onTriggered: Qt.quit();
            }
        }
        Menu {
            title: qsTr("&Справочники")
            MenuItem {
                text: qsTr("&Контрагенты")
                onTriggered: kontragent.show();
            }
        }
    }

    MainForm {
        id: mainForm
        visible: false
        anchors.fill: parent
        button1.onClicked: messageDialog.show(qsTr("Button 1 pressed"))
        button2.onClicked: messageDialog.show(qsTr("Button 2 pressed"))
        button3.onClicked: messageDialog.show(qsTr("Button 3 pressed"))
    }

    MessageDialog {
        id: messageDialog
        title: qsTr("May I have your attention, please?")

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }

    Kontragent {
        id: kontragent
        visible: false;
    }

    Login {
        id:loginApp
        visible: true;
        onAcceptPass: {
            if(dataBase.login(loginForm.textLogin,loginForm.textPass))
            {
                mainApp.title = "OrderVRB (" + dataBase.userFullName + ")";
                mainForm.visible = true;
                loginApp.hide();
            }
            else
                loginForm.labelWelcome.text = qsTr("Имя пользователя или пароль введены не корректно");
        }
    }

}
