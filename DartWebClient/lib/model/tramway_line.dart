part of model;

class TramwayLine extends TransportationLine {

  TramwayLine();

  TramwayLine.fromMap(Map tramwayLineMap) : super.fromMap(tramwayLineMap);

  Map toJson() {
    Map json = super.toJson();
    json["@type"] = "TramwayLine";
    return json;
  }
  
}
