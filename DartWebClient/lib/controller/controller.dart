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
import 'package:transpori/decorator/decorator.dart';

part 'home_controller.dart';