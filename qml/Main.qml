import QtQuick
import QtQuick.Controls

ApplicationWindow {
    width: 800
    height: 500
    visible: true
    title: "My Qt App"

    Button {
        anchors.centerIn: parent
        text: "Hello Qt + Wayland"

        onClicked: {
            console.log("Hello!")
        }
    }
}