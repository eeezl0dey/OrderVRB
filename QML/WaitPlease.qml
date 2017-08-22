import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4
import "Basic"

Window {
    id: waitPlease
    width: 200
    height: 180
    visible: true
    flags: Qt.FramelessWindowHint
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2
    title: qsTr("Ожидание подключения")
    modality: Qt.ApplicationModal

    color: "gray"

    // Задаём сигнал выходам

    Column {
        id: waitForm
        anchors.fill: parent

        Label {
            id: labelWait
            height: 50
            x: 7
            text: qsTr("Идет подключение")
            font.bold: true
            font.pointSize: 14
            font.italic: true
            font.family: "Tahoma"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Rectangle {
            id: rectImage
            color: "white"
            height: 120
            width: waitPlease.width
            Image {
                id: img
                x: rectImage.width/2 - img.width/2
                y: 0
                sourceSize.width: rectImage.height
                sourceSize.height: rectImage.height

                rotation: 0
                source: "qrc:/Image/loader.png"
            }
            PropertyAnimation on x{
                target: img
                properties: "rotation"
                from: 0
                to: 360
                duration: 9999
                running: true
                easing.type: Easing.Linear
                loops: Animation.Infinite
            }

        }
    }

}
