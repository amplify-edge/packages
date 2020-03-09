import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/app_module.dart';
import 'package:maintemplate/layout_template.dart';
import 'package:provider/provider.dart';

import '././core/core.dart';
import 'modules/settings/settings.dart';

void main() {

  runApp(
    ChangeNotifierProvider<SettingsViewModel>(
        create: (context) => SettingsViewModel(),
        child: ModularApp(module: AppModule())),
  );
}

class App extends StatefulWidget { 

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  AppLocalizationsDelegate _delegate;

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<SettingsViewModel>(context);
    _delegate =  AppLocalizationsDelegate(model.locale);

    print("${_delegate.overriddenLocale} delegate");

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => LayoutTemplate(body: child),
      
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: model.themeMode,
      initialRoute: Paths.home,
      onGenerateRoute: Modular.generateRoute,
      navigatorKey: Modular.navigatorKey,
      localizationsDelegates: [
        FallbackCupertinoLocalisationsDelegate(),
        _delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ],
      locale: (model.locale == Locale('system') ? null : model.locale),
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('ur'),
      ],
    );
  }
}
