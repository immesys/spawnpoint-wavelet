import QtQuick 2.4
import Material 0.3
import Material.ListItems 0.1
import Material.Extras 0.1
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.3
import BOSSWAVE 1.0
import WaveViewer 1.0

Item {
  property string sConfigFile
  property string sConfigFileShort

  Label {
    id: configDropLabel
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.margins: dp(20)
    anchors.horizontalCenter: configDrop.horizontalCenter
    font.family: "Roboto"
    font.pixelSize: dp(30)
    text: "Config File"
  }

  DropArea {
    id: configDrop
    anchors.left: parent.left
    anchors.top: configDropLabel.bottom
    anchors.leftMargin: dp(20)
    width: dp(300)
    height: dp(50)

    onDropped: function(dropEvent) {
      sConfigFile = dropEvent.text.substring("file://".length)
      sConfigFileShort = sConfigFile.substring(sConfigFile.lastIndexOf("/") + 1)
    }
  }

  Rectangle {
    id: configDropBorder
    anchors.left: configDrop.left
    anchors.top: configDrop.top
    width: configDrop.width
    height: configDrop.height
    border.width: dp(2)
    border.color: "#000000"
  }

  Label {
    anchors.horizontalCenter: configDrop.horizontalCenter
    anchors.top: configDrop.top
    anchors.margins: dp(5)
    font.pixelSize: dp(30)
    font.family: "Courier"
    text: sConfigFileShort
  }

  Label {
    id: spawnpointLabel
    anchors.left: configDropLabel.right
    anchors.top: parent.top
    anchors.leftMargin: dp(100)
    anchors.topMargin: dp(20)
    font.family: "Roboto"
    font.pixelSize: dp(30)
    text: "Target Spawnpoint"
    color: "black"
  }

  TextField {
    id: tSpawnpoint

    anchors.left: spawnpointLabel.left
    anchors.top: spawnpointLabel.bottom
    width: dp(500)
    height: dp(50)

    style: TextFieldStyle {
      textColor: "black"
      background: Rectangle {
        anchors.left: parent.left
        anchors.top: parent.top
        width: parent.width
        height: parent.height
        color: "#FFFFFF"
        border.color: "#000000"
        border.width: dp(2)
      }

      font.pixelSize: dp(26)
      font.family: "Courier"
    }
  }

  Button {
    id: bDeploy

    text: "Deploy"
    backgroundColor: "#4CAF50"
    width: dp(300)
    anchors.top: configDrop.bottom
    anchors.left: parent.left
    anchors.margins: dp(20)

    onClicked: console.log(tSpawnpoint.text)
  }

  Button {
    text: "Clear"
    backgroundColor: "#F44336"
    anchors.top: configDrop.bottom
    anchors.left: spawnpointLabel.left
    anchors.topMargin: dp(20)
    width: bDeploy.width
    height: bDeploy.height

    onClicked: function() {
      sConfigFile = ""
      sConfigFileShort = ""
      tSpawnpoint.text = ""
    }
  }
}
