import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls 1.4 as Controls14
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import "Basic"

Page {
    id: winUser
    title: qsTr("Пользователи")

    WindowFone {
    }

    ColumnLayout {
        id: userItem
        anchors.fill: parent
        RowLayout {
            id: rowViewUser
            Layout.fillHeight: true
            Layout.leftMargin: 5
            Layout.rightMargin: 5
            BaseTableView {
                id: idTableUser
                //                anchors.bottom: buttonAdd.top;
                //    //            anchors.bottomMargin: 45
                //                anchors.right: parent.right
                //                anchors.left: parent.left
                //                anchors.top: parent.top
                Layout.fillWidth: true
                Layout.fillHeight: true


                Controls14.TableViewColumn {
                    id: columnUsersNum
                    role: "idusers"
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
                    id: columnUserName
                    role: "username"
                    title: qsTr("Логин")
                    width: 150
                    horizontalAlignment: Text.AlignHCenter
                }
                Controls14.TableViewColumn {
                    id: columnFullname
                    role: "fullname"
                    title: qsTr("Полное Ф.И.О.")
                    width: idTableUser.width - columnUsersNum.width - columnUserName.width - columnIsAdmin.width
                    horizontalAlignment: Text.AlignHCenter
                }
                Controls14.TableViewColumn {
                    id: columnIsAdmin
                    role: "isadmin"
                    title: qsTr("Админ")
                    width: 70
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

                model: dataBase.modelUsers

            }
            ColumnLayout {
                Layout.fillHeight: true
                Layout.preferredWidth: 150
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignTop
                Controls14.Button {
                    id: buttonUserAdd
                    Layout.fillWidth: true
                    text: qsTr("Добавить")
                    iconSource: "qrc:/Image/48/Document 2 Add.png"
                    style: ProjectButtonStyle {
                    }
                    onClicked: {
                        editUser.isNew = true
                        editUser.enabled = true
                    }
                }
                Controls14.Button {
                    id: buttonUserEdit
                    Layout.fillWidth: true
                    text: qsTr("Редактирование")
                    iconSource: "qrc:/Image/48/Document 2 Edit.png"
                    style: ProjectButtonStyle {
                    }
                    onClicked: {
                        if(idTableUser.currentRow >= 0){
                            editUser.isNew = false
                            editUser.enabled = true
                        }
                    }
                }

            }
        }

        EditUser {
            id: editUser
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
                rowViewUser.enabled = !enabled



                if (enabled) {

                    if(!isNew)
                    {
                        rowId = dataBase.modelUsers.getData(idTableUser.currentRow, 'idusers')
                        uname = dataBase.modelUsers.getData(idTableUser.currentRow, 'username')
                        upass = dataBase.modelUsers.getData(idTableUser.currentRow, 'userpass')
                        ufname = dataBase.modelUsers.getData(idTableUser.currentRow, 'fullname')
                        isadm = dataBase.modelUsers.getData(idTableUser.currentRow, 'isadmin')
                    }
                    else{
                        uname = ""
                        upass = ""
                        ufname = ""
                        isadm = false
                        rowId = ""
                    }

                    Layout.preferredHeight = 200
                    editUser.forceActiveFocus()
                } else {
                    Layout.preferredHeight = 0
                    idTableUser.forceActiveFocus()
                    //обновим данные модели
                    dataBase.modelUsers
                }
            }

            function checkAccess() {
                console.log("checkAccess")
                var curRow = idTableUser
                dataBase.modelUsers.acceptUser(editUser.rowId, editUser.uname, editUser.upass, editUser.ufname, editUser.isadm)
                if(idTableUser.rowCount > 0 && curRow < idTableUser.rowCount)
                {
                    idTableUser.currentRow = curRow;
                    idTableUser.selection.select(curRow);
                }
                editUser.enabled = false
            }

            function cancelEdit() {
                console.log("cancelEdit")
                editUser.enabled = false
            }
        }
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Down && idTableUser.focus
                && idTableUser.currentRow == idTableUser.rowCount - 1) {
            console.log("NEW!!!")
            editUser.enabled = true
        }
    }
}
