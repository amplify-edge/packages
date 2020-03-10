

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/core/core.dart';

import 'views/userinfo_view.dart';

class UserInfoModule extends ChildModule{

  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
    Router(Paths.userInfo, child: (_, args) => UserInfoView())
  ];


  static Inject get to => Inject<UserInfoModule>.of();

}