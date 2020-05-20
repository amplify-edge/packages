class Paths {
  final String baseRoute;
  final String masterDetailRoute;

  Paths(this.baseRoute) : masterDetailRoute = "$baseRoute/:id";
}
