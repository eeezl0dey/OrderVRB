import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import "Basic"

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
            BaseTableView {
                id: idTableContr

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
                    title: qsTr("Наименование")
                    width: idTableContr.width - columnNum.width - columnAccount.width - creatorName.width - beneficiary.width
                    horizontalAlignment: Text.AlignHCenter
                }
                TableViewColumn {
                    id: columnAccount
                    role: "naccount"
                    title: qsTr("Счет")
                    width: 125
                    horizontalAlignment: Text.AlignHCenter
                }
                TableViewColumn {
                    id: creatorName
                    role: "creatorname"
                    title: qsTr("Создал")
                    width: 125
                    horizontalAlignment: Text.AlignHCenter
//                    delegate: Text { text: model.creatorname }
                }
                TableViewColumn {
                    id: beneficiary
                    role: "is_beneficiary"
                    title: qsTr("Получатель")
                    width: 100
                    horizontalAlignment: Text.AlignHCenter
                    delegate: Item {
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: {
                                if(styleData.value === 1)
                                    qsTr("Да");
                                else
                                    qsTr("Нет");
                            }

                            renderType: Text.NativeRendering
                            anchors.centerIn: parent
                        }
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
                        isBeneficiary = dataBase.modelKontr.getData(idTableContr.currentRow, 'is_beneficiary')
                    }
                    else{
                        contrName = ""
                        accNum = ""
                        bankIndex = 0
                        isBeneficiary = true
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
                var curRow = idTableContr.currentRow
                dataBase.modelKontr.acceptKontr(editcontragent.rowId, editcontragent.contrName, dataBase.modelBank.getData(editcontragent.bankIndex, 'idbank'), editcontragent.accNum, editcontragent.isBeneficiary)

                if(idTableContr.rowCount > 0 && curRow < idTableContr.rowCount)
                {
                    idTableContr.currentRow = curRow;
                    idTableContr.selection.select(curRow);
                }
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
