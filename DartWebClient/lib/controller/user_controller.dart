part of controller;

@Controller(selector: '[user-ctrl]', publishAs: 'ctrl')
class UserController {

  UserService _service;

  UserController(this._service);

  get selected => _service.selected;

  bool isUserLoggedIn() => _service.isUserLoggedIn();

  signUp() {
    _service.signUp().then((e) {
      //FIXME find alternative solution
      context.callMethod(r'$', ['#signUpModal']).callMethod('modal', ['toggle']);
    }).catchError((e) {
      if ((e.target as HttpRequest).status == 406) {
        (querySelector('#email') as InputElement).placeholder = "Nouveau email";
        _service.onSignUpError();
      }
    });
  }

  logIn() {
    _service.logIn().then((user) {
      //FIXME find alternative solution
      context.callMethod(r'$', ['#logInModal']).callMethod('modal', ['toggle']);
    });
  }

  logOut() {
    _service.logOut();
  }

}

@Injectable()
class UserService {

  User selected;
  WSUser webService;

  UserService(this.webService, this.selected);

  bool isUserLoggedIn() {
    return selected != null && selected.id != null;
  }

  Future signUp() {
    return webService.create(selected);
  }
  
  onSignUpError(){
    selected.email = "";
  }

  Future logIn() {
    return webService.read(selected).then((user) {
      selected.birthday = user.birthday;
      selected.email = user.email;
      selected.firstName = user.firstName;
      selected.id = user.id;
      selected.password = user.password;
    }).catchError((e) {
      selected.password = "";
    });
  }

  logOut() {
    selected.id = null;
    //TODO implement others
  }
}
