import QtQuick 2.6
import Qt.labs.settings 1.0
import QtQuick.Controls 2.1
import QtQml.Models 2.2
//import QtQuick.Layouts 1.1
//import QtQuick.Controls.Styles 1.4

ComboBox{
    id: comboInput

    property string settinsCategory: "null_category"
    property int moveMode: 0
    property bool borderEnable: true

    Settings {
        category: settinsCategory
        property alias textX: comboInput.x
        property alias textY: comboInput.y
        property alias textWidth: comboInput.width
        property alias textHeihgt: comboInput.height
    }

    FontLoader { id: localFont; source: "qrc:/Font/Vharial.ttf" }

    font { family: localFont.name; pixelSize: 14; capitalization: Font.MixedCase; bold: true}

    background: Rectangle{
      visible: borderEnable
      id: rectCategory
      border.width: 1
      border.color: "blue";
      color: "transparent"
    }


    delegate: ItemDelegate {
              width: comboInput.width
              contentItem: Text {
                  text: fname
                  font: comboInput.font
                  elide: Text.ElideRight
                  verticalAlignment: Text.AlignVCenter
                  renderType: Text.NativeRendering
              }
              highlighted: comboInput.highlightedIndex == index
          }

    indicator: Canvas {
        id: canvas
        x: comboInput.width - width// - comboInput.rightPadding
        y: comboInput.topPadding + (comboInput.availableHeight - height) / 2
        width: 12
        height: 8
        contextType: "2d"

        Connections {
            target: comboInput
            onPressedChanged: canvas.requestPaint()
        }

        onPaint: {
            context.reset();
            context.moveTo(0, 0);
            context.lineTo(width, 0);
            context.lineTo(width / 2, height);
            context.closePath();
            context.fillStyle = comboInput.pressed ? "darkBlue" : "blue";
            context.fill();
        }

    }

    contentItem: Text {
              id: textInput
              leftPadding: 0
              rightPadding: comboInput.indicator.width + comboInput.spacing

              text: comboInput.displayText
              font: comboInput.font
//              color: comboInput.pressed ? "darkBlue" : "blue"
              horizontalAlignment: Text.AlignLeft
              verticalAlignment: Text.AlignVCenter
              renderType: Text.NativeRendering
//              onTextChanged: {
//                  comboInput.popup.open()
//              }

//              elide: Text.ElideRight
    }


//    onCurrentIndexChanged:  {
//        textInput.text = currentText
//    }

    MouseArea {
        id: mouseArea
        enabled: moveMode
        anchors.fill: parent


        drag.target: comboInput

        onWheel:
        {
            if(moveMode & 1)
            {
                if (wheel.angleDelta.y > 0)
                {
                    comboInput.width++;
                }
                else
                {
                    comboInput.width--;
                }
            }
            if(moveMode & 2)
            {
                if (wheel.angleDelta.y > 0)
                {
                    comboInput.height++;
                }
                else
                {
                    comboInput.height--;
                }
            }
            wheel.accepted=true
        }

//                onReleased: parent = tile.Drag.target !== null ? tile.Drag.target : rootComp


    }
}
