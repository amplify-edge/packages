import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_kanban/core/i18n/mod_kanban_localization.dart';
import 'package:mod_kanban/kanban_module.dart';

void main() => runApp(ModularApp(
      module: AppModule(),
    ));

class AppModule extends MainModule {
  // here will be any class you want to inject into your project (eg bloc, dependency)
  @override
  List<Bind> get binds => [];

  // here will be the routes of your module
  @override
  List<Router> get routers => [
        Router(
          "/",
          module: KanbanModule("/"),
        )
      ];

// add your main widget here
  @override
  Widget get bootstrap => AppWidget();
}

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      // set your initial route
      initialRoute: "/",
      localizationsDelegates: [ModKanbanLocalizationsDelegate(Locale("en", "en"))],
      // add Modular to manage the routing system
      onGenerateRoute: Modular.generateRoute,
    );
  }
}
