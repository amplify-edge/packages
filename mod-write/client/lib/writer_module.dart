import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_write/core/routes/paths.dart';
import 'package:mod_write/home_screen.dart';
import 'package:mod_write/view/list_document.dart';
import 'package:mod_write/view/src/form.dart';
import 'package:mod_write/view/src/full_page.dart';
import 'package:mod_write/view/src/view.dart';

class ModWriterModule extends ChildModule {
  final String baseRoute;

  ModWriterModule(String baseRoute)
      : assert(baseRoute != null),
        this.baseRoute = (baseRoute == '/') ? '' : baseRoute;

  @override
  List<Bind> get binds => [
        Bind((i) => Paths(baseRoute)),
      ];

  // routes for child module are starting with '/', e.g. "/fullpage"
  // but to call inside this module the correct route
  // we have to take care about the base route
  // so '/' will go to it's app modules route not to the child route!
  // pattern for the child module is e.g.
  // navigator.pushNamed("/moduleBaseRoute/fullpage")
  @override
  List<Router> get routers => [
        Router("/", child: (context, args) => DocumentList()),
        Router("/:id",
            child: (context, args) => DocumentList(
                  id: int.tryParse(args.params['id']) ?? -1,
                )),
        /*Router(cutOffBaseRoute(fullPageRoute),
            child: (context, args) => FullPageEditorScreen(id: args.params['id'],)),
        Router(cutOffBaseRoute(formRoute),
            child: (context, args) => FormEmbeddedScreen()),
        Router(cutOffBaseRoute(viewRoute),
            child: (context, args) => ViewScreen()),*/
      ];

  static Inject get to => Inject<ModWriterModule>.of();
}
