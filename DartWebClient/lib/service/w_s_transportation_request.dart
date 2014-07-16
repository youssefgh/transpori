part of webservice_client;

class WSTransportationRequest extends WebserviceClient {

  String webServiceUrl;

  WSTransportationRequest() {
    webServiceUrl = super.webServiceUrl + "TransportationResponse/";
  }

  Future<List<TransportationPath>> update(TransportationRequest transportationRequest) {
    return HttpRequest.request(webServiceUrl, method: httpPost, requestHeaders: requestHeader, sendData: JSON.encode(transportationRequest)).then((httpRequest) {
      Map transportationResponseMap = JSON.decode(httpRequest.response);
      return new TransportationResponse.fromMap(transportationResponseMap).transportationPaths;
    });
  }

}
