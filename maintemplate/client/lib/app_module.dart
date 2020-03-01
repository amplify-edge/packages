// extends from MainModule
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/main.dart';
import 'package:maintemplate/modules/home/home.dart';

import 'core/core.dart';
import 'modules/chat/chat.dart';
import 'modules/chat/chat_module.dart';
import 'modules/ion/ion_module.dart';
import 'modules/login/login.dart';
import 'modules/settings/settings_module.dart';
import 'modules/startup/startup.dart';
import 'modules/writer/writer_module.dart';

class AppModule extends MainModule {
  // here will be any class you want to inject into your project (eg bloc, dependency)
  @override
  List<Bind> get binds => [];

  // here will be the routes of your module
  @override
  List<Router> get routers => [
        // Router(Paths.startup,
        //     child: (context, args) => StartupView(),
        //     transition: TransitionType.fadeIn),
        // Router(Paths.login,
        //     child: (context, args) => LoginView(),
        //     transition: TransitionType.fadeIn),
        Router(Paths.home, module: HomeModule()),
        Router(Paths.chat, module: ChatModule()),
        Router(Paths.ion, module: IonModule()),
        Router(Paths.writer, module: WriterModule()),
         Router(Paths.settings, module: SettingsModule()),
      ];

// add your main widget here
  @override
  Widget get bootstrap => App();
}
