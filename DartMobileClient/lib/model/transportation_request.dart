part of model;

class TransportationRequest {

  MapPoint originPosition;
  MapPoint destination;

  TransportationRequest(this.originPosition, this.destination);

  Map toJson() {
    Map json = new Map();
    json["originPosition"] = originPosition.toJson();
    json["destination"] = destination.toJson();
    return json;
  }

}
