part of station;

class StationSuggestion extends Station {
  StationSuggestion(num lat, num lng, [String id]) : super(lat, lng, id);
}

class BusStationSuggestion extends StationSuggestion {
  BusStationSuggestion(num lat, num lng, [String id]) : super(lat, lng, id) {
    stationMarker = new BusStationMarker(lat, lng, syncLatLng);
  }
}

class TrainStationSuggestion extends StationSuggestion {
  TrainStationSuggestion(num lat, num lng, [String id]) : super(lat, lng, id) {
    stationMarker = new TrainStationMarker(lat, lng, syncLatLng);
  }
}

class TramwayStationSuggestion extends StationSuggestion {
  TramwayStationSuggestion(num lat, num lng, [String id]) : super(lat, lng, id) {
    stationMarker = new TramwayStationMarker(lat, lng, syncLatLng);
  }
}
