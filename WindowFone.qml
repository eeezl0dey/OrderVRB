import QtQuick 2.0
import QtGraphicalEffects 1.0

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
