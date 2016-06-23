import QtQuick 2.4
import Material 0.3
import Material.ListItems 0.1
import Material.Extras 0.1
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.4
import BOSSWAVE 1.0
import WaveViewer 1.0

Item {
  property var svcModel

  id : main
  Text {
    id: title
    text: "Running Services"
    font.pointSize: 24; font.bold: true
    anchors.left: parent.left
    anchors.leftMargin: dp(30)
    anchors.top: parent.top
    anchors.topMargin: dp(30)
  }

  Component {
    id: serviceDelegate

    View {
      elevation: 1
      anchors.left: parent.left
      anchors.right: parent.right
      height: dp(120)

      Label {
        id: nameLabel
        font.family: "Roboto"
        font.pixelSize: dp(34)
        font.weight: Font.Bold
        text: Name
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: dp(16)
      }

      Label {
        id: cpuLabel
        font.family: "Roboto"
        font.pixelSize: dp(27)
        text: "CPU: " + CpuShares + " Shares"
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: dp(16)
      }

      Label {
        id: memLabel
        font.family: "Roboto"
        font.pixelSize: dp(27)
        text: "Memory: " + MemAlloc + " MB"
        anchors.top: cpuLabel.bottom
        anchors.right: parent.right
        anchors.margins: dp(16)
      }

      Label {
        id: ageLabel
        font.family: "Roboto"
        font.pixelSize: dp(22)
        font.weight: Font.Light
        text: "Last seen " + Age
        anchors.top: nameLabel.bottom
        anchors.left: parent.left
        anchors.bottom: memLabel.bottom
        anchors.margins: dp(16)
      }

      Button {
        id: restartButton
        text: "Restart Service"
        backgroundColor: "#4CAF50"
        width: dp(200)
        anchors.top: parent.top
        anchors.left: nameLabel.right
        anchors.margins: dp(16)
        anchors.leftMargin: dp(45)
        anchors.topMargin: dp(25)

        onClicked: function() {
          var restartUri = WV.appURI() + "/i.spawnpoint/slot/restart"
          BW.publishText(restartUri, Name,
            function(err) {
              if (err != "") {
                WV.fatal("could not publish restart command: ", err)
              }
            }
          )
        }
      }

      Button {
        text: "Stop Service"
        backgroundColor: "#F44336"
        width: dp(200)
        anchors.top: parent.top
        anchors.left: restartButton.right
        anchors.margins: dp(16)
        anchors.leftMargin: dp(25)
        anchors.topMargin: dp(25)

        onClicked: function() {
          var stopUri = WV.appURI() + "/i.spawnpoint/slot/stop"
          BW.publishText(stopUri, Name,
            function(err) {
              if (err != "") {
                WV.fatal("could not publish stop command: ", err)
              }
            }
          )
        }
      }
    }
  }

  ListView {
    anchors.top: title.bottom
    anchors.bottom: parent.bottom
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.topMargin: dp(5)
    anchors.leftMargin: dp(30)
    anchors.rightMargin: dp(30)
    anchors.bottomMargin: dp(30)
    model: svcModel
    delegate: serviceDelegate
  }
}
