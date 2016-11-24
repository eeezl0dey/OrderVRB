import QtQuick 2.5

SwipeView {
    anchors.fill: parent
    model: ListModel {
        ListElement {
            title: qsTr("Контрагенты")
            source: "Kontragent.qml"
        }

        ListElement {
            title: qsTr("Банки")
            source: "Bank.qml"
        }

        ListElement {
            title: qsTr("Пользователи")
            source: "User.qml"
        }
    }
}
