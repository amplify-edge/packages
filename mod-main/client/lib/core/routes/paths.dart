

class Paths{
  final String baseRoute;
  String userInfo;
  String orgs;
  String ready;
  String supportRoles;
  String myNeeds;
  String splash;
  String dashboard;
  String org;

  Paths(this.baseRoute) : 
   dashboard  = '$baseRoute/dashboard/orgs', // Admin dashboard routes
   org = '$baseRoute/dashboard/orgs/:id', // Admin dashboard routes
   userInfo = '$baseRoute/userInfo',// Non-Admin routes
   orgs = '$baseRoute/orgs',
   ready = '$baseRoute/ready',
   supportRoles = '$baseRoute/supportRoles/orgs/:id',
   myNeeds = '$baseRoute/myneeds/orgs/:id',
   splash = '$baseRoute/';
  
}