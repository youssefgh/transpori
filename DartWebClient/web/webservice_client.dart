import 'dart:html';
import 'dart:async';
import 'dart:convert';
import 'dart:collection';
import 'transportation_line.dart';
import 'station.dart';
import 'transportation_request.dart';
import 'transportation_path.dart';
import 'user.dart';

class WebserviceClient {

  //String webServiceUrl = "http://tmorocco-mdeveloper.rhcloud.com/rest/";
  final String webServiceUrl = "http://localhost:8080/rest/";
  final String httpPut = "PUT";
  final String httpGet = "GET";
  final String httpPost = "POST";
  final String httpDelete = "DELETE";
  final Map requestHeader = {
    "content-type": "application/json"
  };

}

class TransportationLineWS extends WebserviceClient {

  String webServiceUrl;

  void init() {
    webServiceUrl = super.webServiceUrl + "TransportationLine/";
  }

  TransportationLineWS() {
    init();
  }

  TransportationLineWS.withUser(User user) {
    init();
    requestHeader["authorization"] = user.getAuthorizationString();
  }

  Future<String> create(TransportationLine transportationLine) {
    return HttpRequest.request(webServiceUrl, method: httpPut, requestHeaders: requestHeader, sendData: transportationLine.toJson().toString()).then((httpRequest) {
      return httpRequest.response;
    });
  }

  Future<TransportationLine> read(TransportationLine transportationLine) {
    return HttpRequest.request(webServiceUrl + transportationLine.id, method: httpGet, requestHeaders: requestHeader).then((response) {
      Map transportationLineMap = JSON.decode(response.response);
      return new TransportationLine.instanceFromMap(transportationLineMap);
    });
  }
  //TODO export parse logic
  Future<List<TransportationLine>> readAll() {
    return HttpRequest.request(webServiceUrl, method: httpGet, requestHeaders: requestHeader).then((response) {
      List<LinkedHashMap> transportationLineMaps = JSON.decode(response.response);
      List<TransportationLine> transportationLines = new List();
      for (int i = 0; i < transportationLineMaps.length; i++) {
        transportationLines.add(new TransportationLine.instanceFromMap(transportationLineMaps.elementAt(i)));
      }
      return transportationLines;
    });
  }

  Future update(TransportationLine transportationLine) {
    return HttpRequest.request(webServiceUrl, method: httpPost, requestHeaders: requestHeader, sendData: transportationLine.toJson().toString());
  }

}

class StationWS extends WebserviceClient {

  String webServiceUrl;

  void init() {
    webServiceUrl = super.webServiceUrl + "Station/";
  }

  StationWS() {
    init();
  }

  StationWS.withUser(User user) {
    init();
    requestHeader["authorization"] = user.getAuthorizationString();
  }

  Future<String> create(Station station) {
    return HttpRequest.request(webServiceUrl, method: httpPut, requestHeaders: requestHeader, sendData: JSON.encode(station)).then((httpRequest) {
      return httpRequest.response;
    });
  }

  Future<List<Station>> readAll() {
    return HttpRequest.request(webServiceUrl, method: httpGet, requestHeaders: requestHeader).then((response) {
      List<Map> stationMaps = JSON.decode(response.response);
      //TODO export parse logic
      List<Station> stations = new List();
      Station station;
      for (Map stationMap in stationMaps) {
        stations.add(new Station.instanceFromMap(stationMap));
      }
      return stations;
    });
  }

  Future update(Station station) {
    return HttpRequest.request(webServiceUrl, method: httpPost, requestHeaders: requestHeader, sendData: JSON.encode(station));
  }

  Future delete(Station station) {
    return HttpRequest.request(webServiceUrl + station.id, method: httpDelete, requestHeaders: requestHeader);
  }
}

class StationSuggestionWS extends WebserviceClient {

  String webServiceUrl;

  void init() {
    webServiceUrl = super.webServiceUrl + "StationSuggestion/";
  }

  StationSuggestionWS() {
    init();
  }

  StationSuggestionWS.withUser(User user) {
    init();
    requestHeader["authorization"] = user.getAuthorizationString();
  }

  Future<String> create(Station station) {
    return HttpRequest.request(webServiceUrl, method: httpPut, requestHeaders: requestHeader, sendData: JSON.encode(station)).then((httpRequest) {
      return httpRequest.response;
    });
  }

  Future delete(Station station) {
    return HttpRequest.request(webServiceUrl + station.id, method: httpDelete, requestHeaders: requestHeader);
  }
}

class TransportationRequestWS extends WebserviceClient {

  String webServiceUrl;

  TransportationRequestWS() {
    webServiceUrl = super.webServiceUrl + "TransportationResponse/";
  }

  //TODO find alternative
  //using POST for JAX-RS GET limits
  //TODO export parse logic
  Future<List<TransportationPath>> update(TransportationRequest transportationRequest) {
    return HttpRequest.request(webServiceUrl, method: httpPost, requestHeaders: requestHeader, sendData: transportationRequest.toJson().toString()).then((httpRequest) {
      Map transportationResponseMap = JSON.decode(httpRequest.response);
      List transportationPathsMap = transportationResponseMap["transportationPaths"];
      List<TransportationPath> transportationPaths = new List();
      for (Map transportationPathMap in transportationPathsMap) {
        transportationPaths.add(new TransportationPath.fromMap(transportationPathMap));
      }
      return transportationPaths;
    });
  }
}

class UserWS extends WebserviceClient {

  String webServiceUrl;

  UserWS() {
    webServiceUrl = super.webServiceUrl + "User/";
  }

  Future create(User user) {
    print(user.toJson());
    print(JSON.encode(user));
    return HttpRequest.request(webServiceUrl, method: httpPut, requestHeaders: requestHeader, sendData: JSON.encode(user));
  }

  Future<User> read(User user) {
    return HttpRequest.request(webServiceUrl + user.email + "/" + user.password).then((httpRequest) {
      Map userMap = JSON.decode(httpRequest.response);
      return new User.instanceFromMap(userMap);
    });
    /*
    return HttpRequest.getString(webServiceUrl + id).then((response) {
      Map transportationLineMap = JSON.decode(response);
      return new TransportationLine.instanceFromMap(transportationLineMap);
    });*/
  }
}
