

import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/core/core.dart';

import 'home.dart';

class HomeModule extends ChildModule{
  @override
  List<Bind> get binds => [

  ];

  @override
  List<Router> get routers => [
    Router(Paths.home, child: (context, args) => HomeView())
  ];


  static Inject get to => Inject<HomeModule>.of();

}