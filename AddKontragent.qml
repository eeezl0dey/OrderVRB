import QtQuick 2.1
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0
import QtQuick.Dialogs 1.0

ApplicationWindow {
    title: qsTr("SSH Key Generator")
    modality: "WindowModal"

    statusBar: StatusBar {
    RowLayout {
        Label {
            id: status
            }
        }
    }

    width: 369
    height: 166

    ColumnLayout {
        x: 10
        y: 10

        // Key type
        RowLayout {
            Label {
                text: qsTr("Key type:")
            }
            ComboBox {
                id: combobox
                editable: true
                Layout.fillWidth: true
//                model: keygen.types
                currentIndex: 2
                onEditTextChanged: {

                }
            }
        }

        // Filename
        RowLayout {
            Label {
                text: qsTr("Filename:")
            }
            TextField {
                id: filename
                implicitWidth: 200
                onTextChanged: updateStatusBar()
            }
            Button {
                text: qsTr("&Browse...")
                onClicked: filedialog.visible = true
            }
        }

        // Passphrase
        RowLayout {
            Label {
                text: qsTr("Pass phrase:")
            }
            TextField {
                id: passphrase
                Layout.fillWidth: true
                echoMode: TextInput.Password
                onTextChanged: updateStatusBar()
            }

        }

        // Confirm Passphrase
        RowLayout {
            Label {
                text: qsTr("Confirm pass phrase:")
            }
            TextField {
                id: confirm
                Layout.fillWidth: true
                echoMode: TextInput.Password
                onTextChanged: updateStatusBar()
            }
        }

        // Buttons: Generate, Quit
        RowLayout {
            Button {
                id: generate
                text: qsTr("&Generate")
                onClicked: keygen.generateKey()
            }
            Button {
                text: qsTr("&Quit")
                onClicked: Qt.quit()
            }
        }

    }


}
