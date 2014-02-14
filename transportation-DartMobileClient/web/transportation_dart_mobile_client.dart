import 'dart:html';
import 'dart:collection';
import 'dart:convert';
import 'dart:async';
//import 'package:google_maps/google_maps.dart';
import 'package:js/js.dart' as js;
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
import 'package:rikulo_gap/connection.dart';
import 'package:rikulo_gap/device.dart';
import 'package:rikulo_gap/geolocation.dart';

String webServiceUrl = "http://tmorocco-mdeveloper.rhcloud.com/Transportation-web/rest/";
DivElement mapDiv = querySelector("#map");
ButtonElement advancedSearchButton = querySelector("#advancedSearchButton");
CustomMap map;
void main() {
  if(!window.navigator.onLine){
    window.alert("Impossible d'acceder au services de geolocalisation. Veillez verifier votre connection internet !");
  }
  window.onOffline.listen((e){
    window.alert("ur offline");
  });
  window.onOnline.listen((e){
    window.alert("ur online");
  });
  //window.navigator.geolocation.
  
  //new Timer( new Duration(days: 0, hours: 0, minutes: 0, seconds: 5, milliseconds: 0, microseconds: 0), (){
  //enableDeviceAccess().then((device){
  try{
      geolocation.getCurrentPosition((posision){
        
        window.alert("pos "+posision.coords.accuracy);
      },(ex){
        window.alert("geo error");
      }
      );
  } catch(ex){
      window.alert("enable error");
      print(ex.toString());
  }/*
  }).catchError((){
   window.alert("erreeeur"); 
  });*/
  //});
  initListners();
  map = new CustomMap(mapDiv);
  setPathMode();
  querySelector("#logo").remove();
  mapDiv.hidden = false;
  //window.navigator.geolocation.getCurrentPosition();
  /*
  new Timer( new Duration(days: 0, hours: 0, minutes: 0, seconds: 15, milliseconds: 0, microseconds: 0), (){
    geolocation.getCurrentPosition((posision){
      
      window.alert("pos "+posision.coords.accuracy);
    },(ex){
      window.alert("geo error");
    }
    );
  });
 */ 
}

StreamSubscription stream;

void setPathMode(){
  if(stream != null){
    stream.cancel();
  }
  stream = map.onClick.listen((e){
    if(map.originPosition == null || map.originPosition.marker.visible == false){
      map.originPosition = new OriginPosition(e.latLng,map);
    } else {
      if(map.destination == null || map.destination.marker.visible == false){
        map.destination = new Destination(e.latLng,map);
        getPaths(); 
      }   
    }
  });
}

void getPaths(){
    map.clearSuggestions();
    TransportationRequest transportationRequest = new TransportationRequest(map.originPosition, map.destination);
    //print(transportationRequest.toJson());
    HttpRequest httpRequest = new HttpRequest()
      ..open("POST", webServiceUrl+"TransportationResponse")
      ..setRequestHeader('content-type', 'application/json')
      ..send(transportationRequest.toJson().toString())
      ;
    httpRequest.onLoadEnd.listen((e){
      //TODO
      //print(httpRequest.response);
      Map transportationResponseMap = JSON.decode(httpRequest.response);
      List transportationPathsMap = transportationResponseMap["transportationPaths"];
      for(Map transportationPathMap in transportationPathsMap){
        map.suggestions.add(new TransportationPath.fromMap(transportationPathMap, map));
      }
    });
    //map.suggestions
}

void initListners(){
  advancedSearchButton.onClick.listen((e){
    if(querySelector("#advancedSearchTable").style.visibility == "hidden"){
      querySelector("#advancedSearchTable").style.visibility = "visible";
      querySelector("#advancedSearchOk").style.visibility = "visible";
    } else {
      querySelector("#advancedSearchTable").style.visibility = "hidden";
      querySelector("#advancedSearchOk").style.visibility = "hidden";
    }
  });
  
  querySelector("#advancedSearchOk").onClick.listen((e){
    querySelector("#advancedSearchOk").style.visibility = "hidden";
    querySelector("#advancedSearchTable").style.visibility = "hidden";
  });
}