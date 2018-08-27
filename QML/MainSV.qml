import QtQuick 2.10
import QtQuick.Controls 2.3
import Qt.labs.settings 1.0
import QtQuick.Window 2.3
import QtQuick.Layouts 1.3
import "Basic"

RowLayout {
    id: itemTop
    anchors.fill: parent
    Layout.fillHeight: true
    Layout.fillWidth: true

    //    Rectangle{
    //            anchors.fill: parent
    ////            Layout.fillHeight: true
    ////            Layout.fillWidth: true
    //            color: "red"
    //            border.color: "black"
    //            border.width: 5
    //            radius: 10
    //    }
    ColumnLayout {

        //    anchors.fill: parent
        RowLayout {
            ToolBar {
                id: toolBar
                contentHeight: toolButton.implicitHeight

                ToolButton {
                    id: toolButton
                    text: stackView.depth > 1 ? "\u25C0" : "\u2630"
                    font.pixelSize: Qt.application.font.pixelSize * 1.6
                    onClicked: {
                        if (stackView.depth > 1) {
                            stackView.pop()
                            order.model = dataBase.modelOrderRetrieve;
                        } else {
                            drawer.open()
                        }
                    }
                }
            }
            Label {
                text: stackView.currentItem.title
                font.pointSize: 20
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }
        }
        Frame {
            topPadding: 0
            bottomPadding: 0
            leftPadding: 0
            rightPadding: 0
            Layout.fillWidth: true
            Layout.fillHeight: true

            Drawer {
                id: drawer
                width: mainApp.width * 0.66
                height: mainApp.height

                Column {
                    anchors.fill: parent

                    ItemDelegate {
                        text: qsTr("Контрагенты")
                        width: parent.width
                        onClicked: {
                            stackView.push("Kontragent.qml")
                            drawer.close()
                        }
                    }
                    ItemDelegate {
                        text: qsTr("Банки")
                        width: parent.width
                        onClicked: {
                            stackView.push("Bank.qml")
                            drawer.close()
                        }
                    }
                    ItemDelegate {
                        text: qsTr("Пользователи")
                        width: parent.width
                        visible: dataBase.isAdmin
                        onClicked: {
                            stackView.push("User.qml")
                            drawer.close()
                        }
                    }
                }
            }

            Order{
                id: order
            }

            StackView {
                id: stackView

//                initialItem: "Order.qml"
                initialItem: order
                anchors.fill: parent

            }
        }
    }
}
