import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../app_module.dart';
import 'folder_view.dart';

class FolderModule extends ChildModule {
  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router("/", child: (_, args) => FolderView()),
        Router("/page1",
            child: (_, args) => Page1(), transition: TransitionType.rightToLeft),
        Router("/page2",
            child: (_, args) => Page2(),
            transition: TransitionType.leftToRight),
      ];

  static Inject get to => Inject<FolderModule>.of();
}
