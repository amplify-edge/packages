import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import 'package:maintemplate/core/i18n/app_localization.dart';
import 'package:maintemplate/features/i18n_example/i18n_view.dart';
import 'package:maintemplate/features/master_detail_scaffold_example/data/mock_item.dart';
import 'package:maintemplate/features/master_detail_scaffold_example/master_detail_view.dart';
import 'package:maintemplate/features/responsive_scaffold_example/responsive_scaffold_view.dart';

import 'package:mod_chat/mod_chat.dart';
import 'package:mod_chat/core/i18n/mod_chat_localization.dart';

import 'features/responvive_builder_example/responsive_template.dart';

void main() => runApp(ModularApp(
      key: Key("d"),
      module: AppModule(),
    ));

class AppModule extends MainModule {
  // here will be any class you want to inject into your project (eg bloc, dependency)
  @override
  List<Bind> get binds => [];

  // here will be the routes of your module
  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          "/",
          child: (context, args) => App(),
        ),
        ModularRouter(
          "/chat",
          module: ChatModule(
            "/chat",
            deviceID: "SessionModule.deviceID",
            url: "grpc url",
            urlNative: "grpc urlNative",
          ),
        )
      ];

// add your main widget here
  @override
  Widget get bootstrap => AppWidget();
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<List<MockItem>>(
      create: (context) => mockItemsList,
      child: MaterialApp(
        navigatorKey: Modular.navigatorKey,
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        onGenerateRoute: Modular.generateRoute,
        supportedLocales: [
          Locale('en', ''),
          Locale('de', ''),
          Locale('es', ''),
          Locale('fr', 'FR'),
          Locale('he', ''),
          Locale('zh-cn', ''),
        ],
        localizationsDelegates: [
          AppLocalizations.delegate,
          ModChatLocalizationsDelegate(Locale('en')),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        // localeResolutionCallback:
        //     (Locale locale, Iterable<Locale> supportedLocales) {
        //   for (var supportedLocale in supportedLocales) {
        //     if (locale.languageCode == supportedLocale.languageCode ||
        //         locale.countryCode == supportedLocale.countryCode) {
        //       return supportedLocale;
        //     }

        //     return supportedLocales.first;
        //   }
        // },
      ),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Flex(
      direction: Axis.vertical,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ResponsiveTemplate();
              }));
            },
            child: Container(
                child: Center(
              child: Text("Responsive Builder"),
            )),
          ),
        ),
        Divider(),
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ResponsiveScaffoldView();
              }));
            },
            child: Container(
                child: Center(
              child: Text("Responsive Scaffold"),
            )),
          ),
        ),
        Divider(),
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MasterDetailView();
              }));
            },
            child: Container(
                child: Center(
              child: Text("Master Detail Scaffold"),
            )),
          ),
        ),
        Divider(),
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return I18NView();
              }));
            },
            child: Container(
                child: Center(
              child: Text("Flutter Internationalization"),
            )),
          ),
        ),
        Divider(),
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              /* Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BlocProvider<GRPCWebBloc>(
                  bloc: GRPCWebBloc(),
                  child: GRPCWebApp(),
                );
              }));*/
              Navigator.pushNamed(context, "/chat");
            },
            child: Container(
                child: Center(
              child: Text("Flutter gRPC Web"),
            )),
          ),
        ),
      ],
    ));
  }
}
