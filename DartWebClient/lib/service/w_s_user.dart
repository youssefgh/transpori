part of webservice_client;

@Injectable()
class WSUser extends WebserviceClient {
  
  WSUser(SessionService service) : super(service);

  get webServiceUrl => super.rawWebServiceUrl + "User/";

  Future create(User user) {
    return HttpRequest.request(webServiceUrl, method: httpPut, requestHeaders: requestHeader, sendData: JSON.encode(user));
  }

  Future<User> read(User user) {
    return HttpRequest.request(webServiceUrl + user.email + "/" + user.password).then((httpRequest) {
      Map userMap = JSON.decode(httpRequest.response);
      return new User.instanceFromMap(userMap);
    });
  }

}
