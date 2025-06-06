import QtQuick
import org.kde.kirigami 2 as Kirigami

Image {
    id: root
    source: "images/background.png"
    fillMode: Image.PreserveAspectCrop

    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
        }
    }
    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Image {
            id: logo
            property real size: units.gridUnit * 12
            anchors.centerIn: parent
            source: "images/plasma.svg"
            sourceSize.width: 200
            sourceSize.height: 200
            ParallelAnimation {
                running: true
                ScaleAnimator {
                    target: logo
                    from: 0
                    to: 1
                    duration: 700
                }
                SequentialAnimation {
                    loops: Animation.Infinite
                    OpacityAnimator {
                        target: logo
                        from: 0.75
                        to: 1
                        duration: 1200
                    }
                    OpacityAnimator {
                        target: logo
                        from: 1
                        to: 0.75
                        duration: 1200
                    }
                }
            }
        }
        Image {
            id: busyIndicator
            source: "images/loader.svg"
            anchors.centerIn: parent
            sourceSize.height: 250
            sourceSize.width: 250
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 2000
                loops: Animation.Infinite
            }
        }
    }
    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}
