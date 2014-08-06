library routing;

import 'package:angular/angular.dart';

routeInitializer(Router router, RouteViewFactory routeViewFactory) {
  routeViewFactory.configure({
    'transportationRequest': ngRoute(defaultRoute: true, path: '/transportationRequest', view: 'view/transportationRequest/view.html'),
    'admin': ngRoute(/*defaultRoute: true,*/ path: '/admin', view: 'view/admin/view.html', mount: {
      'station': ngRoute(path: '/station', view: 'view/admin/station/view.html', mount: {
        'busStation': ngRoute(path: '/busStation', view: 'view/admin/station/busStation/manage.html'),
        'trainStation': ngRoute(path: '/trainStation', view: 'view/admin/station/trainStation/manage.html'),
        'tramwayStation': ngRoute(path: '/tramwayStation', view: 'view/admin/station/tramwayStation/manage.html')
      }),
      'transportationLine': ngRoute(path: '/transportationLine', view: 'view/admin/transportationLine/view.html', mount: {
        'busLine': ngRoute(path: '/busLine', view: 'view/admin/transportationLine/busLine/manage.html'),
        'trainLine': ngRoute(path: '/trainLine', view: 'view/admin/transportationLine/trainLine/manage.html'),
        'tramwayLine': ngRoute(path: '/tramwayLine', view: 'view/admin/transportationLine/tramwayLine/manage.html')
      })
    })
  });
}
