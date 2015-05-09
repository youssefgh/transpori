library transpori_mobile;

import 'package:angular/angular.dart';

import 'dart:html';
import 'dart:js';
import 'dart:convert';
import 'dart:async';

import 'package:transpori_mobile/service/webservice_client.dart';
import 'package:transpori_mobile/model/model.dart';
import 'package:transpori_mobile/model/station/station.dart';

import 'package:logging/logging.dart';

class MyAppModule extends Module {

  MyAppModule() {
    User user = new User();
    user.id = "5399e80a2318e2764276aff6";
    //user.email="admin@transpori.info";
    user.password = "123456";
    Station station;
    bind(User, toValue: user);
    bind(Station, toValue: station);

    bind(WSStation, toValue: new WSStation(user));
    bind(WSStationSuggestion, toValue: new WSStationSuggestion(user));

    bind(DeviceReadyDecorator);
  }
}

@Injectable()
class RootContext {
  BusStationSnapshot selected;
  List<BusStationSnapshot> stations = new List();
  WSStation webSevice;
  Logger logger = new Logger("StationControllerLogger");

  RootContext(this.webSevice) {
    logger.info("start");
    //window.localStorage.remove("stations");
    if (window.localStorage["stations"] != null) {
      List<Map> list = JSON.decode(window.localStorage["stations"]);
      list.forEach((map) {
        stations.add(new BusStationSnapshot.withDateTime(num.parse(map["latitude"]), num.parse(map["longitude"]), new DateTime.fromMillisecondsSinceEpoch(map["dateTime"])));
      });
    }
  }

  String get webSeviceURL => webSevice.rawWebServiceUrl;
  set webSeviceURL(String webSeviceURL) {
    webSevice.rawWebServiceUrl = webSeviceURL;
  }

  clear() {
    selected = null;
  }

  remove(BusStationSnapshot station) {
    stations.remove(station);
    window.localStorage["stations"] = JSON.encode(stations);
  }

  Future get() {
    logger.info("get");
    return Navigator.geolocation.getCurrentPosition().then((mapPoint) {
      logger.info("return");
      selected = new BusStationSnapshot(mapPoint.lat, mapPoint.lng);
    });
    /*
    window.navigator.geolocation.getCurrentPosition().then((geoposition) {
      selected = new BusStationSnapshot(geoposition.coords.latitude, geoposition.coords.longitude);
    }).catchError((PositionError e) {
      logger.severe(e.message);
      selected = new BusStationSnapshot(1, 2);
    });*/
    //selected = new BusStationSnapshot(1, 2);
  }

  save() {
    stations.add(selected);
    window.localStorage["stations"] = JSON.encode(stations);
    selected = null;
  }

  send() {
    Future.forEach(stations, (station) {
      BusStation newStation = new BusStation(station.lat, station.lng);
      webSevice.create(newStation).then((e) {
        stations.remove(station);
        window.localStorage["stations"] = JSON.encode(stations);
      });
    });
  }

  getAndSave() {
    get().then((r) {
      save();
    });
  }

  bool isReady = false;

  ready() {
    isReady = true;
  }
}

@Decorator(selector: '[device-ready]')
class DeviceReadyDecorator implements AttachAware {

  Element html;
  @NgCallback('on-device-ready')
  Function onDeviceReady;
  Logger logger = new Logger("DeviceReadyDecoratorLogger");

  DeviceReadyDecorator(this.html);

  attach() {
    document.addEventListener("deviceready", (e) {
      onDeviceReady();
      print("device ready !");
      /*
      logger.info("device ready !");
      logger.info(Navigator.geolocation.getCurrentPosition().toJson());*/
    });
  }
}

class Navigator {
  static Geolocation geolocation = new Geolocation();
}

class Geolocation {

  Logger logger = new Logger("GeolocationLogger");

  Future<MapPoint> getCurrentPosition() {
    Completer completer = new Completer();
    MapPoint mapPoint;
    JsObject geolocationOptions = new JsObject.jsify({
      'enableHighAccuracy': true,
      'maximumAge': 3000,
      'timeout': 30000
    });
    (context['navigator']['geolocation'] as JsObject).callMethod('getCurrentPosition', [(p) {
        logger.info("3.3");
        mapPoint = new MapPoint(p['coords']['latitude'], p['coords']['longitude']);
        logger.info(p['coords']['latitude']);
        logger.info(mapPoint.lat);
        logger.info("4");
        completer.complete(mapPoint);
        logger.info("5");
      }, (e) {
        logger.info(e['message']);
      }, geolocationOptions]);
    return completer.future;
  }
}

class BusStationSnapshot extends BusStation {

  DateTime dateTime = new DateTime.now();

  BusStationSnapshot(num lat, num lng, [String id]) : super(lat, lng, id);
  BusStationSnapshot.withDateTime(num lat, num lng, this.dateTime) : super(lat, lng);

  Map toJson() {
    Map json = super.toJson();
    json["dateTime"] = dateTime.millisecondsSinceEpoch;
    return json;
  }

}
