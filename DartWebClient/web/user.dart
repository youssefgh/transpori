
class User {
  String id;
  String name;
  String password;
  String firstName;
  String email;
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
        ..name = userMap["name"]
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
    json["name"] = name;
    json["password"] = password;
    json["firstName"] = firstName;
    json["email"] = email;
    json["birthday"] = birthday.toIso8601String();
    return json;
  }
}

class Administrator extends User {

}
