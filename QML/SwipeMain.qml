import QtQuick 2.5

SwipeView {
    anchors.fill: parent
    model: ListModel {
        ListElement {
            title: qsTr("Контрагенты")
            source: "Kontragent.qml"
        }

//        ListElement {
//            title: "Register"
//            source: "RegisterScreen.qml"
//        }

//        ListElement {
//            title: "Restore Password"
//            source: "RestorePasswordScreen.qml"
//        }
    }
}
