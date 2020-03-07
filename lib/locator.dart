import 'package:get_it/get_it.dart';
import 'package:planets/core/api/object_api.dart';
import 'package:planets/core/services/galaxyCrud.dart';
import 'package:planets/core/services/planetCrud.dart';
import 'package:planets/core/services/satelliteCrud.dart';
import 'package:planets/core/services/starCrud.dart';
import 'package:planets/core/services/systemCrud.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Planets());
  locator.registerLazySingleton(() => PlanetCRUD());

  locator.registerLazySingleton(() => Galaxies());
  locator.registerLazySingleton(() => GalaxyCRUD());

  locator.registerLazySingleton(() => Satellites());
  locator.registerLazySingleton(() => SatelliteCRUD());

  locator.registerLazySingleton(() => Stars());
  locator.registerLazySingleton(() => StarCRUD());

  locator.registerLazySingleton(() => Systems());
  locator.registerLazySingleton(() => SystemCRUD());
}