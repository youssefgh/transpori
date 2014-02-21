import 'origin_position.dart';
import 'destination.dart';

class TransportationRequest {
  OriginPosition originPosition;
  Destination destination;
  TransportationRequest(this.originPosition, this.destination);
  
  Map toJson(){
    Map json = new Map();
    //json["\"@type\""]= "\""+runtimeType.toString()+"\"";
    json["\"originPosition\""]= originPosition.toJson();
    json["\"destination\""]= destination.toJson();
    return json;
  }
}