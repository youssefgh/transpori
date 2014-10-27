part of webservice_client;

@Injectable()
class WSStationSuggestion extends WebserviceClient {

  WSStationSuggestion(SessionService service) : super(service);

  get webServiceUrl => super.rawWebServiceUrl + "StationSuggestion/";

  Future<String> create(Station station) {
    return HttpRequest.request(webServiceUrl, method: httpPut, requestHeaders: requestHeader, sendData: JSON.encode(station)).then((httpRequest) {
      return httpRequest.response;
    });
  }

  Future delete(Station station) {
    return HttpRequest.request(webServiceUrl + station.id, method: httpDelete, requestHeaders: requestHeader);
  }

}
