

import 'package:get_it/get_it.dart';

import 'core/core.dart';
import 'modules/settings/settings.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());

}