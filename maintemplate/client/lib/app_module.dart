



import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/main.dart';
import 'package:maintemplate/modules/startup/views/startup_view.dart';
import 'package:mod_chat/mod_chat.dart';
//import 'package:mod_chat_beta/mod_chat.dart' as chatBeta;
import 'package:mod_geo/mod_geo.dart';
import 'package:mod_ion/ion_module.dart';
import 'package:mod_main/modules/mod_main.dart';
import 'package:mod_session/mod_session.dart';
import 'package:mod_write/mod_write.dart';
import 'package:mod_write/writer_module.dart';
import 'package:mod_account/modules/mod_account.dart';

import 'core/core.dart';
import 'modules/settings/settings_module.dart';

class AppModule extends MainModule {
  final String url;
  final String urlNative;

  AppModule({this.url, this.urlNative});

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
        Router(Paths.startup, child: (_, args) => StartupView()),
        Router(Paths.modAccount, module: AccountModule(Paths.modAccount)),
        Router(Paths.modMain, module: MainAppModule(Paths.modMain)),
        Router(Paths.chat,
            module: ChatModule(Paths.chat,
                deviceID: SessionModule.deviceID, url: url, urlNative: urlNative)),
        Router(Paths.ion,
            module: IonModule(Paths.ion,
                deviceID: SessionModule.deviceID,
                userAgent: SessionModule.deviceUserAgent)),
        //Router(Paths.chat_beta, module: chatBeta.ModChatModule()),
        Router(Paths.modWriter, module: ModWriterModule(Paths.modWriter)),
        Router(Paths.modGeo, module: GeoModule(Paths.modGeo)),
        Router(Paths.settings, module: SettingsModule()),
      ];

// add your main widget here
  @override
  Widget get bootstrap => App();
}
