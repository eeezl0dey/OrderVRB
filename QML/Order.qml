import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls 1.4 as Controls14
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import "Basic"

Page {
    id: winorder
    title: qsTr("Ордера")

    WindowFone {
    }

    ColumnLayout {
        id: orderItem
        spacing: 5
        anchors.fill: parent
        RowLayout {
            id: rowViewOrder
            Layout.fillHeight: true
            Layout.leftMargin: 5
            Layout.rightMargin: 5

            BaseTableView {
                id: idTableOrder

                //                anchors.bottom: buttonAdd.top;
                //    //            anchors.bottomMargin: 45
                //                anchors.right: parent.right
                //                anchors.left: parent.left
                //                anchors.top: parent.top
                Controls14.TableViewColumn {
                    id: columnOrderNum
                    role: "idorder"
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
                Controls14.TableViewColumn {
                    id: columnContragentName
                    role: "ncontragent"
                    title: qsTr("Контрагент")
                    width: idTableOrder.width - columnOrderNum.width
                           - columnOrderSumm.width - columnOrderCreator.width
                    horizontalAlignment: Text.AlignHCenter
                }
                Controls14.TableViewColumn {
                    id: columnOrderSumm
                    role: "summ"
                    title: qsTr("Сумма")
                    width: 200
                    horizontalAlignment: Text.AlignHCenter
                }
                Controls14.TableViewColumn {
                    id: columnOrderCreator
                    role: "creatorname"
                    title: qsTr("Создал")
                    width: 150
                    horizontalAlignment: Text.AlignHCenter
                }

                model: dataBase.modelOrder
            }
            ColumnLayout {
                Layout.fillHeight: true
                Layout.preferredWidth: 150
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignTop
                Controls14.Button {
                    id: buttonOrderAdd
                    Layout.fillWidth: true
                    text: qsTr("Добавить")
                    iconSource: "qrc:/Image/48/Document 2 Add.png"
                    style: ProjectButtonStyle {
                    }
                    onClicked: {
                        editOrder.isNew = true
                        editOrder.enabled = true
                    }
                }
                Controls14.Button {
                    id: buttonOrderPrint
                    Layout.fillWidth: true
                    text: qsTr("Печать")
                    iconSource: "qrc:/Image/48/Document 2 Edit.png"
                    style: ProjectButtonStyle {
                    }
                    onClicked: {
                        if (idTableOrder.currentRow >= 0) {
                            editOrder.isNew = false
                            editOrder.enabled = true
                        }
                    }
                }
            }
        }
        ///TODO
        EditOrder {
            id: editOrder
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
                rowViewOrder.enabled = !enabled

                if (enabled) {
                    if (!isNew) {
                        rowId = dataBase.modelOrder.getData(
                                    idTableOrder.currentRow, 'idorder')
                        aSumm = dataBase.modelOrder.getData(
                                    idTableOrder.currentRow, 'summ')
                        aDescription = dataBase.modelOrder.getData(
                                    idTableOrder.currentRow, 'comment')

                        var beneficiaryId = dataBase.modelOrder.getData(
                                    idTableOrder.currentRow, 'idbeneficiary')
                        var beneficiaryText = dataBase.modelKontr.getDataFromKey(
                                    beneficiaryId, 'idcontragent', 'fname')
                        aBeneficiaryCombo.currentIndex = aBeneficiaryCombo.find(
                                    beneficiaryText)

                        var contragentId = dataBase.modelOrder.getData(
                                    idTableOrder.currentRow, 'idcontragent')
                        var contragentText = dataBase.modelKontr.getDataFromKey(
                                    contragentId, 'idcontragent', 'fname')
                        aContragentCombo.currentIndex = aContragentCombo.find(
                                    contragentText)
                    } else {
                        aSumm = ""
                        //                        aSummText = ""
                        aTextCurrency = "VND"
                        aDescription = ""
                        //                        aBeneficiaryIndex = 0
                        //                        aContragentIndex = 0
                    }
                    //                    rowViewOrder.visible = false
                    Layout.preferredHeight = orderItem.height
                    rowViewOrder.visible = false
                    editOrder.forceActiveFocus()
                } else {
                    Layout.preferredHeight = 0
                    idTableOrder.forceActiveFocus()
                    //обновим данные модели
                    dataBase.modelOrder
                }
            }

            function checkAccess() {
                aOrder.printOrder()

                printChoose.visible = true

                console.log("checkAccess")
                var curRow = idTableOrder.currentRow
                //                dataBase.modelBank.acceptBank(editBank.rowId, editBank.bname, editBank.baddress)
                var beneficiaryId = dataBase.modelKontr.getDataFromKey(
                            editOrder.aBeneficiaryText, 'fname', 'idcontragent')
                var contragentId = dataBase.modelKontr.getDataFromKey(
                            editOrder.aContragentText, 'fname', 'idcontragent')
                dataBase.modelOrder.acceptOrder(editOrder.rowId, contragentId,
                                                editOrder.aSumm,
                                                editOrder.aDescription, 0,
                                                beneficiaryId)

                if (idTableOrder.rowCount > 0
                        && curRow < idTableOrder.rowCount) {
                    idTableOrder.currentRow = curRow
                    idTableOrder.selection.select(curRow)
                }
                editOrder.enabled = false
                rowViewOrder.visible = true
            }

            function cancelEdit() {
                console.log("cancelEdit")
                editOrder.enabled = false
                rowViewOrder.visible = true
            }
        }
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Down && idTableOrder.focus
                && idTableOrder.currentRow === idTableOrder.rowCount - 1) {
            console.log("NEW!!!")
            editOrder.enabled = true
        }
    }
}
