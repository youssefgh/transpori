import 'package:google_maps/google_maps.dart';
import 'map_point.dart';

class Station extends MapPoint {

  String id;
  Marker marker;
  
  static final List types = [{
      "id": "BUS_STATION",
      "type": "BusStation"
    }, {
      "id": "TRAIN_STATION",
      "type": "TrainStation"
    }, {
      "id": "TRAMWAY_STATION",
      "type": "TramwayStation"
    }];

  Station(num lat, num lng, [String id]): super(lat, lng) {
    this.id = id;
    marker = new Marker()
        ..position = new LatLng(lat, lng)
        ..draggable = true
        ..onDragend.listen((e) => syncLatLng());
  }

  factory Station.instanceFromMap(Map stationMap) {
    Station station;
    switch (stationMap["@type"]) {
      case "BusStation":
        station = new BusStation(stationMap["latitude"], stationMap["longitude"], stationMap["id"]);
        break;
      case "TrainStation":
        station = new TrainStation(stationMap["latitude"], stationMap["longitude"], stationMap["id"]);
        break;
      case "TramwayStation":
        station = new TramwayStation(stationMap["latitude"], stationMap["longitude"], stationMap["id"]);
        break;
    }
    return station;
  }
  
  void syncLatLng(){
    lat = marker.position.lat;
    lng = marker.position.lng;
  }

  void prepareForDelete() {
    hide();
  }
  
  void show(GMap map){
      marker.map = map;
  }
  
  void hide(){
    marker.map = null;
  }

  Map toJson() {
    Map json = new Map();
    json["@type"] = runtimeType.toString();
    if (id != null) json["id"] = id;
    json["latitude"] = lat;
    json["longitude"] = lng;
    return json;
  }

}

class BusStation extends Station {
  BusStation(num lat, num lng, [String id]): super(lat, lng, id) {
    Icon icon = new Icon();
    icon.url = "images/bus_station.png";
    //icon.size = new Size(22,22);
    marker.icon = icon;
  }
}

class TrainStation extends Station {
  TrainStation(num lat, num lng, [String id]): super(lat, lng, id) {
    Icon icon = new Icon();
    icon.url = "images/train_station.png";
    marker.icon = icon;
  }
}

class TramwayStation extends Station {
  TramwayStation(num lat, num lng, [String id]): super(lat, lng, id) {
    Icon icon = new Icon();
    icon.url = "images/tramway_station.png";
    icon.scaledSize = new Size(12,12);
    marker.icon = icon;
  }
}

class StationSuggestion extends Station {
  StationSuggestion (num lat, num lng, [String id]): super(lat, lng, id) {
      Icon icon = new Icon();
      //icon.size = new Size(22,22);
      marker.icon = icon;
    }
}

class BusStationSuggestion extends StationSuggestion {
  BusStationSuggestion(num lat, num lng, [String id]): super(lat, lng, id) {
    marker.icon.url = "images/bus_station.png";
  }
}

class TrainStationSuggestion extends StationSuggestion {
  TrainStationSuggestion(num lat, num lng, [String id]): super(lat, lng, id) {
    marker.icon.url = "images/train_station.png";
  }
}

class TramwayStationSuggestion extends StationSuggestion {
  TramwayStationSuggestion(num lat, num lng, [String id]): super(lat, lng, id) {
    marker.icon.url = "images/tramway_station.png";
  }
}
