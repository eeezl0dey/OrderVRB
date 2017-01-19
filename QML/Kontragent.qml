import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import "Style"

SwipeScreen {
    id: winkontragent
    anchors.fill: parent

    WindowFone {
    }

    ColumnLayout {
        id: kontrItem
        anchors.fill: parent
        RowLayout {
            id: rowView
            Layout.fillHeight: true
            Layout.leftMargin: 5
            Layout.rightMargin: 5
            TableView {
                id: idTableContr
                Layout.fillWidth: true
                Layout.fillHeight: true

                TableViewColumn {
                    id: columnNum
                    role: "idcontragent"
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
                    id: columnFullname
                    role: "fname"
                    title: "Наименование"
                    width: idTableContr.width - columnNum.width - columnAccount.width - creatorName.width
                    horizontalAlignment: Text.AlignHCenter
                }
                TableViewColumn {
                    id: columnAccount
                    role: "naccount"
                    title: "Счет"
                    width: 150
                    horizontalAlignment: Text.AlignHCenter
                }
                TableViewColumn {
                    id: creatorName
                    role: "creatorname"
                    title: "Создал"
                    width: 150
                    horizontalAlignment: Text.AlignHCenter
//                    delegate: Text { text: model.creatorname }
                }

                headerDelegate: Rectangle {
//                    width: _textHeader.text.length * 1.2
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

                model: dataBase.modelKontr

                onActivated: {
                    editcontragent.isNew = false
                    editcontragent.enabled = true

                }
            }

            ColumnLayout {
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignTop
                Layout.preferredWidth: 150
                Layout.fillWidth: false
                Button {
                    id: buttonAdd
                    Layout.fillWidth: true
                    text: qsTr("Добавить")
                    tooltip: qsTr("Добавление нового контрагента в базу")
                    iconSource: "qrc:/Image/48/Document 2 Add.png"
                    style: ProjectButtonStyle {
                    }
                    onClicked: {
                        editcontragent.isNew = true
                        editcontragent.enabled = true
                    }
                }
                Button {
                    id: buttonEdit
                    Layout.fillWidth: true
                    text: qsTr("Редактирование")
                    iconSource: "qrc:/Image/48/Document 2 Edit.png"
                    style: ProjectButtonStyle {
                    }
                    onClicked: {
                        if(idTableContr.currentRow >= 0){
                            editcontragent.isNew = false
                            editcontragent.enabled = true
                        }
                    }
                }

            }
        }

        EditContragent {
            id: editcontragent
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
                    if(!isNew)
                    {
                        contrName = dataBase.modelKontr.getData(idTableContr.currentRow, 'fname')
                        accNum = dataBase.modelKontr.getData(idTableContr.currentRow, 'naccount')
                        bankIndex = bankComboBox.find(dataBase.modelKontr.getData(idTableContr.currentRow, 'bankname'))
                        rowId = dataBase.modelKontr.getData(idTableContr.currentRow, 'idcontragent')
                    }
                    else{
                        contrName = ""
                        accNum = ""
                        bankIndex = 0
                        rowId = ""
                    }

                    Layout.preferredHeight = 200
                    editcontragent.forceActiveFocus()
                    winkontragent.deactivated()
                } else {
                    Layout.preferredHeight = 0
                    idTableContr.forceActiveFocus()
                    winkontragent.activated()
                }
            }

            function checkAccess() {
                console.log("checkAccess")
                dataBase.modelKontr.acceptKontr(editcontragent.rowId, editcontragent.contrName, dataBase.modelBank.getData(editcontragent.bankIndex, 'idbank'), editcontragent.accNum)
                idTableContr.model = dataBase.modelKontr
                idTableContr.update()
                if(idTableContr.rowCount > 0)
                    idTableContr.selection.select(0);
                editcontragent.enabled = false
            }

            function cancelEdit() {
                console.log("cancelEdit")
                editcontragent.enabled = false
            }
        }
    }

    Keys.onPressed: {
        if (event.key == Qt.Key_Down && idTableContr.focus
                && idTableContr.currentRow == idTableContr.rowCount - 1) {
            console.log("NEW!!!")
            editcontragent.enabled = true
        }
    }
}
