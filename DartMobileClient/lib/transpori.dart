library transpori;

import 'package:angular/angular.dart';
import 'package:transpori/controller/controller.dart';
import 'package:transpori/decorator/decorator.dart';
import 'package:transpori/service/webservice_client.dart';
import 'package:transpori/routing/routing.dart';

class MyAppModule extends Module {

  MyAppModule() {
    bind(TransportationRequestController);
    bind(IconController);

    bind(CustomGMapDecorator);
    bind(BusStationDecorator);
    bind(TrainStationDecorator);
    bind(TramwayStationDecorator);
    bind(BusLineDecorator);
    bind(TrainLineDecorator);
    bind(TramwayLineDecorator);
    bind(StartDecorator);
    bind(FinishDecorator);
    bind(StartIconDecorator);
    bind(FinishIconDecorator);
    bind(BusStationIconDecorator);
    bind(TrainStationIconDecorator);
    bind(TramwayStationIconDecorator);
    bind(PersonDecorator);
    bind(LineInfoWindowDecorator);

    bind(TransportationRequestService);

    bind(WSTransportationRequest);
    
    bind(SessionService);

    bind(RouteInitializerFn, toImplementation: ApplicationRouter);
    bind(NgRoutingUsePushState, toValue: new NgRoutingUsePushState.value(false));
  }

}
