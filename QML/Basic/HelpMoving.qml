import QtQuick 2.5
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.1

GroupBox{
    id: root
    checkable: false
    flat: true
    title: qsTr("Редактирование формы:")
    property int fontSize: 8

    ColumnLayout{
        Label{
            text: qsTr("Однократный щелчек мышкой на бланке")
            color: "gray"
            font.pointSize: fontSize
        }
        Label{
            text: qsTr("Удержание Ctrl - горизонтальные размеры (прокрутка колесика) + перемещение")
            color: "gray"
            font.pointSize: fontSize
        }
        Label{
            text: qsTr("Удержание Shift - вертикальные размеры (прокрутка колесика) + перемещение")
            color: "gray"
            font.pointSize: fontSize
        }
    }

}
