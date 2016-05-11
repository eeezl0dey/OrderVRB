import QtQuick 2.4
import QtQuick.Controls 1.2

Item {
    id: item1
    width: 479
    height: 394

    TableView {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 45
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        TableViewColumn {
            id: num
            role: "id"
            title: "#"
            width: 50
            horizontalAlignment: Text.AlignHCenter
        }
        TableViewColumn {
            role: "fullname"
            title: "Наименование"
            width: 200
            horizontalAlignment: Text.AlignHCenter
        }
        model: libraryModel
    }

    Button {
        id: buttonAdd
        x: 41
        y: 355
        width: 118
        height: 25
        text: qsTr("Добавить")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 14
    }
}

