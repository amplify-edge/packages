

import 'package:flutter_modular/flutter_modular.dart';
import 'views/splash_view.dart';

class SplashModule extends ChildModule{

  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
    Router('/', child: (_, args) => SplashView())
  ];


  static Inject get to => Inject<SplashModule>.of();

}