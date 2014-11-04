import 'package:angular/application_factory.dart';
import 'package:transpori_mobile/transpori_mobile.dart';
import 'package:logging/logging.dart';

/*
@MirrorsUsed(targets: const["transpori_mobile"] ,override: '*')
import 'dart:mirrors';
*/
void main() {
  Logger.root
      ..level = Level.FINEST
      ..onRecord.listen((LogRecord r) {
        print(r.message);
  });
  applicationFactory().addModule(new MyAppModule()).run();
}
