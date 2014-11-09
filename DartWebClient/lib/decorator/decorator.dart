library decorator;

import 'dart:html' hide Animation;
import 'dart:async';
import 'package:angular/angular.dart' hide Animation;
import 'package:google_maps_angular/google_maps_angular.dart';
import 'package:google_maps_angular/decorator/decorator.dart';
import 'package:google_maps/google_maps.dart';

part 'custom_gmap.dart';
part 'station.dart';
part 'station_icon.dart';
part 'transportation_line.dart';
part 'position.dart';
part 'position_icon.dart';
part 'person.dart';

@Decorator(selector: '[info-window]')
class LineInfoWindowDecorator extends InfoWindowDecorator {

  final num _CLOSING_TIME = 2;
  Timer _closeTimer;

  set position(LatLng position) {
    position = position;
    infoWindow.position = position;
    if (position != null) {
      infoWindow.open(gMap);
      if (_closeTimer != null) _closeTimer.cancel();
      _closeTimer = _createCloseTimer();
    } else {
      if (_closeTimer != null && !_closeTimer.isActive) _closeTimer = _createCloseTimer();
    }
  }

  Timer _createCloseTimer() {
    return new Timer(new Duration(seconds: _CLOSING_TIME), () {
      infoWindow.close();
    });
  }

}
