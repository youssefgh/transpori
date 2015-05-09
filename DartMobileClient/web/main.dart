import 'package:angular/application_factory.dart';
import 'package:transpori/transpori.dart';
import 'package:transpori/controller/controller.dart';
//import 'package:logging/logging.dart';

void main() {/*
  Logger.root
      ..level = Level.FINEST
      ..onRecord.listen((LogRecord r) {
        print(r.message);
      });*/
  applicationFactory().rootContextType(RootContext).addModule(new MyAppModule()).run();
}
