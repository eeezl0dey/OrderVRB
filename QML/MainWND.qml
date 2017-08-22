import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import Qt.labs.settings 1.0
import "Basic"


ApplicationWindow {
    title: qsTr("OrderVRB")
    width: 775
    height: 700
    minimumWidth: 640
    minimumHeight: 400
    visible: true
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    id: mainApp

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

    ListModel {
        id: listModelWindow
        ListElement {
            title: qsTr("Счета")
            source: "qrc:/QML/Order.qml"
        }

        ListElement {
            title: qsTr("Контрагенты")
            source: "qrc:/QML/Kontragent.qml"
        }

        ListElement {
            title: qsTr("Банки")
            source: "qrc:/QML/Bank.qml"
        }
    }


    WindowFone{}

    SwipeMain{
        id: swipeMain
        anchors.fill: parent;
    }


    Login {
        id:loginDlg
//        visible: true;
        visible: false;
        onSignalAcceptPass: {
            if(dataBase.isAdmin)
            {
                listModelWindow.append({"title": qsTr("Пользователи"), "source": "qrc:/QML/User.qml"});

                {"cost": 5.95, "name":"Pizza"}
            }

            swipeMain.model = listModelWindow;
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

    WaitPlease {
        id:waitDlg
        visible: true;
//        visible: false;
    }


    onSceneGraphAboutToStop:  {
//    onSceneGraphInitialized: {
        mainApp.hide();
        waitDlg.show()
        if(dataBase.setConnect(hostName, databaseName, userName, passwd)){           
            loginDlg.show();
            connectDlg.hide();
            mainApp.hide();
        }
        else{
            connectDlg.hostAddress = hostName;
            connectDlg.dbName = databaseName;
            connectDlg.dbUserName = userName;
            connectDlg.dbPasswd = passwd;
            connectDlg.errInfo = dataBase.getConnectError();
            connectDlg.show();           
            loginDlg.hide();
        }
        waitDlg.hide()
    }
}
