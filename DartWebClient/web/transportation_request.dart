import 'origin_position.dart';
import 'destination.dart';

class TransportationRequest {
  OriginPosition originPosition;
  Destination destination;
  TransportationRequest(this.originPosition, this.destination);
  
  Map toJson(){
    Map json = new Map();
    //TODO inspect sever exception cause
    //json["\"@type\""]= "\""+runtimeType.toString()+"\"";
    json["\"originPosition\""]= originPosition.toJson();
    json["\"destination\""]= destination.toJson();
    return json;
  }
}