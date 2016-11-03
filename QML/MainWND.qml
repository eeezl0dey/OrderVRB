import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0


ApplicationWindow {
    title: qsTr("OrderVRB")
    width: 640
    height: 480
    visible: true
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    id: mainApp



//    Action {
//        id: exitAction
//        text: qsTr("Выход")
////        iconSource: "images/textitalic.png"
////        iconName: "format-text-italic"
//        onTriggered: Qt.quit();
////        checkable: true
////        checked: document.italic
//    }

//    Action {
//        id: contragentAction
//        text: qsTr("&Контрагенты")
////        iconSource: "images/textitalic.png"
////        iconName: "format-text-italic"
//        onTriggered: kontragent.show()
////        checkable: true
////        checked: document.italic
//    }


//    menuBar: MenuBar {
//        Menu {
//            title: qsTr("Файл")
//            MenuItem { action: exitAction }
//        }
//        Menu {
//            title: qsTr("&Справочники")
//            MenuItem { action: contragentAction}
//        }
//    }

//    MainForm {
//        id: mainForm
////        visible: false
//        anchors.fill: parent
//        button1.onClicked: messageDialog.show(qsTr("Button 1 pressed"))
//        button2.onClicked: messageDialog.show(qsTr("Button 2 pressed"))
//        button3.onClicked: messageDialog.show(qsTr("Button 3 pressed"))
//    }

//    MessageDialog {
//        id: messageDialog
//        title: qsTr("May I have your attention, please?")

//        function show(caption) {
//            messageDialog.text = caption;
//            messageDialog.open();
//        }
//    }

//    Kontragent {
//        id: kontragent
//        visible: false;
//    }

    WindowFone{}

    SwipeMain{
        anchors.fill: parent;
    }


    Login {
        id:loginDlg
        visible: true;
//        visible: false;
        onSignalAcceptPass: {
            mainApp.title = "OrderVRB (" + dataBase.userFullName + ")";
            mainApp.show();
            loginDlg.hide();
        }
    }

    onSceneGraphInitialized: {
        loginDlg.show();
        mainApp.hide();
    }

}
