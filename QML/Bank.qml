import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import "Basic"

SwipeScreen {
    id: winbank
    anchors.fill: parent

    WindowFone {
    }

    ColumnLayout {
        id: bankItem
        anchors.fill: parent
        RowLayout {
            id: rowViewBank
            Layout.fillHeight: true
            Layout.leftMargin: 5
            Layout.rightMargin: 5
            BaseTableView {
                id: idTableBank

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
                        editBank.isNew = true
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
                        if(idTableBank.currentRow >=0)
                        {
                            editBank.isNew = false
                            editBank.enabled = true
                        }
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
                rowViewBank.enabled = !enabled

                if (enabled) {
                    if(!isNew)
                    {
                        bname = dataBase.modelBank.getData(idTableBank.currentRow, 'name')
                        baddress = dataBase.modelBank.getData(idTableBank.currentRow, 'address')
                        rowId = dataBase.modelBank.getData(idTableBank.currentRow, 'idbank')
                    }
                    else{
                        bname = ""
                        baddress = ""
                        rowId = ""
                    }

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
                var curRow = idTableBank.currentRow
                dataBase.modelBank.acceptBank(editBank.rowId, editBank.bname, editBank.baddress)
                idTableBank.model = dataBase.modelBank
                idTableBank.update()
                if(idTableBank.rowCount > 0 && curRow < idTableBank.rowCount)
                {
                    idTableBank.currentRow = curRow;
                    idTableBank.selection.select(curRow);
                }
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
