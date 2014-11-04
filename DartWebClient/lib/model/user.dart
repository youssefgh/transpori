part of model;

class User {

  String id;
  String email;
  String password;
  String firstName;
  DateTime birthday;

  User();

  User.fromMap(Map userMap) {
    id = userMap["id"];
    password = userMap["password"];
    firstName = userMap["firstName"];
    email = userMap["email"];
    birthday = new DateTime.fromMillisecondsSinceEpoch(userMap["birthday"]);
  }

  factory User.instanceFromMap(Map userMap) {
    User user;
    switch (userMap["@type"]) {
      case "User":
        user = new User.fromMap(userMap);
        break;
      case "Administrator":
        user = new Administrator.fromMap(userMap);
        break;
    }
    return user;
  }

  bool isAdministrator() {
    return this is Administrator;
  }

  String authorizationString() => id + ":" + password;

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

  Administrator.fromMap(Map administratorMap) : super.fromMap(administratorMap);

}
