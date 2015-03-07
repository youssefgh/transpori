library routing;

import 'package:angular/angular.dart';
//TODO move to services to a service package
import 'package:transpori/controller/controller.dart';

@Injectable()
class ApplicationRouter implements Function {

  BusStationService _busStationService;
  TrainStationService _trainStationService;
  TramwayStationService _tramwayStationService;
  BusLineService _busLineService;
  TrainLineService _trainLineService;
  TramwayLineService _tramwayLineService;
  //BusPartService _busPartService;

  ApplicationRouter(this._busLineService, this._busStationService, this._trainLineService, this._trainStationService, this._tramwayLineService, this._tramwayStationService/*, this._busPartService*/);

  call(Router router, RouteViewFactory routeViewFactory) {
    routeViewFactory.configure({
      'transportationRequest': ngRoute(defaultRoute: true, path: '/transportationRequest', view: 'view/transportationRequest/view.html'),
      'admin': ngRoute(path: '/admin', view: 'view/admin/view.html', mount: {
        'station': ngRoute(path: '/station', view: 'view/admin/station/view.html', mount: {
          'busStation': ngRoute(path: '/busStation', view: 'view/admin/station/busStation/manage.html', enter: (RouteEnterEvent e) {
            _busStationService.refreshStations();
          }),
          'trainStation': ngRoute(path: '/trainStation', view: 'view/admin/station/trainStation/manage.html', enter: (RouteEnterEvent e) {
            _trainStationService.refreshStations();
          }),
          'tramwayStation': ngRoute(path: '/tramwayStation', view: 'view/admin/station/tramwayStation/manage.html', enter: (RouteEnterEvent e) {
            _tramwayStationService.refreshStations();
          })
        }),
        'transportationLine': ngRoute(path: '/transportationLine', view: 'view/admin/transportationLine/view.html', mount: {
          'busLine': ngRoute(path: '/busLine', view: 'view/admin/transportationLine/busLine/manage.html', enter: (RouteEnterEvent e) {
            _busLineService.refreshTransportationLines();
          }),
          'trainLine': ngRoute(path: '/trainLine', view: 'view/admin/transportationLine/trainLine/manage.html', enter: (RouteEnterEvent e) {
            _trainLineService.refreshTransportationLines();
          }),
          'tramwayLine': ngRoute(path: '/tramwayLine', view: 'view/admin/transportationLine/tramwayLine/manage.html', enter: (RouteEnterEvent e) {
            _tramwayLineService.refreshTransportationLines();
          })
        }),
        'transportationPart': ngRoute(path: '/transportationPart', view: 'view/admin/transportationPart/view.html', mount: {
          'busPart': ngRoute(path: '/busPart', view: 'view/admin/transportationPart/busPart/manage.html', enter: (RouteEnterEvent e) {
            //_busPartService.refreshTransportationParts();
          })
        })
      })
    });
  }

}
