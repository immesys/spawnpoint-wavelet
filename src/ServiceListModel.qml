import QtQuick 2.4
import Material 0.3
import Material.ListItems 0.1
import Material.Extras 0.1
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import BOSSWAVE 1.0
import WaveViewer 1.0

import "moment.js" as Moment

ListModel {
  property var currentServices: ({})

  property var cleanup: Timer {
    interval: 2500
    running: true
    repeat: true
    onTriggered: function() {
      var now = Moment.moment()
      var newServices = {}
      Object.keys(currentServices).forEach(function(name) {
        var svcTime = Moment.moment(currentServices[name]["Time"] / 1.0e6)
        var secondsElapsed = now.diff(svcTime, 'seconds')
        if (secondsElapsed < 10) {
          newServices[name] = currentServices[name]
          newServices[name]["Age"] = svcTime.fromNow()
        }
      });
      currentServices = newServices

      clear()
      Object.keys(currentServices).forEach(function(name) {
        append(currentServices[name])
      });
      console.log(count)
    }
  }

  Component.onCompleted: {
    var hbUri = WV.appURI().slice(0, WV.appURI().length - "/server".length) + "+/i.spawnable/signal/heartbeat"
    BW.subscribeMsgPack(hbUri,
      function(msg) {
        currentServices[msg["Name"]] = msg
      },
      function(err) {
        if (err != "") {
          WV.fatal("could not subscribe: ", err)
        }
      });
  }
}
