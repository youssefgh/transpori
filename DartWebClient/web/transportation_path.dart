//import 'package:google_maps/google_maps.dart';
import 'transportation_line.dart';

class TransportationPath {
  
    List<TransportationLine> transportationLines = new List();
    
    TransportationPath.fromMap(Map transportationPathMap){
      //List transportationLinesMap = transportationPathMap["transportationLineas"];
      for(Map transportationLineMap in transportationPathMap["transportationLines"]){
         transportationLines.add(new TransportationLine.instanceFromMap(transportationLineMap));
      }
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
    