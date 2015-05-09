library webservice_client;

import 'package:angular/angular.dart';
import 'package:transpori/model/model.dart';

part 'w_s_transportation_request.dart';

class WebserviceClient {

  final String rawWebServiceUrl = "http://localhost:8080/rest/";
  final String httpPut = "PUT";
  final String httpGet = "GET";
  final String httpPost = "POST";
  final String httpDelete = "DELETE";
  final Map rawRequestHeader = {
    "content-type": "application/json"
  };
  User user;

  WebserviceClient(SessionService service) {
    user = service.user;
  }

  Map get requestHeader {
    if (user != null && user.id != null) rawRequestHeader["authorization"] = user.authorizationString();
    return rawRequestHeader;
  }
}

@Injectable()
class SessionService {

  User user;

  SessionService() {
    user = new User();
  }

}
