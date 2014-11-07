part of model;

class BusLine extends TransportationLine {

  BusLine();

  BusLine.fromMap(Map busLineMap) : super.fromMap(busLineMap);

  Map toJson() {
    Map json = super.toJson();
    json["@type"] = "BusLine";
    return json;
  }
  
}
