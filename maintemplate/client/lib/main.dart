import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/app_module.dart';
import 'package:maintemplate/layout_template.dart';
import 'package:provider/provider.dart' as provider;

import '././core/core.dart';
import 'modules/settings/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /*
      init settings view model before starting app
   */

  var settingsViewModel = SettingsViewModel();
  // get env.json from assets
  await settingsViewModel.fetchEnvVariables();
  runApp(
    provider.ChangeNotifierProvider<SettingsViewModel>(
        create: (context) => settingsViewModel,
        child: ModularApp(
          module: AppModule(
              // not convinced if this is the right place to do this url config ...
              url:
                  "maintemplate.${settingsViewModel.envVariables.channel}.getcouragenow.org"),
        )),
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
    final model = provider.Provider.of<SettingsViewModel>(context);
    _delegate = AppLocalizationsDelegate(model.locale);

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
