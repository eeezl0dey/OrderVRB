import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import "Style"

SwipeScreen {
    id: winbank
    anchors.fill: parent

    WindowFone {
    }

    ColumnLayout {
        id: bankItem
        anchors.fill: parent
        RowLayout {
            id: rowView
            Layout.fillHeight: true
            Layout.leftMargin: 5
            Layout.rightMargin: 5
            TableView {
                id: idTableBank
                //                anchors.bottom: buttonAdd.top;
                //    //            anchors.bottomMargin: 45
                //                anchors.right: parent.right
                //                anchors.left: parent.left
                //                anchors.top: parent.top
                Layout.fillWidth: true
                Layout.fillHeight: true


                TableViewColumn {
                    id: columnBankNum
                    role: "idbank"
                    title: "#"
                    width: 50
                    horizontalAlignment: Text.AlignHCenter
                    delegate: Item {

                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: styleData.value
                            renderType: Text.NativeRendering
                            anchors.centerIn: parent
                        }
                    }
                }
                TableViewColumn {
                    id: columnBankName
                    role: "name"
                    title: "Наименование"
                    width: 200
                    horizontalAlignment: Text.AlignHCenter
                }
                TableViewColumn {
                    id: columnAddress
                    role: "address"
                    title: "Адрес"
                    width: idTableBank.width - columnBankNum.width - columnBankName.width - columnBankUser.width
                    horizontalAlignment: Text.AlignHCenter
                }
                TableViewColumn {
                    id: columnBankUser
                    role: "creatorname"
                    title: "Создал"
                    width: 150
                    horizontalAlignment: Text.AlignHCenter
                }

                headerDelegate: Rectangle {
                    width: _textHeader.text.length * 1.2
                    height: _textHeader.font.pixelSize * 1.6
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

                    border {
                        width: 1
                        color: (styleData.pressed) ? "blue" : "black"
                    }

                    Text {
                        id: _textHeader

                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.centerIn: parent
                        renderType: Text.NativeRendering

                        font.bold: true
                        font.pointSize: 10

                        color: (styleData.pressed) ? "blue" : "black"
                        text: styleData.value

                        //                    Component.onCompleted:
                        //                    {
                        //                        console.log(_textHeader.text.length)
                        //                    }
                    }
                }

                itemDelegate: Item {
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        renderType: Text.NativeRendering
                        color: styleData.textColor
                        text: styleData.value
                        font.pointSize: 10
                    }
                }

                model: dataBase.modelBank

                onActivated: {
                    editBank.enabled = true
                }
            }
            ColumnLayout {
                Layout.fillHeight: true
                Layout.preferredWidth: 150
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignTop
                Button {
                    id: buttonBankAdd
                    anchors.left: parent.left
                    anchors.right: parent.right
                    Layout.fillWidth: true
                    text: qsTr("Добавить")
                    iconSource: "qrc:/Image/48/Document 2 Add.png"
                    style: ProjectButtonStyle {
                    }
                    onClicked: {
                        editBank.enabled = true
                    }
                }
                Button {
                    id: buttonBankEdit
                    Layout.fillWidth: true
                    text: qsTr("Редактирование")
                    iconSource: "qrc:/Image/48/Document 2 Edit.png"
                    style: ProjectButtonStyle {
                    }
                    onClicked: {
                        editBank.enabled = true
                    }
                }

            }
        }

        EditBank {
            id: editBank
            Layout.alignment: Qt.AlignCenter
            enabled: false
            Layout.preferredHeight: 0

            Behavior on Layout.preferredHeight {
                NumberAnimation {
                    easing.type: Easing.OutExpo
                    duration: 500
                }
            }

            onEnabledChanged: {
                rowView.enabled = !enabled

                if (enabled) {
                    Layout.preferredHeight = 200
                    editBank.forceActiveFocus()
                    winbank.deactivated()
                } else {
                    Layout.preferredHeight = 0
                    idTableBank.forceActiveFocus()
                    winbank.activated()
                }
            }

            function checkAccess() {
                console.log("checkAccess")
//                dataBase.acceptBank(editcontragent.rowId)
                editBank.enabled = false
            }

            function cancelEdit() {
                console.log("cancelEdit")
                editBank.enabled = false
            }
        }
    }

    Keys.onPressed: {
        if (event.key == Qt.Key_Down && idTableBank.focus
                && idTableBank.currentRow == idTableBank.rowCount - 1) {
            console.log("NEW!!!")
            editBank.enabled = true
        }
    }
}
