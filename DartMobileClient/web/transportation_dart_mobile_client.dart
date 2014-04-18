import 'dart:html';
import 'dart:convert';
import 'dart:async';
import 'dart:js';
import 'bus_line.dart';
import 'tramway_line.dart';
import 'train_line.dart';
import 'custom_map.dart';
import 'map_point.dart';
import 'transportation_line.dart';
import 'station.dart';
import 'transportation_request.dart';
import 'transportation_path.dart';
import 'origin_position.dart';
import 'destination.dart';

String webServiceUrl = "http://tmorocco-mdeveloper.rhcloud.com/rest/";
DivElement mapDiv = querySelector("#map");
ButtonElement advancedSearchButton = querySelector("#advancedSearchButton");
CustomMap map;

void main() {
  //dart object to jsobject test fail
  /*
  var options = {"enableHighAccuracy" : true};
  context.callMethod('go', [options]);*/
  document.addEventListener("deviceready", (e) {
    window.console.log("deviceready");
    querySelector("#logo").remove();
    mapDiv.hidden = false;
    context['navigator']['geolocation'].callMethod('getCurrentPosition', [(p) {
        print("coucou p");
        print(p['coords']['latitude']);
        print(p['coords']['longitude']);
      }, (e) {
        print("coucou e");
        print(e['message']);
      }, context['x']]);
  });
  initListners();
  map = new CustomMap(mapDiv);
  setPathMode();
}

StreamSubscription stream;

void setPathMode() {
  if (stream != null) {
    stream.cancel();
  }
  stream = map.onClick.listen((e) {
    if (map.originPosition == null || map.originPosition.marker.visible ==
        false) {
      map.originPosition = new OriginPosition(e.latLng, map);
    } else {
      if (map.destination == null || map.destination.marker.visible == false) {
        map.destination = new Destination(e.latLng, map);
        getPaths();
      }
    }
  });
}

void getPaths() {
  map.clearSuggestions();
  TransportationRequest transportationRequest = new TransportationRequest(
      map.originPosition, map.destination);
  //print(transportationRequest.toJson());
  HttpRequest httpRequest = new HttpRequest()
      ..open("POST", webServiceUrl + "TransportationResponse")
      ..setRequestHeader('content-type', 'application/json')
      ..send(transportationRequest.toJson().toString());
  httpRequest.onLoadEnd.listen((e) {
    //TODO
    //print(httpRequest.response);
    Map transportationResponseMap = JSON.decode(httpRequest.response);
    List transportationPathsMap =
        transportationResponseMap["transportationPaths"];
    for (Map transportationPathMap in transportationPathsMap) {
      map.suggestions.add(new TransportationPath.fromMap(transportationPathMap,
          map));
    }
  });
  //map.suggestions
}

void initListners() {
  advancedSearchButton.onClick.listen((e) {
    if (querySelector("#advancedSearchTable").style.visibility == "hidden") {
      querySelector("#advancedSearchTable").style.visibility = "visible";
      querySelector("#advancedSearchOk").style.visibility = "visible";
    } else {
      querySelector("#advancedSearchTable").style.visibility = "hidden";
      querySelector("#advancedSearchOk").style.visibility = "hidden";
    }
  });
  querySelector("#advancedSearchOk").onClick.listen((e) {
    querySelector("#advancedSearchOk").style.visibility = "hidden";
    querySelector("#advancedSearchTable").style.visibility = "hidden";
  });
}
