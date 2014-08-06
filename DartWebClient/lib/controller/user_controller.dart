part of controller;

@Controller(selector: '[user-ctrl]', publishAs: 'ctrl')
class UserController {
  
  User selected;
  WSUser webService;
  
  UserController(this.webService , this.selected);

  bool isUserLoggedIn() {
    return selected != null && selected.id != null;
  }
  
  signUp() {
    webService.create(selected).then((e) {
      //FIXME find alternative solution
      context.callMethod(r'$', ['#signUpModal']).callMethod('modal', ['toggle']);
    }).catchError((e) {
      if ((e.target as HttpRequest).status == 406) {
        (querySelector('#email') as InputElement).placeholder = "Nouveau email";
        selected.email = "";
      }
    });
  }

  Future logIn() {
    return webService.read(selected).then((user) {
      selected.birthday = user.birthday;
      selected.email = user.email;
      selected.firstName = user.firstName;
      selected.id = user.id;
      selected.password = user.password;
      //FIXME find alternative solution
      context.callMethod(r'$', ['#logInModal']).callMethod('modal', ['toggle']);
    }).catchError((e) {
      selected.password = "";
    });
  }

  void logOut() {
    selected.id = null;
    //TODO implement others
  }

}
