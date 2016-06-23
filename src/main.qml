import QtQuick 2.4
import Material 0.3
import Material.ListItems 0.1
import Material.Extras 0.1
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1

WaveletWindow {
  theme {
      primaryColor: "#03A9F4"
      accentColor: "#8BC34A"
      tabHighlightColor: "#DCEDC8"
  }

  ServiceListModel {
    id: serviceListModel
  }

  initialPage : TabbedPage {
    title : "Spawnpoint Control"

    Tab {
      title : "Overview"

      OverviewPage {
        anchors.fill: parent
        sNumSvcs: serviceListModel.count
      }
    }

    Tab {
      title : "Services"

      ServicePage {
        anchors.fill: parent
        svcModel: serviceListModel
      }
    }
  }
}
