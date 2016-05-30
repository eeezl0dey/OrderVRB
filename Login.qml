import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0

Window {
    width: 640
    height: loginForm.implicitHeight
    visible: true
//    flags: Qt.FramelessWindowHint
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    title: qsTr("Авторизация")
    id:loginApp


    LinearGradient {
           anchors.fill: parent
           start: Qt.point(0, 0)
           end: Qt.point(parent.height, parent.width)
           gradient: Gradient {
               GradientStop {
                 position: 0.0
                 color: "#F0F0F0"
               }
               GradientStop {
                 position: 0.2
                 color: "#A0A0A0"
               }
               GradientStop {
                 position: 1.0
                 color: "#F0F0F0"
               }
             }
    }

    LoginForm {
        id: loginForm
        anchors.fill: parent
        buttonCancel.onClicked: Qt.quit();
        buttonOk.onClicked: acceptPass();
        textFieldPass.onAccepted: acceptPass();
        textFieldLogin.onAccepted: acceptPass();
        textFieldPass.onActiveFocusChanged: {
            if(textFieldPass.focus)
                textFieldPass.text = "";
        }

        focus: true
//loginForm.labelWelcome.text = dataBase.login(textLogin,textPass);
//        button1.onClicked: messageDialog.show(qsTr("Button 1 pressed"))
//        button2.onClicked: messageDialog.show(qsTr("Button 2 pressed"))
//        button3.onClicked: messageDialog.show(qsTr("Button 3 pressed"))

    }

//    MessageDialog {
//        id: messageDialog
//        title: qsTr("May I have your attention, please?")

//        function show(caption) {
//            messageDialog.text = caption;
//            messageDialog.open();
//        }
//    }

    MainWND{
        id: mainWND;
        visible: false;
    }

    signal acceptPass()
    onAcceptPass: {
        if(dataBase.login(loginForm.textLogin,loginForm.textPass))
        {
            mainWND.show();
            mainWND.title = "OrderVRB (" + dataBase.userFullName + ")";
            loginApp.hide();
        }
        else
            loginForm.labelWelcome.text = qsTr("Имя пользователя или пароль введены не корректно");
    }
}
