class Paths{
  final String baseRoute;
  final String masterDetail;

  Paths(this.baseRoute) :
        masterDetail = '$baseRoute/:id';

}