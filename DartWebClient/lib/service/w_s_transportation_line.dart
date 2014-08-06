part of webservice_client;

class WSTransportationLine extends WebserviceClient {

  WSTransportationLine(User user) : super(user);

  get webServiceUrl => super.rawWebServiceUrl + "TransportationLine/";

  Future<String> create(TransportationLine transportationLine) {
    return HttpRequest.request(webServiceUrl, method: httpPut, requestHeaders: requestHeader, sendData: JSON.encode(transportationLine)).then((httpRequest) {
      return httpRequest.response;
    });
  }

  Future<TransportationLine> read(TransportationLine transportationLine) {
    return HttpRequest.request(webServiceUrl + transportationLine.id, method: httpGet, requestHeaders: requestHeader).then((response) {
      Map transportationLineMap = JSON.decode(response.response);
      return new TransportationLine.instanceFromMap(transportationLineMap);
    });
  }

  Future<List<TransportationLine>> readAll() {
    return HttpRequest.request(webServiceUrl, method: httpGet, requestHeaders: requestHeader).then((response) {
      List transportationLineMaps = JSON.decode(response.response);
      List<TransportationLine> transportationLines = new List();
      transportationLineMaps.forEach((transportationLineMap) {
        transportationLines.add(new TransportationLine.instanceFromMap(transportationLineMap));
      });
      return transportationLines;
    });
  }

  Future update(TransportationLine transportationLine) {
    return HttpRequest.request(webServiceUrl, method: httpPost, requestHeaders: requestHeader, sendData: JSON.encode(transportationLine));
  }

  Future delete(TransportationLine transportationLine) {
    return HttpRequest.request(webServiceUrl + transportationLine.id, method: httpDelete, requestHeaders: requestHeader);
  }

}
