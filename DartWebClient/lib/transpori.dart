library transpori;

import 'package:angular/angular.dart';
import 'package:transpori/controller/controller.dart';
import 'package:transpori/decorator/decorator.dart';
import 'package:transpori/service/webservice_client.dart';
import 'package:transpori/routing/routing.dart';

import 'package:google_maps/google_maps.dart';

class MyAppModule extends Module {

  MyAppModule() {
    bind(UserController);
    bind(TransportationLineController);
    bind(BusLineController);
    bind(TrainLineController);
    bind(TramwayLineController);
    bind(StationController);
    bind(BusStationController);
    bind(TrainStationController);
    bind(TramwayStationController);
    bind(TransportationRequestController);
    bind(IconController);
    //bind(TransportationPartController);
    //bind(BusPartController);

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

    bind(UserService);
    bind(TransportationLineService);
    bind(BusLineService);
    bind(TrainLineService);
    bind(TramwayLineService);
    bind(StationService);
    bind(BusStationService);
    bind(TrainStationService);
    bind(TramwayStationService);
    bind(TransportationRequestService);
    //bind(TransportationPartService);
    //bind(BusPartService);

    bind(WSUser);
    bind(WSTransportationLine);
    //bind(WSTransportationPart);
    bind(WSStation);
    bind(WSStationSuggestion);
    bind(WSTransportationRequest);

    bind(SessionService);

    bind(RouteInitializerFn, toImplementation: ApplicationRouter);
    bind(NgRoutingUsePushState, toValue: new NgRoutingUsePushState.value(false));
  }

}
