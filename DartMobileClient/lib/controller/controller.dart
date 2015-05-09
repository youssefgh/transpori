library controller;

import 'dart:html' hide Animation, MouseEvent;
import 'dart:js';
import 'dart:async';
import 'package:angular/angular.dart' hide Animation;
import 'package:google_maps_angular/google_maps_angular.dart';
//TODO remove dep
import 'package:google_maps/google_maps.dart';
import 'package:transpori/model/model.dart';
import 'package:transpori/service/webservice_client.dart';

part 'user.dart';
part 'transportation_line.dart';
part 'bus_line.dart';
part 'train_line.dart';
part 'tramway_line.dart';
part 'station.dart';
part 'bus_station.dart';
part 'train_station.dart';
part 'tramway_station.dart';
part 'station_suggestion.dart';
part 'transportation_request.dart';
part 'icon.dart';

@Injectable()
class RootContext {

  //Workaround for forms with validation
  //TODO find alt
  NgForm logInForm;
  NgForm signUpForm;

  UserController userCTRL;
  TransportationLineController transportationLineCTRL;
  BusLineController busLineCTRL;
  TrainLineController trainLineCTRL;
  TramwayLineController tramwayLineCTRL;
  StationController stationCTRL;
  BusStationController busStationCTRL;
  TrainStationController trainStationCTRL;
  TramwayStationController tramwayStationCTRL;
  TransportationRequestController transportationRequestCTRL;
  IconController iconCTRL;

  RootContext(this.userCTRL, this.transportationLineCTRL, this.busLineCTRL, this.trainLineCTRL, this.tramwayLineCTRL, this.stationCTRL, this.busStationCTRL, this.trainStationCTRL, this.tramwayStationCTRL, this.transportationRequestCTRL, this.iconCTRL);

}
