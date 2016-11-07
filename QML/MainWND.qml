import QtQuick 2.6
import QtQuick.Controls 1.4
import QtQuick.Window 2.0
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0


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
