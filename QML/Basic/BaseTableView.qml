import QtQuick 2.10
import QtQuick.Controls 1.4
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

TableView {
    id: idTable
    Layout.fillWidth: true
    Layout.fillHeight: true

    FontLoader { id: localFont; source: "qrc:/Font/Vharial.ttf" }

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
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            renderType: Text.NativeRendering
            color: styleData.textColor
            text: styleData.value
            elide: styleData.elideMode
//            wrapMode: Text.WordWrap
            font { family: localFont.name; pixelSize: 14; capitalization: Font.MixedCase }
//            FontCustomVientamis
        }
    }

//    rowDelegate: Rectangle{

//    }

//    rowDelegate: Rectangle{

//    }


//                model: dataBase.modelBank

//    onActivated: {
//        baseEdit.enabled = true
//    }
}
