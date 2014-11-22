/*
    tohkbd2-settings-u, The Otherhalf Keyboard 2 settings UI
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

Page
{
    id: page

    allowedOrientations: Orientation.Portrait | Orientation.Landscape | Orientation.LandscapeInverted

    SilicaFlickable
    {
        anchors.fill: parent
        VerticalScrollDecorator {}

        PullDownMenu
        {
            MenuItem
            {
                text: "Reset all to defaults"
                onClicked: settingsui.setShortcutsToDefault()
            }
        }

        contentHeight: column.height

        Column
        {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader
            {
                title: "Shortcuts"
            }

            Repeater
            {
                model: shortcutsModel
                ListItem
                {
                    id: shortcutItem

                    Label
                    {
                        id: keyName
                        anchors
                        {
                            left: parent.left
                            leftMargin: Theme.paddingMedium
                            verticalCenter: parent.verticalCenter
                        }
                        width: Theme.itemSizeExtraSmall
                        font.pixelSize: Theme.fontSizeMedium
                        font.bold: true
                        text: key
                        color: shortcutItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                    }

                    Image
                    {
                        id: appIcon
                        source: iconId
                        y: Math.round((parent.height - height) / 2)
                        property real size: Theme.iconSizeLauncher

                        sourceSize.width: size
                        sourceSize.height: size
                        width: size
                        height: size

                        anchors
                        {
                            left: keyName.right
                            leftMargin: Theme.paddingMedium
                            verticalCenter: parent.verticalCenter
                        }
                    }
                    Image
                    {
                        anchors
                        {
                            top: appIcon.top
                            right: appIcon.right
                            topMargin: -16
                            rightMargin: -16
                        }
                        visible: isAndroid
                        source: "image://theme/icon-s-android"
                    }
                    Label
                    {
                        anchors
                        {
                            left: appIcon.right
                            leftMargin: Theme.paddingLarge
//                            right: column.right
//                            rightMargin: Theme.paddingMedium
                            verticalCenter: parent.verticalCenter
                        }
                        color: shortcutItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                        font.pixelSize: Theme.fontSizeMedium
                        truncationMode: TruncationMode.Fade
                        text: name
                    }

                    height: Theme.itemSizeMedium

                    onClicked: pageStack.push(appSelector, {"keyId": key})
                }

            }

        }
    }

    Component
    {
        id: appSelector
        ApplicationSelectionPage
        {
            onSelected:
            {
                console.log(keyId + " = " + filePath)
                settingsui.setShortcut(keyId, filePath)
            }
        }
    }


}


