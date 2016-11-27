import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import Qt.labs.settings 1.0


ApplicationWindow {
    title: qsTr("OrderVRB")
    width: 640
    height: 480
    minimumWidth: 640
    minimumHeight: 300
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


    WindowFone{}

    SwipeMain{
        anchors.fill: parent;
    }


    Login {
        id:loginDlg
//        visible: true;
        visible: false;
        onSignalAcceptPass: {
            mainApp.title = "OrderVRB (" + dataBase.userFullName + ")";
            mainApp.show();
            loginDlg.hide();
        }
    }

    SetConnectDb {
        id:connectDlg
        visible: true;
//        visible: false;
        onSignalAcceptDbPass: {
            hostName = connectDlg.hostName;
            databaseName = connectDlg.dbName;
            userName = connectDlg.dbUserName;
            passwd = connectDlg.dbPasswd;
            loginDlg.show();
            connectDlg.hide();
        }

    }

    onSceneGraphInitialized: {
        if(dataBase.setConnect(hostName, databaseName, userName, passwd)){
            loginDlg.show();
            connectDlg.hide();
            mainApp.hide();
        }
        else{
            connectDlg.hostName = hostName;
            connectDlg.dbName = databaseName;
            connectDlg.dbUserName = userName;
            connectDlg.dbPasswd = passwd;
            connectDlg.errInfo = dataBase.getConnectError();
            connectDlg.show();
            loginDlg.hide();
            mainApp.hide();
        }
    }

}
