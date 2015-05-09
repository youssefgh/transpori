library routing;

import 'package:angular/angular.dart';

@Injectable()
class ApplicationRouter implements Function {

  ApplicationRouter();

  call(Router router, RouteViewFactory routeViewFactory) {
    routeViewFactory.configure({
      'transportationRequest': ngRoute(defaultRoute: true, path: '/transportationRequest', view: 'view/transportationRequest/view.html')
    });
  }

}
