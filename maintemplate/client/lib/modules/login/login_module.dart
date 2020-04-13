

import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/core/core.dart';

import 'login.dart';

class LoginModule extends ChildModule{
  @override
  List<Bind> get binds => [

  ];

  @override
  List<Router> get routers => [
    Router(Paths.login, child: (context, args) => LoginView())
  ];

  static Inject get to => Inject<LoginModule>.of();

}