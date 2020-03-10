

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_main/modules/splash/splash_module.dart';
import 'package:mod_main/modules/userinfo/userInfo_module.dart';

import 'core/core.dart';
import 'main.dart';
import 'modules/campaign/campaign_module.dart';

class AppModule extends MainModule{
  @override
  List<Bind> get binds => [];

  
  @override
  Widget get bootstrap => App();
  
  @override
  List<Router> get routers => [
    Router('/', module: SplashModule()),
    Router(Paths.userInfo, module: UserInfoModule()),
     Router(Paths.campaigns, module: CampaignModule()),
  ];

}