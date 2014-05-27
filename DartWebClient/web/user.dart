
class User {
  String username;
  String password;
  
  User(this.username,this.password);
  
  bool isAdministrator(){
    return this.runtimeType.toString() == "Administrator"; 
  }
  
}

class Administrator extends User {
  
  Administrator(String username,String password) : super(username,password);
  
}