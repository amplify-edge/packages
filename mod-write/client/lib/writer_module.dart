import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_write/home_screen.dart';
import 'package:mod_write/view/list_document.dart';
import 'package:mod_write/view/src/form.dart';
import 'package:mod_write/view/src/full_page.dart';
import 'package:mod_write/view/src/view.dart';

class ModWriterModule extends ChildModule {
  // not sure if this is the best way to store the current route statically
  // it works ... ideas welcome
  static String baseRoute;
  static String fullPageRoute;
  static String formRoute;
  static String viewRoute;

  static String cutOffBaseRoute(String route) {
    if (route.indexOf(baseRoute) < 0) return route;
    return route.substring(
        route.indexOf(baseRoute) + baseRoute.length, route.length);
  }

  ModWriterModule(String baseRoute) {
    assert(baseRoute != null);
    ModWriterModule.baseRoute = baseRoute;
    //add trailing slash if not exists
    if (baseRoute[baseRoute.length - 1] != "/") {
      ModWriterModule.baseRoute = "$baseRoute/";
    }

    ModWriterModule.fullPageRoute = ModWriterModule.baseRoute + "fullpage/:id";
    ModWriterModule.formRoute = ModWriterModule.baseRoute + "form";
    ModWriterModule.viewRoute = ModWriterModule.baseRoute + "view";
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
        Router("/", child: (context, args) => DocumentList()),
        /*Router(cutOffBaseRoute(fullPageRoute),
            child: (context, args) => FullPageEditorScreen(id: args.params['id'],)),
        Router(cutOffBaseRoute(formRoute),
            child: (context, args) => FormEmbeddedScreen()),
        Router(cutOffBaseRoute(viewRoute),
            child: (context, args) => ViewScreen()),*/
      ];

  static Inject get to => Inject<ModWriterModule>.of();
}
