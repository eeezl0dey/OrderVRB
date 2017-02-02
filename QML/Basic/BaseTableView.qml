import QtQuick 2.4
import QtQuick.Controls 1.3
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

TableView {
    id: idTable
    Layout.fillWidth: true
    Layout.fillHeight: true

//                TableViewColumn {
//                    id: columnBankNum
//                    role: "idbank"
//                    title: "#"
//                    width: 50
//                    horizontalAlignment: Text.AlignHCenter
//                    delegate: Item {
//                        Text {
//                            anchors.verticalCenter: parent.verticalCenter
//                            text: styleData.value
//                            renderType: Text.NativeRendering
//                            anchors.centerIn: parent
//                        }
//                    }
//                }
//                TableViewColumn {
//                    id: columnBankName
//                    role: "name"
//                    title: "Наименование"
//                    width: 200
//                    horizontalAlignment: Text.AlignHCenter
//                }
//                TableViewColumn {
//                    id: columnAddress
//                    role: "address"
//                    title: "Адрес"
//                    width: idTableBank.width - columnBankNum.width - columnBankName.width - columnBankUser.width
//                    horizontalAlignment: Text.AlignHCenter
//                }
//                TableViewColumn {
//                    id: columnBankUser
//                    role: "creatorname"
//                    title: "Создал"
//                    width: 150
//                    horizontalAlignment: Text.AlignHCenter
//                }

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
        }

//        width: 1
        color: (styleData.pressed) ? "blue" : "black"
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

//                model: dataBase.modelBank

//    onActivated: {
//        baseEdit.enabled = true
//    }
}
