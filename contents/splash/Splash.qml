import QtQuick 2.15

Item {
    id: root

    property int stage: 0
    property real xOffset: root.width * -0.0889
    property real yOffset: root.height * 0.0659
    property real containerHeight: root.yOffset * 2

    onStageChanged: {
        if (stage === 5) {
            backgroundFadeOut.running = true
        }
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#FF2a2b2d"
    }

    Item {
        id: lineContainer
        width: 1
        height: root.containerHeight
        x: root.width / 2 + root.xOffset - width / 2
        y: root.height / 2 - root.yOffset
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

    NumberAnimation {
        id: backgroundFadeOut
        running: false
        target: background
        property: "opacity"
        from: 1
        to: 0
        duration: 300
        easing.type: Easing.InOutQuad
        onFinished: {
            barsFadeOut.running = true
        }
    }

    NumberAnimation {
        id: barsFadeOut
        running: false
        target: lineContainer
        property: "opacity"
        from: 1
        to: 0
        duration: 250
        easing.type: Easing.InOutQuad
    }
}
