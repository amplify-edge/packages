import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'widgets/pane.dart';

//IGNORE this file. It's purely for running/testing purposes. The useful
//module is in modules/main_module.dart.

Box<List<Map<String, dynamic>>> box;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    Hive.init((await getLibraryDirectory()).path);
  }
  box = await Hive.openBox<List<Map<String, dynamic>>>('messages');
  await box.clear();
  box.put('Joe Webb', [
    {
      'content': 'Hey! Joe here',
      'self': false,
      'isNew': false,
      'timeProcessed': DateTime.now().microsecondsSinceEpoch
    },
    {
      'content': 'Make sure to have this done by the end of this weekend. If '
          'you do not do it, I will end up being somewhat mad at you, so you best '
          'do the work ASAP.',
      'self': false,
      'isNew': true,
      'timeProcessed': DateTime.now().microsecondsSinceEpoch
    },
  ]);
  box.put('Saad', [
    {
      'content': 'Hey! Saad here',
      'self': false,
      'isNew': true,
      'timeProcessed': DateTime.now().microsecondsSinceEpoch
    },
    {
      'content':
          "I'll be working with you on the flutter components. Nice to meet you.",
      'self': false,
      'isNew': true,
      'timeProcessed': DateTime.now().microsecondsSinceEpoch
    },
  ]);
  box.put('Idir Makhouf', [
    {
      'content': 'Hey! Idir here',
      'self': false,
      'isNew': true,
      'timeProcessed': DateTime.now().microsecondsSinceEpoch
    },
    {
      'content': "What's up? My name is ___. Nice to meet you!",
      'self': true,
      'isNew': false,
      'timeProcessed': DateTime.now().microsecondsSinceEpoch
    },
  ]);
  runApp(ModularApp(module: AppModule()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messages Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/",
      // add Modular to manage the routing system
      onGenerateRoute: Modular.generateRoute,
    );
  }
}

class AppModule extends MainModule {
  // here will be any class you want to inject into your project (eg bloc, dependency)
  @override
  List<Bind> get binds => [];

  // here will be the routes of your module
  @override
  List<Router> get routers => [
        Router("/", child: (_, args) => PaneWidget(box)),
      ];

  // add your main widget here
  @override
  Widget get bootstrap => MyApp();
}
