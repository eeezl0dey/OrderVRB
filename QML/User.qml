import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import "Style"

SwipeScreen {
    id: winUser
    anchors.fill: parent

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
            TableView {
                id: idTableUser
                //                anchors.bottom: buttonAdd.top;
                //    //            anchors.bottomMargin: 45
                //                anchors.right: parent.right
                //                anchors.left: parent.left
                //                anchors.top: parent.top
                Layout.fillWidth: true
                Layout.fillHeight: true


                TableViewColumn {
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
                TableViewColumn {
                    id: columnUserName
                    role: "username"
                    title: "Логин"
                    width: 150
                    horizontalAlignment: Text.AlignHCenter
                }
                TableViewColumn {
                    id: columnFullname
                    role: "fullname"
                    title: "Полное Ф.И.О."
                    width: idTableUser.width - columnUsersNum.width - columnUserName.width - columnIsAdmin.width
                    horizontalAlignment: Text.AlignHCenter
                }
                TableViewColumn {
                    id: columnIsAdmin
                    role: "isadmin"
                    title: "Админ"
                    width: 70
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

                model: dataBase.modelUsers

                onActivated: {
                    editUser.enabled = true
                }
            }
            ColumnLayout {
                Layout.fillHeight: true
                Layout.preferredWidth: 150
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignTop
                Button {
                    id: buttonUserAdd
                    anchors.left: parent.left
                    anchors.right: parent.right
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
                Button {
                    id: buttonUserEdit
                    Layout.fillWidth: true
                    text: qsTr("Редактирование")
                    iconSource: "qrc:/Image/48/Document 2 Edit.png"
                    style: ProjectButtonStyle {
                    }
                    onClicked: {
                        editUser.isNew = false
                        editUser.enabled = true
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
                    winUser.deactivated()
                } else {
                    Layout.preferredHeight = 0
                    idTableUser.forceActiveFocus()
                    winUser.activated()
                }
            }

            function checkAccess() {
                console.log("checkAccess")
                dataBase.modelUsers.acceptUser(editUser.rowId, editUser.uname, editUser.upass, editUser.ufname, editUser.isadm)
                idTableUser.model = dataBase.modelUsers
                idTableUser.update()
                if(idTableUser.rowCount > 0)
                    idTableUser.selection.select(0);
                editUser.enabled = false
            }

            function cancelEdit() {
                console.log("cancelEdit")
                editUser.enabled = false
            }
        }
    }

    Keys.onPressed: {
        if (event.key == Qt.Key_Down && idTableUser.focus
                && idTableUser.currentRow == idTableUser.rowCount - 1) {
            console.log("NEW!!!")
            editUser.enabled = true
        }
    }
}
