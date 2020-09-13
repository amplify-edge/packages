class Paths{
  final String baseRoute;
  final String master;
  final String detail;

  Paths(this.baseRoute) :
        master  = '$baseRoute/', 
        detail = '$baseRoute/:id';

}