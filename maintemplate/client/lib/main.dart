import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:maintemplate/app_module.dart';
import 'package:maintemplate/layout_template.dart';
import 'package:mod_main/core/i18n/mod_main_localization.dart';
import 'package:mod_account/core/i18n/mod_account_localization.dart';
import 'package:mod_chat/core/i18n/mod_chat_localization.dart';
import 'package:provider/provider.dart' as provider;

import '././core/core.dart';
import 'core/events/event_listener.dart';
import 'modules/settings/settings.dart';

// Bottom Up approach .....
import 'package:mod_geo/core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // init settings view model before starting app
  var settingsViewModel = SettingsViewModel();
  // get env.json from assets
  await settingsViewModel.fetchEnvVariables();

  runApp(provider.ChangeNotifierProvider<SettingsViewModel>(
    create: (context) => settingsViewModel,
    child: ModularApp(
        module: AppModule(
      // not convinced if this is the right place to do this url config ...
      url: settingsViewModel.envVariables.url,
      urlNative: settingsViewModel.envVariables.urlNative,
    )),
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AppLocalizationsDelegate _delegate;
  ModGeoAppLocalizationsDelegate _modGeoADelegate;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = provider.Provider.of<SettingsViewModel>(context);
    _delegate = AppLocalizationsDelegate(model.locale);
    _modGeoADelegate = ModGeoAppLocalizationsDelegate(model.locale);

    print("${_delegate.overriddenLocale} delegate");
    print("${_modGeoADelegate.overriddenLocale} delegate");


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => LayoutTemplate(body: child),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: model.themeMode,
      initialRoute: Paths.startup,
      onGenerateRoute: Modular.generateRoute,
      navigatorKey: Modular.navigatorKey,
      localizationsDelegates: [
        _delegate,
        _modGeoADelegate,
        ModAccountLocalizationsDelegate(model.locale),
        ModMainLocalizationsDelegate(model.locale),
        ModChatLocalizationsDelegate(model.locale),
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
      ],
      locale: (model.locale == Locale('system') ? null : model.locale),
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('de'),
        Locale('ur'),
      ],
    );
  }
}
