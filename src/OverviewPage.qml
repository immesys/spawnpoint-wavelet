import QtQuick 2.4
import Material 0.3
import Material.ListItems 0.1
import Material.Extras 0.1
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.3
import BOSSWAVE 1.0
import WaveViewer 1.0

Item {
  id : main

  property string sAlias
  property int sAvailableShares
  property int sAvailableMem
  property real sLastTime
  property int sTotalShares
  property int sTotalMem
  property int sNumSvcs

  anchors.fill: parent

  Component.onCompleted : {
    BW.subscribeMsgPack({"URI": WV.appURI() + "i.spawnpoint/signal/heartbeat", "AutoChain": true},
      function(poNum, msg) {
        sAlias = msg["Alias"];
        sAvailableShares = msg["AvailableCPUShares"];
        sAvailableMem = msg["AvailableMem"];
        sLastTime = msg["Time"];
        sTotalShares = msg["TotalCPUShares"];
        sTotalMem = msg["TotalMem"];
      },
      function(err, handle) {
        if (err != "") {
          WV.fatal("could not subscribe: ", err);
        }
      });
  }

  VisualItemModel {
    id: amodel
    View {
      elevation: 1
      width: dp(300)
      height: dp(150)
      Label {
          font.family: "Roboto"
          font.weight: Font.Light
          text: "Alias"
          font.pixelSize: dp(24)
          anchors {
              left: parent.left
              top: parent.top
              margins: dp(16)
          }
      }
      Label {
          font.family: "Roboto"
          text: sAlias
          font.pixelSize: dp(34)
          anchors {
              left: parent.left
              bottom: parent.bottom
              margins: dp(16)
          }
      }
    }

    View {
      elevation: 1
      width: dp(300)
      height: dp(150)
      Label {
          font.family: "Roboto"
          font.weight: Font.Light
          text: "Free CPU Shares"
          font.pixelSize: dp(24)
          anchors {
              left: parent.left
              top: parent.top
              margins: dp(16)
          }
      }

      Label {
          font.family: "Roboto"
          text: sAvailableShares + " / " + sTotalShares
          font.pixelSize: dp(34)
          anchors {
              left: parent.left
              bottom: parent.bottom
              margins: dp(16)
          }
      }
    }

    View {
      elevation: 1
      width: dp(300)
      height: dp(150)

      Label {
          font.family: "Roboto"
          font.weight: Font.Light
          text: "Free Memory (MB)"
          font.pixelSize: dp(24)
          anchors {
              left: parent.left
              top: parent.top
              margins: dp(16)
          }
      }

      Label {
          font.family: "Roboto"
          text: sAvailableMem + " / " + sTotalMem
          font.pixelSize: dp(34)
          anchors {
              left: parent.left
              bottom: parent.bottom
              margins: dp(16)
          }
      }
    }

    View {
      elevation: 1
      width: dp(300)
      height: dp(150)

      Label {
          font.family: "Roboto"
          font.weight: Font.Light
          text: "Num. Services"
          font.pixelSize: dp(24)
          anchors {
              left: parent.left
              top: parent.top
              margins: dp(16)
          }
      }

      Label {
          font.family: "Roboto"
          text: sNumSvcs
          font.pixelSize: dp(34)
          anchors {
              left: parent.left
              bottom: parent.bottom
              margins: dp(16)
          }
      }
    }

  }

  GridView {
    anchors.fill: parent
    model: amodel
    anchors.margins: dp(36)
    cellWidth: dp(320)
    cellHeight: dp(170)

  }
}
