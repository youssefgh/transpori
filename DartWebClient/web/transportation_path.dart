import 'package:google_maps/google_maps.dart';
import 'custom_map.dart';
import 'transportation_line.dart';
import 'station.dart';
import 'map_point.dart';

class TransportationPath {

  List<TransportationLine> transportationLines = new List();

  TransportationPath.fromMap(Map transportationPathMap) {
    //List transportationLinesMap = transportationPathMap["transportationLineas"];
    for (Map transportationLineMap in transportationPathMap["transportationLines"]) {
      transportationLines.add(new TransportationLine.instanceFromMap(transportationLineMap));
    }
  }

  show(CustomMap map) {
    for (TransportationLine transportationLine in transportationLines) {
      transportationLine.show(map);
      //TODO Review for alt solution
      transportationLine.showStations();
    }
  }

  hide() {
    for (TransportationLine transportationLine in transportationLines) {
      transportationLine.hide();
      transportationLine.hideStations();
    }
  }

  get length {
    int length = 0;
    for (TransportationLine transportationLine in transportationLines) {
      length += transportationLine.path.length;
    }
    return length;
  }
  
  String get avgInTransportationDistanceInKM {
    double avgInTransportationDistanceInKM = (avgInTransportationDistance/1000);
    return avgInTransportationDistanceInKM.toString().substring(0,avgInTransportationDistanceInKM.toString().indexOf(".")+2);
  }

  double get avgInTransportationDistance {
    double avgInTransportationDistance = 0.0;
    for (TransportationLine transportationLine in transportationLines) {
      avgInTransportationDistance += transportationLine.traveledDistance;
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
  /*
    Map toJson(){
      Map json = new Map();
      //json["\"@type\""]= "\""+runtimeType.toString()+"\"";
      json["\"originPosition\""]= originPosition.toJson();
      json["\"destination\""]= destination.toJson();
      return json;
    }*/
}
