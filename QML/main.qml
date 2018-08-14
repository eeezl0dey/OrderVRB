import QtQuick 2.10
import QtQuick.Controls 2.3
import Qt.labs.settings 1.0
import QtQuick.Window 2.3
import "Basic"

ApplicationWindow {
    id: mainApp
    title: qsTr("OrderVRB")
    width: 770
    height: 700
    minimumWidth: 770
    minimumHeight: 480
//    maximumWidth: 900
//    maximumHeight: 700
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    visible: true


    property string hostName
    property string databaseName
    property string userName
    property string passwd
    Settings {
        property alias hostName: mainApp.hostName
        property alias databaseName: mainApp.databaseName
        property alias dbuserName: mainApp.userName
        property alias dbpasswd: mainApp.passwd
    }

    Item{
        id: columnLoad
        anchors.fill: parent
        Loader {
            id: pageLoader
            anchors.fill: parent
        }

    }

//    header: ToolBar {
//        contentHeight: toolButton.implicitHeight

//        ToolButton {
//            id: toolButton
//            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
//            font.pixelSize: Qt.application.font.pixelSize * 1.6
//            onClicked: {
//                if (stackView.depth > 1) {
//                    stackView.pop()
//                } else {
//                    drawer.open()
//                }
//            }
//        }

//        Label {
//            text: stackView.currentItem.title
//            anchors.centerIn: parent
//        }
//    }

//    Drawer {
//        id: drawer
//        width: mainApp.width * 0.66
//        height: mainApp.height

//        Column {
//            anchors.fill: parent

////            ItemDelegate {
////                text: qsTr("Контрагенты")
////                width: parent.width
////                onClicked: {
////                    stackView.push("Kontragent.qml")
////                    drawer.close()
////                }
////            }
////            ItemDelegate {
////                text: qsTr("Банки")
////                width: parent.width
////                onClicked: {
////                    stackView.push("Bank.qml")
////                    drawer.close()
////                }
////            }
////            ItemDelegate {
////                text: qsTr("Пользователи")
////                width: parent.width
////                visible: dataBase.isAdmin
////                onClicked: {
////                    stackView.push("User.qml")
////                    drawer.close()
////                }
////            }
//        }
//    }

//    StackView {
//        id: stackView
//        initialItem: loginDlg.visible ? "" : "Order.qml"
//        anchors.fill: parent
//    }

    Login {
        id:loginDlg
//        visible: true;
        visible: false;
        onSignalAcceptPass: {
           onClicked: pageLoader.source = "MainSV.qml"
//            pageLoader.width = mainApp.width
//            pageLoader.height = mainApp.height
//           onClicked: pageLoader.source = "SetConnectDb.qml"
            mainApp.title = "OrderVRB (" + dataBase.userFullName + ")";
            mainApp.show();
            loginDlg.hide();
        }
    }

    SetConnectDb {
        id:connectDlg
//        visible: true;
        visible: false;
        onSignalAcceptDbPass: {
            hostName = connectDlg.hostAddress;
            databaseName = connectDlg.dbName;
            userName = connectDlg.dbUserName;
            passwd = connectDlg.dbPasswd;
            loginDlg.show();
            connectDlg.hide();
        }

    }

    onSceneGraphInitialized:  {
        loginDlg.show();
        mainApp.hide()
    }
}
