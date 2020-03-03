import 'package:mod_ion/home_screen.dart';
import 'package:flutter_modular/flutter_modular.dart';

class IonModule extends ChildModule {
  // not sure if this is the best way to store the current route statically
  // it works ... ideas welcome
  static String baseRoute;

  static String cutOffBaseRoute(String route) {
    if (route.indexOf(baseRoute) < 0) return route;
    return route.substring(
        route.indexOf(baseRoute) + baseRoute.length, route.length);
  }

  IonModule(String baseRoute) {
    assert(baseRoute != null);
    IonModule.baseRoute = baseRoute;
  }

  @override
  List<Bind> get binds => [];

  // routes for child module are starting with '/', e.g. "/fullpage"
  // but to call inside this module the correct route
  // we have to take care about the base route
  // so '/' will go to it's app modules route not to the child route!
  // pattern for the child module is e.g.
  // navigator.pushNamed("/moduleBaseRoute/fullpage")
  @override
  List<Router> get routers => [
        Router(
          "/",
          child: (context, args) => HomeScreen(),
        ),
      ];

  static Inject get to => Inject<IonModule>.of();
}
