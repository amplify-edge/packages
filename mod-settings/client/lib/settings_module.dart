import 'package:flutter_modular/flutter_modular.dart';
import 'package:mod_settings/src/settings_view.dart';

class SettingsModule extends ChildModule {
  SettingsModule() {
//    CoreSettings.instance.registerModuleConfig(config);
  }

  @override
  List<Bind> get binds => [];

  @override
  List<Router> get routers => [
        Router("/", child: (_, args) => SettingsViewNew()),
      ];

  static Inject get to => Inject<SettingsModule>.of();
}
