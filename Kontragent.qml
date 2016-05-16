import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0

Window{
    id: winkontragent
    width: 400
    height: 400
    visible: true
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2

    LinearGradient {
           anchors.fill: parent
           start: Qt.point(0, 0)
           end: Qt.point(parent.height, parent.width)
           gradient: Gradient {
               GradientStop {
                 position: 0.0
                 color: "#F0F0F0"
               }
               GradientStop {
                 position: 0.2
                 color: "#A0A0A0"
               }
               GradientStop {
                 position: 1.0
                 color: "#F0F0F0"
               }
             }
    }

    KontragentForm {
        anchors.fill: parent
        model: dataBase.modelKontr
    }
}

