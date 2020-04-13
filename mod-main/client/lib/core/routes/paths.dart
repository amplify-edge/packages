

class Paths{
  final String baseRoute;
  String userInfo;
  String orgs;
  String ready;
  String supportRoles;
  String myNeeds;
  String splash;
  String dashboard;
  String login;

  Paths(this.baseRoute) : 
   dashboard  = '$baseRoute/dashboard',
   userInfo = '$baseRoute/userInfo',
   orgs = '$baseRoute/orgs',
   ready = '$baseRoute/ready',
   supportRoles = '$baseRoute/supportRoles/orgs/:id',
   myNeeds = '$baseRoute/myneeds/orgs/:id',
   splash = '$baseRoute/',
   login = '$baseRoute/login';
}