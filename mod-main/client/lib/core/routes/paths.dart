

class Paths{
  final String baseRoute;
  String userInfo;
  String orgs;
  String ready;
  String supportRoles;
  String myNeeds;

  Paths(this.baseRoute) : 
   userInfo = '$baseRoute/userInfo',
   orgs = '$baseRoute/orgs',
   ready = '$baseRoute/ready',
   supportRoles = '$baseRoute/supportRoles/orgs/:id',
   myNeeds = '$baseRoute/myneeds/orgs/:id';
}