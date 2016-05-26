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

  anchors.fill: parent

  Component.onCompleted : {
    console.log(x, y, width, height)
    console.log("appuri: ", WV.appURI());
    BW.subscribeMsgPack(WV.appURI()+"i.spawnpoint/signal/heartbeat",
      function(msg)
      {
        console.log(x, y, width, height)
        sAlias = msg["Alias"];
        sAvailableShares = msg["AvailableCpuShares"];
        sAvailableMem = msg["AvailableMem"];
        sLastTime = msg["Time"];
        sTotalShares = msg["TotalCpuShares"];
        sTotalMem = msg["TotalMem"];
        console.log("updated properties");
      },
      function(err)
      {
        if (err != "")
        {
          WV.fatal("could not subscribe: ",err);
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
          text: sAvailableShares +" / " + sTotalShares
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
  }
  GridView {
    anchors.fill : parent
    model:amodel
    //width:main.width
    //height:main.height
    anchors.margins: dp(36)
    //columnSpacing: dp(16)
    //rowSpacing: dp(16)
    cellWidth: dp(320)
    cellHeight: dp(170)

  }
}
