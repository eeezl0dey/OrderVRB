import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Styles 1.3

ButtonStyle {
    id:projectButtonStyle
    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 25
        border.width: control.activeFocus ? 2 : 1
        border.color: "#888"
        radius: 4
        gradient: Gradient {
            GradientStop { position: 0 ; color: control.pressed ? "#ccc" : "#eee" }
            GradientStop { position: 1 ; color: control.pressed ? "#aaa" : "#ccc" }
        }
    }
    label: Component{
            id:labelCompoent
            Row{
//                                                       anchors.left: parent.left
//                                                       anchors.leftMargin: (parent.width - (text.width + image.width))/2
//                                                       anchors.top: parent.top
//                                                       anchors.topMargin: 5
                spacing: 4
                Image{ id:image ;
                    source: control.iconSource;
                    sourceSize.width: 24
                    sourceSize.height: 24
                }
                Label{
                    id:text
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    horizontalAlignment:Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    text: control.text
                    font.pixelSize: 13
                }
            }
    }

}
