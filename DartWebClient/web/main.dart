import 'package:angular/application_factory.dart';
import 'package:transpori/transpori.dart';
import 'package:logging/logging.dart';

import 'package:angular/angular.dart';
import 'package:di/src/reflector_dynamic.dart';

void main() {/*
  Logger.root
      ..level = Level.FINEST
      ..onRecord.listen((LogRecord r) {
        print(r.message);
      });*/
  Module.DEFAULT_REFLECTOR = new DynamicTypeFactories();
  applicationFactory().addModule(new MyAppModule()).run();
}
