library transpori;

import 'package:angular/angular.dart';
import 'package:transpori/controller/controller.dart';
import 'package:transpori/decorator/decorator.dart';
import 'package:transpori/service/webservice_client.dart';
import 'package:transpori/model/model.dart';
import 'package:transpori/model/transportation_line/transportation_line.dart';
import 'package:transpori/model/station/station.dart';
import 'package:transpori/routing/routing.dart';

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
    bind(StationSuggestionController);
    bind(TransportationRequestController);

    bind(PathCustomMapDecorator);
    bind(TransportationLineCustomMapDecorator);
    bind(StationCustomMapDecorator);
    bind(StationSuggestionCustomMapDecorator);
    bind(StationDecorator);
    bind(TransportationLineDecorator);
    bind(TransportationPathDecorator);

    User user = new User();
    user.id = "5399e80a2318e2764276aff6";
    //user.email="admin@transpori.info";
    user.password = "123456";
    TransportationLine transportationLine;
    Station station;
    CustomMap customMap;
    CustomMapRepository customMapRepository = new CustomMapRepository();

    bind(CustomMap, toValue: customMap);
    bind(User, toValue: user);
    bind(TransportationLine, toValue: transportationLine);
    bind(Station, toValue: station);
    bind(CustomMapRepository, toValue: customMapRepository);

    bind(WSUser, toValue: new WSUser(user));
    bind(WSTransportationLine, toValue: new WSTransportationLine(user));
    bind(WSStation, toValue: new WSStation(user));
    bind(WSStationSuggestion, toValue: new WSStationSuggestion(user));
    bind(WSTransportationRequest, toValue: new WSTransportationRequest(user));

    bind(RouteInitializerFn, toValue: routeInitializer);
    bind(NgRoutingUsePushState,toValue: new NgRoutingUsePushState.value(false));
  }
}
