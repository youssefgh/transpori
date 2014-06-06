Update your Glassfish Jersey :
//list available updates
pkg list -u
//install jersey update
pkg install jersey

After deployment :
    Add an administrator :

db.user.insert({"_class" : "com.transportation.transportation.model.entites.Administrator", 
                "name" : "admin", 
                "password" : "123", 
                "firstName" : "youssef", 
                "email" : "admin@mail.com", 
                "birthday" : ISODate("1990-04-11T00:00:00Z") })


Depricated
1 . set Glassfish passwords in "glassfish4/glassfish/domains/domain1/config/domain-passwords"
exemple :
AS_MASTER_PASSWORD=123456
AS_ADMIN_PASSWORD=123456
AS_ADMIN_USERPASSWORD=123456

