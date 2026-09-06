import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: root

    width: 1200
    height: 720

    minimumWidth: 900
    minimumHeight: 560

    visible: true
    title: "Music Player"

    color: "transparent"

    // ============================================================
    // THEME
    // ============================================================

    property color windowColor: "#CC17131F"
    property color topBarColor: "#D91B1127"
    property color panelColor: "#B5161420"

    property color selectedColor: "#7A33283A"
    property color hoverColor: "#421F1C27"

    property color textMain: "#E9E4EA"
    property color textSecondary: "#AAA2AE"
    property color textMuted: "#776F7B"

    property color accentColor: "#F1A331"

    property color borderColor: "#392C39"
    property color dividerColor: "#322734"

    property int detailsWidth: 320
    property int playerHeight: 62
    property int topBarHeight: 38

    property int selectedIndex: -1

    // ============================================================
    // WINDOW
    // ============================================================

    Rectangle {
        id: frame

        anchors.fill: parent

        radius: 4

        color: root.windowColor

        border.width: 1
        border.color: root.borderColor

        clip: true

        // ========================================================
        // TOP BAR
        // ========================================================

        Rectangle {
            id: topBar

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right

            height: root.topBarHeight

            color: root.topBarColor

            RowLayout {
                anchors.fill: parent

                spacing: 0

                // Menu button
                Rectangle {
                    Layout.preferredWidth: 48
                    Layout.fillHeight: true

                    color: menuMouse.containsMouse
                           ? "#3A313C"
                           : "transparent"

                    Text {
                        anchors.centerIn: parent

                        text: "☰"

                        color: root.textSecondary

                        font.pixelSize: 15
                    }

                    MouseArea {
                        id: menuMouse

                        anchors.fill: parent

                        hoverEnabled: true
                    }
                }

                Rectangle {
                    width: 1
                    Layout.fillHeight: true
                    color: root.borderColor
                }

                // Tabs
                Rectangle {
                    Layout.preferredWidth: 110
                    Layout.fillHeight: true

                    color: "#713A3D"

                    Text {
                        anchors.centerIn: parent

                        text: "Default"

                        color: root.textMain

                        font.pixelSize: 12
                        font.bold: true
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 145
                    Layout.fillHeight: true

                    color: "transparent"

                    Text {
                        anchors.centerIn: parent

                        text: "MEEPLEDGDON"

                        color: root.textMain

                        font.pixelSize: 12
                        font.bold: true
                    }
                }

                Rectangle {
                    Layout.preferredWidth: 80
                    Layout.fillHeight: true

                    color: "transparent"

                    Text {
                        anchors.centerIn: parent

                        text: "MENU"

                        color: root.textMuted

                        font.pixelSize: 12
                    }
                }

                Item {
                    Layout.fillWidth: true
                }

                // Activity / visualizer
                Rectangle {
                    Layout.preferredWidth: 96
                    Layout.preferredHeight: 18

                    color: "#241C28"

                    border.width: 1
                    border.color: "#473441"

                    Row {
                        anchors.centerIn: parent

                        spacing: 2

                        Repeater {
                            model: 16

                            Rectangle {
                                width: 5
                                height: 6 + ((index * 13) % 10)

                                color: index < 10
                                       ? root.accentColor
                                       : "#5D7E34"
                            }
                        }
                    }
                }

                Item {
                    width: 14
                }

                Text {
                    text: "—"

                    color: root.textMuted

                    font.pixelSize: 15
                }

                Item {
                    width: 10
                }

                Text {
                    text: "□"

                    color: root.textMuted

                    font.pixelSize: 13
                }

                Item {
                    width: 10
                }

                Text {
                    text: "×"

                    color: root.textMuted

                    font.pixelSize: 17

                    rightPadding: 12
                }
            }
        }

        // ========================================================
        // MAIN CONTENT
        // ========================================================

        RowLayout {
            id: mainContent

            anchors.top: topBar.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: playerBar.top

            spacing: 0

            // ====================================================
            // LIBRARY
            // ====================================================

            Rectangle {
                id: libraryPanel

                Layout.fillWidth: true
                Layout.fillHeight: true

                color: root.panelColor

                // ----------------------------
                // TABLE HEADER
                // ----------------------------

                Rectangle {
                    id: tableHeader

                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.right: parent.right

                    height: 38

                    color: "#421C1922"

                    border.color: root.dividerColor
                    border.width: 1

                    Row {
                        anchors.fill: parent

                        anchors.leftMargin: 14
                        anchors.rightMargin: 10

                        spacing: 0

                        Text {
                            width: 190
                            anchors.verticalCenter: parent.verticalCenter

                            text: "Artist"

                            color: root.textMain

                            font.pixelSize: 13
                            font.bold: true
                        }

                        Text {
                            width: 195
                            anchors.verticalCenter: parent.verticalCenter

                            text: "Title"

                            color: root.textMain

                            font.pixelSize: 13
                            font.bold: true
                        }

                        Text {
                            width: 165
                            anchors.verticalCenter: parent.verticalCenter

                            text: "Album"

                            color: root.textMain

                            font.pixelSize: 13
                            font.bold: true
                        }

                        Text {
                            width: 70
                            anchors.verticalCenter: parent.verticalCenter

                            text: "Date"

                            color: root.textMain

                            font.pixelSize: 13
                            font.bold: true
                        }

                        Text {
                            width: 70
                            anchors.verticalCenter: parent.verticalCenter

                            text: "Codec"

                            color: root.textMain

                            font.pixelSize: 13
                            font.bold: true
                        }

                        Text {
                            width: 60
                            anchors.verticalCenter: parent.verticalCenter

                            text: "Time"

                            color: root.textMain

                            font.pixelSize: 13
                            font.bold: true
                        }
                    }
                }

                // ----------------------------
                // SONG LIST
                // ----------------------------

                ListView {
                    id: songList

                    anchors.top: tableHeader.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom

                    model: songModel

                    clip: true

                    spacing: 0

                    currentIndex: root.selectedIndex

                    delegate: Rectangle {
                        id: row

                        width: songList.width
                        height: 36

                        color: index === root.selectedIndex
                               ? root.selectedColor
                               : rowMouse.containsMouse
                                 ? root.hoverColor
                                 : "transparent"

                        Behavior on color {
                            ColorAnimation {
                                duration: 80
                            }
                        }

                        // Selected indicator
                        Rectangle {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom

                            width: index === root.selectedIndex ? 3 : 0

                            color: root.accentColor
                        }

                        Row {
                            anchors.fill: parent

                            anchors.leftMargin: 14
                            anchors.rightMargin: 10

                            spacing: 0

                            Text {
                                width: 190

                                anchors.verticalCenter: parent.verticalCenter

                                text: artist

                                color: index === root.selectedIndex
                                       ? root.accentColor
                                       : root.textSecondary

                                font.pixelSize: 13

                                elide: Text.ElideRight
                            }

                            Text {
                                width: 195

                                anchors.verticalCenter: parent.verticalCenter

                                text: title

                                color: index === root.selectedIndex
                                       ? root.accentColor
                                       : root.textMain

                                font.pixelSize: 13

                                elide: Text.ElideRight
                            }

                            Text {
                                width: 165

                                anchors.verticalCenter: parent.verticalCenter

                                text: album

                                color: index === root.selectedIndex
                                       ? root.accentColor
                                       : root.textSecondary

                                font.pixelSize: 13

                                elide: Text.ElideRight
                            }

                            Text {
                                width: 70

                                anchors.verticalCenter: parent.verticalCenter

                                text: "2025"

                                color: root.textMuted

                                font.pixelSize: 13

                                elide: Text.ElideRight
                            }

                            Text {
                                width: 70

                                anchors.verticalCenter: parent.verticalCenter

                                text: "MP3"

                                color: root.textSecondary

                                font.pixelSize: 13
                            }

                            Text {
                                width: 60

                                anchors.verticalCenter: parent.verticalCenter

                                text: duration

                                color: root.textSecondary

                                font.pixelSize: 13
                            }
                        }

                        Rectangle {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom

                            height: 1

                            color: root.dividerColor
                        }

                        MouseArea {
                            id: rowMouse

                            anchors.fill: parent

                            hoverEnabled: true

                            onClicked: {
                                root.selectedIndex = index
                                songList.currentIndex = index
                            }
                        }
                    }

                    ScrollBar.vertical: ScrollBar {
                        id: scrollBar

                        policy: ScrollBar.AsNeeded

                        width: 6

                        contentItem: Rectangle {
                            implicitWidth: 6

                            radius: 3

                            color: root.textMuted

                            opacity: 0.45
                        }

                        background: null
                    }
                }
            }

            // ====================================================
            // SPLITTER
            // ====================================================

            Rectangle {
                id: splitter

                Layout.preferredWidth: 2
                Layout.fillHeight: true

                color: root.dividerColor
            }

            // ====================================================
            // DETAILS PANEL
            // ====================================================

            Rectangle {
                id: detailsPanel

                Layout.preferredWidth: root.detailsWidth
                Layout.fillHeight: true

                color: "#9A191520"

                // Album art
                Rectangle {
                    id: albumArt

                    anchors.top: parent.top
                    anchors.topMargin: 34

                    anchors.horizontalCenter: parent.horizontalCenter

                    width: Math.min(
                               detailsPanel.width - 48,
                               detailsPanel.height * 0.56
                               )

                    height: width

                    color: "#09A7DC"

                    border.width: 1
                    border.color: "#5B6482"

                    // Decorative artwork
                    Rectangle {
                        anchors.centerIn: parent

                        width: parent.width * 0.58
                        height: parent.height * 0.58

                        radius: width / 2

                        color: "#1937A8"

                        border.width: 2
                        border.color: "#D6F2FF"

                        opacity: 0.9

                        Rectangle {
                            anchors.centerIn: parent

                            width: parent.width * 0.62
                            height: parent.height * 0.76

                            radius: width / 2

                            color: "#7D55E8"

                            border.width: 2
                            border.color: "#BFF2FF"

                            opacity: 0.8
                        }
                    }

                    Text {
                        anchors.centerIn: parent

                        text: "♫"

                        color: "#D9FFFF"

                        opacity: 0.72

                        font.pixelSize: 42
                        font.bold: true
                    }
                }

                // Track information
                Column {
                    anchors.top: albumArt.bottom
                    anchors.topMargin: 24

                    anchors.left: parent.left
                    anchors.right: parent.right

                    spacing: 6

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter

                        text: root.selectedIndex >= 0
                              ? songModel.data(
                                    songModel.index(root.selectedIndex, 0),
                                    258)
                              : "No Artist"

                        color: root.textSecondary

                        font.pixelSize: 14
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter

                        text: root.selectedIndex >= 0
                              ? songModel.data(
                                    songModel.index(root.selectedIndex, 0),
                                    257)
                              : "Select a song"

                        color: root.textMain

                        font.pixelSize: 22

                        font.bold: true

                        elide: Text.ElideRight

                        width: parent.width - 30

                        horizontalAlignment: Text.AlignHCenter
                    }

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter

                        text: root.selectedIndex >= 0
                              ? "Album • 2025-02-28"
                              : "Album • Date"

                        color: root.textSecondary

                        font.pixelSize: 13
                    }
                }
            }
        }

        // ========================================================
        // PLAYER
        // ========================================================

        Rectangle {
            id: playerBar

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom

            height: root.playerHeight

            color: "#C01A1622"

            border.color: root.borderColor
            border.width: 1

            // Progress
            Rectangle {
                anchors.top: parent.top
                anchors.left: parent.left

                width: parent.width * 0.31
                height: 3

                color: root.accentColor
            }

            RowLayout {
                anchors.fill: parent

                anchors.leftMargin: 18
                anchors.rightMargin: 16

                spacing: 16

                // Play
                Text {
                    text: "▶"

                    color: root.textMain

                    font.pixelSize: 18

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                // Pause
                Text {
                    text: "Ⅱ"

                    color: root.textMuted

                    font.pixelSize: 17

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                // Stop
                Text {
                    text: "■"

                    color: root.textMuted

                    font.pixelSize: 15

                    MouseArea {
                        anchors.fill: parent
                    }
                }

                Item {
                    width: 14
                }

                // Previous
                Text {
                    text: "◀◀"

                    color: root.textMuted

                    font.pixelSize: 13
                }

                // Next
                Text {
                    text: "▶▶"

                    color: root.textMuted

                    font.pixelSize: 13
                }

                Item {
                    Layout.fillWidth: true
                }

                // Repeat
                Text {
                    text: "↶"

                    color: root.textMuted

                    font.pixelSize: 20
                }

                // Shuffle
                Text {
                    text: "⇄"

                    color: root.textMuted

                    font.pixelSize: 20
                }

                // Playlist
                Text {
                    text: "☷"

                    color: root.textMuted

                    font.pixelSize: 20
                }

                // Volume
                Text {
                    text: "▰"

                    color: root.textMuted

                    font.pixelSize: 12
                }

                Rectangle {
                    Layout.preferredWidth: 100
                    Layout.preferredHeight: 5

                    radius: 2

                    color: "#35313A"

                    Rectangle {
                        width: parent.width * 0.55
                        height: parent.height

                        radius: 2

                        color: root.textSecondary
                    }
                }

                Text {
                    text: "00:04"

                    color: root.accentColor

                    font.pixelSize: 12
                    font.bold: true

                    Layout.preferredWidth: 40
                }
            }
        }
    }
}