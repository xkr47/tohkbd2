/*
    tohkbd2-settings-u, The Otherhalf Keyboard 2 settings UI
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import "../components"

Page
{
    id: page

    KeyboardHandler
    {
        id: kbdif
        onKeyUpPressed: flick.flick(0, -1000)
        onKeyDownPressed: flick.flick(0, 1000)
        onKeyBackspacePressed: pageStack.pop()
    }

    SilicaFlickable
    {
        id: flick
        anchors.fill: parent

        contentHeight: column.height

        Column
        {
            id: column

            width: page.width

            PageHeader
            {
                title: qsTrId("help")
            }

            SectionHeader
            {
                //: Section header for list of key-combos
                //% "Key combinations"
                text: qsTrId("key-combinations")
            }

            Grid
            {
                id: keycomboGrid
                columns: (page.orientation === Orientation.Landscape || page.orientation === Orientation.InvertedLandscape) ? 2 : 1

                Repeater
                {
                    id: kcRepeater
                    model: keycomboModel

                    ListItem
                    {
                        id: kcItem
                        width: page.width / keycomboGrid.columns
                        height: Theme.itemSizeSmall
                        enabled: false

                        Label
                        {
                            id: key1Name
                            anchors.left: parent.left
                            anchors.leftMargin: Theme.paddingSmall
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: Theme.fontSizeSmall
                            font.bold: true
                            text: key1
                            color: Theme.primaryColor
                        }

                        Label
                        {
                            id: key2Name
                            anchors.left: key1Name.right
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: Theme.fontSizeSmall
                            font.bold: true
                            text: "+" + key2
                            color: Theme.primaryColor
                        }

                        Label
                        {
                            id: key3Name
                            anchors.left: key2Name.right
                            anchors.verticalCenter: parent.verticalCenter
                            font.pixelSize: Theme.fontSizeSmall
                            font.bold: true
                            text: "+" + key3
                            color: Theme.primaryColor
                            visible: key3.length > 0
                        }

                        Label
                        {
                            anchors.verticalCenter: parent.verticalCenter
                            x: kcItem.width/2
                            color: Theme.primaryColor
                            font.pixelSize: Theme.fontSizeMedium
                            truncationMode: TruncationMode.Fade
                            text: name
                        }
                    }
                }
            }

            Label
            {
                //: Description text saying there can be more combinations by the OS
                //% "This list is most propably not complete as the operating system/Qt can offer more key combinations."
                text: qsTrId("more-desc")
                x: Theme.paddingLarge
                wrapMode: Text.Wrap
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.secondaryColor
                width: parent.width - 2*Theme.paddingLarge
            }

            SectionHeader
            {
                text: qsTrId("shortcuts")
            }

            Grid
            {
                id: shortcutsGrid
                columns: (page.orientation === Orientation.Landscape || page.orientation === Orientation.InvertedLandscape) ? 2 : 1

                Repeater
                {
                    id: repeater
                    model: shortcutsModel

                    ListItem
                    {
                        id: shortcutItem
                        width: page.width / shortcutsGrid.columns
                        height: Theme.itemSizeSmall
                        enabled: false

                        Image
                        {
                            id: keyFrame
                            source: "image://tohkbd2/icon-m-keyframe"
                            anchors
                            {
                                left: parent.left
                                leftMargin: Theme.paddingMedium
                                verticalCenter: parent.verticalCenter
                            }
                            scale: 0.8

                            Label
                            {
                                id: keyName
                                anchors.centerIn: parent
                                font.pixelSize: Theme.fontSizeMedium
                                font.bold: true
                                text: key
                                color: Theme.primaryColor
                                scale: 0.85
                            }
                        }

                        Image
                        {
                            id: appIcon
                            source: iconId
                            y: Math.round((parent.height - height) / 2)
                            property real size: Theme.itemSizeSmall * 0.6

                            sourceSize.width: size
                            sourceSize.height: size
                            width: size
                            height: size

                            anchors
                            {
                                left: keyFrame.right
                                leftMargin: Theme.paddingMedium
                                verticalCenter: parent.verticalCenter
                            }
                        }
                        Image
                        {
                            anchors
                            {
                                left: appIcon.right
                                leftMargin: 3
                            }
                            visible: isAndroid
                            source: "image://theme/icon-s-android"
                            scale: 0.7
                        }
                        Label
                        {
                            anchors
                            {
                                left: appIcon.right
                                leftMargin: Theme.paddingLarge
                                verticalCenter: parent.verticalCenter
                            }
                            color: Theme.primaryColor
                            font.pixelSize: Theme.fontSizeMedium
                            truncationMode: TruncationMode.Fade
                            text: name
                        }
                    }
                }
            }
        }
    }
}