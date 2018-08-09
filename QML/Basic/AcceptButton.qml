import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

GroupBox {
    id: groupBoxBottom
    flat: true
    width: 200

    RowLayout {
        id: rowLayout1
        anchors.fill: parent
        anchors.leftMargin: parent.width/2
        spacing: 5

        Button {
            id: buttonOk
            text: qsTr("Принять")
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.rightMargin: 148
//                isDefault: false
            iconSource: "qrc:/Image/48/Symbol Check 2.png"
            style: ProjectButtonStyle {
            }
            onClicked:  checkAccess();
        }

        Button {
            id: buttonCancel
            text: qsTr("Отмена")
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.rightMargin: 42
            iconSource: "qrc:/Image/48/Symbol Stop 2.png"
            style: ProjectButtonStyle {
            }
            onClicked: cancelEdit();
        }
    }
}
