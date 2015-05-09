import 'package:angular/application_factory.dart';
import 'package:transpori_mobile/transpori_mobile.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root
      ..level = Level.FINEST
      ..onRecord.listen((LogRecord r) {
        print(r.message);
  });
  applicationFactory().rootContextType(RootContext).addModule(new MyAppModule()).run();
}
