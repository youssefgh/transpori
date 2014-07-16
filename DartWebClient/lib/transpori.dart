library transpori;

import 'package:angular/angular.dart';
import 'package:transpori/controller/home_controller.dart';

class MyAppModule extends Module {
  MyAppModule() {
    type(HomeController);
  }
}