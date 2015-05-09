library controller;

import 'dart:async';
import 'package:angular/angular.dart' hide Animation;
import 'package:google_maps_angular/google_maps_angular.dart';
//TODO remove dep
import 'package:google_maps/google_maps.dart';
import 'package:transpori/model/model.dart';
import 'package:transpori/service/webservice_client.dart';

part 'transportation_request.dart';
part 'icon.dart';

@Injectable()
class RootContext {

  //Workaround for forms with validation
  //TODO find alt
  NgForm logInForm;
  NgForm signUpForm;

  TransportationRequestController transportationRequestCTRL;
  IconController iconCTRL;

  RootContext(this.transportationRequestCTRL, this.iconCTRL);

}
