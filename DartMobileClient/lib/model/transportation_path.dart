part of model;

class TransportationPath {

  List<TransportationLine> transportationLines = new List();

  TransportationPath.fromMap(Map transportationPathMap) {
    for (Map transportationLineMap in transportationPathMap["transportationLines"]) {
      transportationLines.add(new TransportationLine.instanceFromMap(transportationLineMap));
    }
  }

  num length() {
    int length = 0;
    for (TransportationLine transportationLine in transportationLines) {
      length += transportationLine.mapPoints.length;
    }
    return length;
  }

  String avgInTransportationDistanceInKM() {
    double avgInTransportationDistanceInKM = (avgInTransportationDistance() / 1000);
    return avgInTransportationDistanceInKM.toString().substring(0, avgInTransportationDistanceInKM.toString().indexOf(".") + 2);
  }

  double avgInTransportationDistance() {
    double avgInTransportationDistance = 0.0;
    for (TransportationLine transportationLine in transportationLines) {
      avgInTransportationDistance += transportationLine.traveledDistance();
    }
    return avgInTransportationDistance * 1.5;
  }

  double avgOutTransportationDistance(MapPoint originalPosition, MapPoint destination) {
    double avgOutTransportationDistance = 0.0;
    avgOutTransportationDistance += originalPosition.distanceTo(transportationLines.first.mapPoints.first);
    for (int i = 0; i < transportationLines.length - 1; i++) {
      avgOutTransportationDistance += transportationLines[i].mapPoints.last.distanceTo(transportationLines[i + 1].mapPoints.first);
    }
    avgOutTransportationDistance += transportationLines.last.mapPoints.last.distanceTo(destination);
    return avgOutTransportationDistance * 1.5;
  }

}
