library transpori;

import 'package:angular/angular.dart';
import 'package:transpori/controller/controller.dart';
import 'package:transpori/decorator/decorator.dart';

class MyAppModule extends Module {
  MyAppModule() {
    type(HomeController);
    type(GMapsDecorator);
  }
}