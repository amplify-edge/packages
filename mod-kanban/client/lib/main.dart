import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:modkanban/core/i18n/app_localization.dart';
import 'package:modkanban/features/i18n_example/i18n_view.dart';
import 'package:modkanban/features/master_detail_scaffold_example/data/mock_item.dart';
import 'package:modkanban/features/master_detail_scaffold_example/master_detail_view.dart';
import 'package:modkanban/features/responsive_scaffold_example/responsive_scaffold_view.dart';
import 'package:modkanban/features/grpc_web_example/grpc_web_view.dart';
import 'package:provider/provider.dart';

import 'package:modkanban/features/i18n_json_example/i18n_view.dart';
import 'package:modkanban/features/navigation_rail/navigation_rail.dart';

import 'package:modkanban/features/grpc_web_example/blocs/bloc.dart';
import 'package:modkanban/features/grpc_web_example/blocs/bloc_provider.dart';
import 'package:modkanban/features/grpc_web_example/blocs/message_events.dart';

import 'features/responvive_builder_example/responsive_template.dart';

void main() => runApp(Provider<List<MockItem>>(
    create: (context) => mockItemsList,
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: App(),
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
    )));

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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BlocProvider<GRPCWebBloc>(
                  bloc: GRPCWebBloc(),
                  child: GRPCWebApp(),
                );
              }));
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
