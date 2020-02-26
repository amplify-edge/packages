

import 'package:get_it/get_it.dart';

import 'core/core.dart';
import 'features/settings/settings.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerFactory(() => SettingsService());
  locator.registerFactory(() => SettingsRepository(
    settingsService: locator<SettingsService>()
  ));





}