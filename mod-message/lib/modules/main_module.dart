import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

import '../widgets/pane.dart';

class PaneModule extends ChildModule {
  Box box;

  PaneModule(this.box);

  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router("/", child: (_, args) => PaneWidget(box)),
      ];
}
