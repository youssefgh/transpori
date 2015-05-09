part of station;

class StationMarker extends Marker {
  StationMarker(num lat, num lng, Function syncLatLng) {
    position = new LatLng(lat, lng);
    draggable = true;
    onDragend.listen((e) => syncLatLng());
  }
}

class BusStationMarker extends StationMarker {
  BusStationMarker(num lat, num lng, Function syncLatLng) : super(lat, lng, syncLatLng) {
    Icon icon = new Icon()..url = "images/bus_station.png";
    this.icon = icon;
  }
}

class TrainStationMarker extends StationMarker {
  TrainStationMarker(num lat, num lng, Function syncLatLng) : super(lat, lng, syncLatLng) {
    Icon icon = new Icon()..url = "images/train_station.png";
    this.icon = icon;
  }
}

class TramwayStationMarker extends StationMarker {
  TramwayStationMarker(num lat, num lng, Function syncLatLng) : super(lat, lng, syncLatLng) {
    Icon icon = new Icon()
        ..url = "images/tramway_station.png"
        ..scaledSize = new Size(12, 12);
    this.icon = icon;
  }
}
