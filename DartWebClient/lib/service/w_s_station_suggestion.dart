part of webservice_client;

class WSStationSuggestion extends WebserviceClient {

  String webServiceUrl;

  void init() {
    webServiceUrl = super.webServiceUrl + "StationSuggestion/";
  }

  WSStationSuggestion() {
    init();
  }

  WSStationSuggestion.withUser(User user) {
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
