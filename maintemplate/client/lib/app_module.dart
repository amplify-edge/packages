// extends from MainModule
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/main.dart';
import 'package:maintemplate/modules/startup/views/startup_view.dart';
import 'package:mod_chat/mod_chat.dart';
import 'package:mod_geo/mod_geo.dart';
import 'package:mod_ion/ion_module.dart';
<<<<<<< Updated upstream
import 'package:mod_main/modules/mod_main.dart';
import 'package:mod_session/mod_session.dart';
import 'package:mod_write/mod_write.dart';
=======
import 'package:mod_write/writer_module.dart';
>>>>>>> Stashed changes

import 'core/core.dart';
import 'modules/settings/settings_module.dart';

class AppModule extends MainModule {
<<<<<<< Updated upstream
  final String url;

  AppModule({this.url});

=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        Router(Paths.startup, child: (_, args) => StartupView()),
        Router(Paths.modMain, module: MainAppModule(Paths.modMain)),
        Router(Paths.chat,
            module: ChatModule(Paths.chat,
                deviceID: SessionModule.deviceID, url: url)),
        Router(Paths.ion,
            module: IonModule(Paths.ion,
                deviceID: SessionModule.deviceID,
                userAgent: SessionModule.deviceUserAgent)),
=======
        Router(Paths.home, module: HomeModule()),
        Router(Paths.chat, module: ModChatModule()),
        Router(Paths.ion, module: IonModule(Paths.ion)),
        Router(Paths.writer, module: WriterModule()),
>>>>>>> Stashed changes
        Router(Paths.modWriter, module: ModWriterModule(Paths.modWriter)),
        Router(Paths.modGeo, module: GeoModule(Paths.modGeo)),
        Router(Paths.settings, module: SettingsModule()),
      ];

// add your main widget here
  @override
  Widget get bootstrap => App();
}
