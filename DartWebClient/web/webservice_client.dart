import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'package:google_maps/google_maps.dart';
import 'transportation_line.dart';
import 'station.dart';
import 'transportation_request.dart';
import 'transportation_path.dart';

class WebserviceClient {

  //String webServiceUrl = "http://tmorocco-mdeveloper.rhcloud.com/rest/";
  String webServiceUrl = "http://localhost:8080/rest/";

}

class TransportationLineWS extends WebserviceClient {

  void put(TransportationLine transportationLine) {
    HttpRequest httpRequest = new HttpRequest()
        ..open("PUT", webServiceUrl + "TransportationLine/")
        ..setRequestHeader('content-type', 'application/json')
        ..send(transportationLine.toJson().toString());
  }

  Future<TransportationLine> get(String id, GMap map) {
    return HttpRequest.getString(webServiceUrl + "TransportationLine/" + id).then((response) {
      if (id != "") {
        Map transportationLineMap = JSON.decode(response);
        return new TransportationLine.instanceFromMap(transportationLineMap, map);
      }
      List<LinkedHashMap> transportationLineMaps = JSON.decode(response);
      List<TransportationLine> transportationLines = new List();
      for (int i = 0; i < transportationLineMaps.length; i++) {
        transportationLines.add(new TransportationLine.instanceFromMap(transportationLineMaps.elementAt(i), map));
      }
      return transportationLines;
    });
  }

  void post(TransportationLine transportationLine) {
    HttpRequest httpRequest = new HttpRequest()
        ..open("POST", webServiceUrl + "TransportationLine/" + transportationLine.id)
        ..setRequestHeader('content-type', 'application/json')
        ..send(transportationLine.toJson().toString());
  }


}

class StationWS extends WebserviceClient {

  Future<List<Station>> get(GMap map) {
    return HttpRequest.getString(webServiceUrl + "Station/").then((response) {
      List<Map> stationMaps = JSON.decode(response);
      List<Station> stations = new List();
      Station station;
      for (Map stationMap in stationMaps) {
        switch (stationMap["@type"]) {
          case "BusStation":
            station = new BusStation(stationMap["latitude"], stationMap["longitude"], map, stationMap["id"]);
            break;
          case "TrainStation":
            station = new TrainStation(stationMap["latitude"], stationMap["longitude"], map, stationMap["id"]);
            break;
          case "TramwayStation":
            station = new TramwayStation(stationMap["latitude"], stationMap["longitude"], map, stationMap["id"]);
            break;
        }
        stations.add(station);
      }
      return stations;
    });
  }

  void post(Station station) {
    HttpRequest httpRequest = new HttpRequest()
        ..open("POST", webServiceUrl + "Station")
        ..setRequestHeader('content-type', 'application/json')
        ..send(JSON.encode(station));
  }

  void delete(Station station) {
    HttpRequest httpRequest = new HttpRequest()
        ..open("DELETE", webServiceUrl + "Station/" + station.id)
        ..setRequestHeader('content-type', 'application/json')
        ..send();
  }
}

class TransportationRequestWS extends WebserviceClient {
  void post(TransportationRequest transportationRequest, GMap map, Function callback) {
    HttpRequest httpRequest = new HttpRequest()
        ..open("POST", webServiceUrl + "TransportationResponse")
        ..setRequestHeader('content-type', 'application/json')
        ..send(transportationRequest.toJson().toString());
    httpRequest.onLoad.listen((e) {
      Map transportationResponseMap = JSON.decode(httpRequest.response);
      List transportationPathsMap = transportationResponseMap["transportationPaths"];
      List<TransportationPath> transportationPaths = new List();
      for (Map transportationPathMap in transportationPathsMap) {
        transportationPaths.add(new TransportationPath.fromMap(transportationPathMap, map));
      }
      callback(transportationPaths);
    });
  }
}
