import QtQuick 2.6
import Qt.labs.settings 1.0
import QtQuick.Controls 2.2
import QtQml.Models 2.2
import QtQuick.Controls.Styles 1.4

Item {
    id: root

    x: 0;
    y: 0;
    width: 30;
    height: 30;

    Settings {
        category: settinsCategory
        property alias textX: checkBox.x
        property alias textY: checkBox.y
        property alias textWidth: root.width
        property alias textHeihgt: root.height
    }

    CheckBox {
        id: checkBox
        text: qsTr("ghgh")
///TODO Доделать элимент, разместить на форме и сконнектить с базой
        indicator: Rectangle {
                  implicitWidth: 26
                  implicitHeight: 26
                  x: checkBox.leftPadding
                  y: parent.height / 2 - height / 2
                  radius: 3
                  border.color: checkBox.down ? "#17a81a" : "#21be2b"

                  Rectangle {
                      width: 14
                      height: 14
                      x: 6
                      y: 6
                      radius: 2
                      color: checkBox.down ? "#17a81a" : "#21be2b"
                      visible: checkBox.checked
                  }
              }

              contentItem: Text {
                  text: control.text
                  font: control.font
                  opacity: enabled ? 1.0 : 0.3
                  color: control.down ? "#17a81a" : "#21be2b"
                  horizontalAlignment: Text.AlignHCenter
                  verticalAlignment: Text.AlignVCenter
                  leftPadding: control.indicator.width + control.spacing
              }
    }
}
