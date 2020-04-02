

import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate02/router_outlet/nav_rail.dart';

import '../../app_module.dart';
import 'mod-folder/folder_view.dart';

class TabsModule extends ChildModule{
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
    Router("/" , child : (_, args) => NavRailView()),
  ];

  static Inject get to => Inject<TabsModule>.of();

}