import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0

Window{
    id: winkontragent
    width: 800
    height: 400
    visible: true
    x: Screen.width / 2 - width / 2
    y: Screen.height / 2 - height / 2

    LinearGradient {
           anchors.fill: parent
           start: Qt.point(0, 0)
           end: Qt.point(parent.height, parent.width)
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
    }

    Item {
        id: kontrItem
        anchors.fill: parent
        TableView {
            id: idTable;
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 45
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
                    color: (styleData.pressed)?"red":"black"
                }

                Text
                {
                    id: _textHeader

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.centerIn: parent
                    renderType: Text.NativeRendering

                    font.bold: true
                    font.pointSize: 9

                    color: (styleData.pressed)?"red":"black"
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
            x: 41
            y: 355
            width: 118
            height: 25
            text: qsTr("Добавить")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 14
        }
    }
}

