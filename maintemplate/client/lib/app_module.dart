// extends from MainModule
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/main.dart';
import 'package:maintemplate/modules/home/home.dart';
import 'package:mod_chat/mod_chat.dart';
import 'package:mod_ion/ion_module.dart';

import 'core/core.dart';
import 'modules/login/login.dart';
import 'modules/settings/settings_module.dart';
import 'modules/startup/startup.dart';
import 'modules/writer/writer_module.dart';

import 'package:mod_write/writer_module.dart';

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
        Router(Paths.chat, module: ChatModule(Paths.chat)),
        Router(Paths.ion, module: IonModule(Paths.ion)),
        Router(Paths.writer, module: WriterModule()),
        Router(Paths.modWriter, module: ModWriterModule(Paths.modWriter)),
        Router(Paths.settings, module: SettingsModule()),
      ];

// add your main widget here
  @override
  Widget get bootstrap => App();
}
