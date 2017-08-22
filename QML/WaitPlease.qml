import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import "Basic"

Window {
    id: waitPlease
    width: 200
    height: 100
    visible: true
    flags: Qt.FramelessWindowHint
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    title: qsTr("Ожидание подключения")

    // Задаём сигнал выходам
    WindowFone {
    }

    Column {
        id: waitForm
        anchors.fill: parent
        property int margin: 12

        Label {
            id: labelWait
            height: 50
            text: qsTr("Идет подключение")
            anchors.left: parent.left
            anchors.right: parent.right
            font.bold: true
            font.pointSize: 14
            font.family: "Tahoma"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

    }

}
