import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_kanban/core/routes/paths.dart';
import 'package:mod_kanban/view/master_detail_home.dart';

class KanbanModule extends ChildModule {
  final String baseRoute;

  KanbanModule(String baseRoute)
      : assert(baseRoute != null),
        this.baseRoute = (baseRoute == '/') ? '' : baseRoute;

  @override
  List<Bind> get binds => [
        Bind((i) => Paths(baseRoute)),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          "/",
          child: (context, args) => MasterDetailHome(),
        ),
        ModularRouter("/:id",
            child: (context, args) => MasterDetailHome(
                  id: int.tryParse(args.params['id']) ?? -1,
                )),
      ];

  static Inject get to => Inject<KanbanModule>.of();
}
