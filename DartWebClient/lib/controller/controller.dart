library controller;

import 'dart:html' hide Animation;
import 'dart:js';
import 'dart:async';
import 'package:angular/angular.dart' hide Animation;
import 'package:google_maps/google_maps.dart';
import 'package:transpori/model/model.dart';
import 'package:transpori/model/transportation_line/transportation_line.dart';
import 'package:transpori/model/station/station.dart';
import 'package:transpori/service/webservice_client.dart';

part 'user_controller.dart';
part 'transportation_line/transportation_line_controller.dart';
part 'transportation_line/bus_line_controller.dart';
part 'transportation_line/train_line_controller.dart';
part 'transportation_line/tramway_line_controller.dart';
part 'station/station_controller.dart';
part 'station/bus_station_controller.dart';
part 'station/train_station_controller.dart';
part 'station/tramway_station_controller.dart';
part 'station/station_suggestion_controller.dart';
part 'transportation_request_controller.dart';