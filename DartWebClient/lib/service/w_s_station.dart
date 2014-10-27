part of webservice_client;

@Injectable()
class WSStation extends WebserviceClient {
  
  WSStation(SessionService service) : super(service);

  get webServiceUrl => super.rawWebServiceUrl + "Station/";

  Future<String> create(Station station) {
    return HttpRequest.request(webServiceUrl, method: httpPut, requestHeaders: requestHeader, sendData: JSON.encode(station)).then((httpRequest) {
      return httpRequest.response;
    });
  }

  Future<List<Station>> readAll() {
    return HttpRequest.request(webServiceUrl, method: httpGet, requestHeaders: requestHeader).then((response) {
      List<Map> stationMaps = JSON.decode(response.response);
      List<Station> stations = new List();
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
