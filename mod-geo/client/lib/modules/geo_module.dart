

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_geo/modules/map/services/mock_map_service.dart';
import 'map/map.dart';


class GeoModule extends ChildModule{

   static String baseRoute;

  static String cutOffBaseRoute(String route) {
    if (route.indexOf(baseRoute) < 0) return route;
    return route.substring(
        route.indexOf(baseRoute) + baseRoute.length, route.length);
  }

  GeoModule(String baseRoute) {
    assert(baseRoute != null);
    GeoModule.baseRoute = baseRoute;
  }

  @override
  List<Bind> get binds => [
    Bind((i) => MockMapService()),
  ];


  @override
  List<Router> get routers => [
    Router('/', child:  (context, args) => MapsView())
  ];

  static Inject get to => Inject<GeoModule>.of();

}