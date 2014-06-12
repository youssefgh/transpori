
class User {
  String id;
  String email;
  String password;
  String firstName;
  DateTime birthday;

  User();

  factory User.instanceFromMap(Map userMap) {print(userMap["@type"]);
    User user;
    switch (userMap["@type"]) {
      case "User":
        user = new User();
        break;
      case "Administrator":
        user = new Administrator();
        break;
    }
    user
        ..id = userMap["id"]
        ..password = userMap["password"]
        ..firstName = userMap["firstName"]
        ..email = userMap["email"]
        ..birthday = new DateTime.fromMillisecondsSinceEpoch(userMap["birthday"]);
    return user;
  }

  bool isAdministrator() {
    return this.runtimeType.toString() == "Administrator";
  }
  
  String getAuthorizationString(){
    return id+":"+password;
  }

  Map toJson() {
    Map json = new Map();
    json["@type"] = runtimeType.toString();
    json["id"] = id;
    json["email"] = email;
    json["password"] = password;
    json["firstName"] = firstName;
    json["birthday"] = birthday.toIso8601String();
    return json;
  }
}

class Administrator extends User {

}
