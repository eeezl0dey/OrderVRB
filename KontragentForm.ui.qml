import QtQuick 2.4
import QtQuick.Controls 1.2

Item {
    id: item1
    width: 479
    height: 394
    property alias model: idTable.model


    TableView {
        id: idTable;
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 45
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        TableViewColumn {
            id: columnNum
            role: "idcontragent"
            title: "#"
            width: 50
            horizontalAlignment: Text.AlignHCenter
        }
        TableViewColumn {
            id:columnFullname
            role: "fname"
            title: "Наименование"
            width: parent.width - columnNum.width - columnInn.width
            horizontalAlignment: Text.AlignHCenter
        }
        TableViewColumn {
            id:columnInn
            role: "inn"
            title: "ИНН"
            width: 200
            horizontalAlignment: Text.AlignHCenter
        }
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

