import 'package:get_it/get_it.dart';
import 'package:planets/core/api/object_api.dart';
import 'package:planets/core/services/planetCrud.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Planets());
  locator.registerLazySingleton(() => PlanetCRUD());
}