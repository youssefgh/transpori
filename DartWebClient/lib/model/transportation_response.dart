part of model;

class TransportationResponse {

  List<TransportationPath> transportationPaths = new List();

  TransportationResponse.fromMap(Map transportationResponseMap) {
    List transportationPathsMap = transportationResponseMap["transportationPaths"];
    for (Map transportationPathMap in transportationPathsMap) {
      transportationPaths.add(new TransportationPath.fromMap(transportationPathMap));
    }
  }

}
