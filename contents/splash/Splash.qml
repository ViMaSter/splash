import QtQuick 2.15

Item {
    id: root

    property int stage: 0
    property real xOffset: root.width * -0.0889
    property real yOffset: root.height * 0.0659
    property real containerHeight: root.yOffset * 2
    
    property real barStartX: root.width / 2 + root.xOffset - 0.5
    property real barEndX: root.width / 2 - root.xOffset - 0.5
    property real barTravelDistance: Math.abs(root.barEndX - root.barStartX)

    onStageChanged: {
        if (stage === 5) {
            exitSequence.running = true
        }
    }

    // Top row: 1, 2, 3 (33.3% each)
    Rectangle {
        id: bg1
        anchors.top: parent.top
        anchors.left: parent.left
        width: parent.width / 3
        height: root.height / 2 - root.yOffset
        color: "#FF2a2b2d"
    }

    Rectangle {
        id: bg2
        anchors.top: parent.top
        anchors.left: bg1.right
        width: parent.width / 3
        height: root.height / 2 - root.yOffset
        color: "#FF2a2b2d"
    }

    Rectangle {
        id: bg3
        anchors.top: parent.top
        anchors.left: bg2.right
        anchors.right: parent.right
        height: root.height / 2 - root.yOffset
        color: "#FF2a2b2d"
    }

    // Middle row: 4, 5, 6
    Rectangle {
        id: bg4
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        width: bg5.x
        height: root.containerHeight
        color: "#FF2a2b2d"
    }

    Rectangle {
        id: bg5
        anchors.verticalCenter: parent.verticalCenter
        x: root.barStartX
        width: 1
        height: root.containerHeight
        color: "transparent"
    }

    Rectangle {
        id: bg6
        anchors.verticalCenter: parent.verticalCenter
        x: bg5.x + bg5.width
        width: root.width - (bg5.x + bg5.width)
        height: root.containerHeight
        color: "#FF2a2b2d"
    }

    // Bottom row: 7, 8, 9 (33.3% each)
    Rectangle {
        id: bg7
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        width: parent.width / 3
        height: root.height / 2 - root.yOffset
        color: "#FF2a2b2d"
    }

    Rectangle {
        id: bg8
        anchors.bottom: parent.bottom
        anchors.left: bg7.right
        width: parent.width / 3
        height: root.height / 2 - root.yOffset
        color: "#FF2a2b2d"
    }

    Rectangle {
        id: bg9
        anchors.bottom: parent.bottom
        anchors.left: bg8.right
        anchors.right: parent.right
        height: root.height / 2 - root.yOffset
        color: "#FF2a2b2d"
    }

    Item {
        id: lineContainer
        width: 1
        height: root.containerHeight
        x: root.width / 2 + root.xOffset - width / 2
        anchors.verticalCenter: parent.verticalCenter
        clip: true

        Rectangle {
            anchors.fill: parent
            color: "#7f8082"
        }

        Rectangle {
            id: loader
            width: parent.width
            height: parent.height * 0.75
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: "#00e27a2d" }
                GradientStop { position: 0.5; color: "#ffe27a2d" }
                GradientStop { position: 1.0; color: "#00e27a2d" }
            }
            y: -height

            SequentialAnimation on y {
                loops: Animation.Infinite
                running: true

                NumberAnimation {
                    from: lineContainer.height
                    to: -loader.height
                    duration: 1200
                    easing.type: Easing.OutQuad
                }
            }
        }
    }

    SequentialAnimation {
        id: exitSequence
        running: false

        ParallelAnimation {
            NumberAnimation {
                target: lineContainer
                property: "x"
                to: root.barEndX
                duration: 400
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: lineContainer
                property: "opacity"
                to: 0
                duration: 400
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg5
                property: "width"
                to: root.barTravelDistance + 1
                duration: 400
                easing.type: Easing.OutExpo
            }
        }

        ParallelAnimation {
            NumberAnimation {
                target: bg5
                property: "x"
                to: root.barStartX + root.barTravelDistance / 2 - root.width / 2
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg5
                property: "width"
                to: root.width
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: lineContainer
                property: "height"
                to: root.height
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg1
                property: "y"
                to: -(root.height / 2 - root.yOffset)
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg1
                property: "height"
                to: 0
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg2
                property: "y"
                to: -(root.height / 2 - root.yOffset)
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg2
                property: "height"
                to: 0
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg3
                property: "y"
                to: -(root.height / 2 - root.yOffset)
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg3
                property: "height"
                to: 0
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg4
                property: "height"
                to: root.height
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg5
                property: "height"
                to: root.height
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg6
                property: "height"
                to: root.height
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg7
                property: "y"
                to: root.height
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg7
                property: "height"
                to: 0
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg8
                property: "y"
                to: root.height
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg8
                property: "height"
                to: 0
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg9
                property: "y"
                to: root.height
                duration: 300
                easing.type: Easing.OutExpo
            }

            NumberAnimation {
                target: bg9
                property: "height"
                to: 0
                duration: 300
                easing.type: Easing.OutExpo
            }
        }

        ParallelAnimation {
            NumberAnimation {
                target: lineContainer
                property: "opacity"
                to: 0
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }
    }
}
