import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

SwipeScreen{
    id: winkontragent
    anchors.fill: parent;
//    modality: Qt.ApplicationModal
//    title: qsTr("Контрагенты")

    WindowFone {
    }

    Item {
        id: kontrItem
        anchors.fill: parent
        TableView {
            id: idTable;
            anchors.bottom: buttonAdd.top;
//            anchors.bottomMargin: 45
            anchors.right: parent.right
            anchors.left: parent.left
            anchors.top: parent.top

            TableViewColumn {
                id: columnNum
                role: "idcontragent"
                title: "#"
                width: 50
                horizontalAlignment: Text.AlignHCenter
                delegate: Item{

                    Text{
                        anchors.verticalCenter: parent.verticalCenter
                        text: styleData.value
                        renderType: Text.NativeRendering
                        anchors.centerIn: parent
                    }
                }
            }
            TableViewColumn {
                id:columnFullname
                role: "fname"
                title: "Наименование"
                width: idTable.width - columnNum.width - columnInn.width - idusers.width
                horizontalAlignment: Text.AlignHCenter
            }
            TableViewColumn {
                id:columnInn
                role: "inn"
                title: "ИНН"
                width: 200
                horizontalAlignment: Text.AlignHCenter
            }
            TableViewColumn {
                id:idusers
                role: "idusers"
                title: "Создал"
                width: 200
                horizontalAlignment: Text.AlignHCenter
            }


            headerDelegate: Rectangle
            {
                width: _textHeader.text.length*1.2
                height: _textHeader.font.pixelSize*1.6
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

                border
                {
                    width: 1
                    color: (styleData.pressed)?"blue":"black"
                }

                Text
                {
                    id: _textHeader

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.centerIn: parent
                    renderType: Text.NativeRendering

                    font.bold: true
                    font.pointSize: 9

                    color: (styleData.pressed)?"blue":"black"
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
                }
            }

            model: dataBase.modelKontr
        }

        Button {
            id: buttonAdd
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.bottom: editcontragent.top;
            height: 25
            text: qsTr("Добавить")
            onClicked: {
                editcontragent.enabled = true;
            }
        }

        EditContragent{
            id:editcontragent
            enabled: false;
            anchors.left: parent.left;
            anchors.right: parent.right;
            anchors.bottom: parent.bottom;
            height: 0;
            Behavior on y {
                NumberAnimation {
                    duration: 300
                }
            }

            Behavior on height {
                NumberAnimation {
                    duration: 300
                }
            }

//            Behavior on visible {
//                NumberAnimation {
//                    duration: visible?0:500;
//                }
//            }

            onEnabledChanged: {
                idTable.enabled = !enabled;
                if(enabled){
                    buttonAdd.visible = false;
                    editcontragent.height = 200;
                    editcontragent.forceActiveFocus();
                }
                else{
                    editcontragent.height = 0;
                    buttonAdd.visible = true;
                }
            }


            function checkAccess(){
                console.log("checkAccess");
                dataBase.acceptKontr(editcontragent.rowId);
                editcontragent.enabled = false;
                idTable.enabled = true;
                idTable.forceActiveFocus();
            }

            function cancelEdit(){
                console.log("cancelEdit");
                editcontragent.enabled = false;
                idTable.enabled = true;
                idTable.forceActiveFocus();
            }
        }

    }

    Keys.onPressed: {
        if (event.key == Qt.Key_Down && idTable.focus && idTable.currentRow == idTable.rowCount - 1)
        {
            console.log("NEW!!!");
            editcontragent.enabled = true;
        }
    }

}

