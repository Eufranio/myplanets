import 'package:planets/core/api/database_api.dart';
import 'package:planets/core/viewmodels/galaxy.dart';
import 'package:planets/core/viewmodels/naturalSatellite.dart';
import 'package:planets/core/viewmodels/orbit.dart';
import 'package:planets/core/viewmodels/planetModel.dart';
import 'package:planets/core/viewmodels/system.dart';
import 'package:planets/core/viewmodels/star.dart';

abstract class ObjectManager<T> extends Api {
  ObjectManager(String db) : super(db);
  T build(String id, Map map);
  Map toJson(T obj);
}


// planet
class Planets extends ObjectManager<Planet> {
  Planets() : super('planets');

  @override
  Planet build(String id, Map map) => Planet.fromMap(id, map);

  @override
  Map toJson(Planet obj) => obj.toJson();
}


// galaxy
class Galaxies extends ObjectManager<Galaxy> {
  Galaxies() : super('galaxies');

  @override
  Galaxy build(String id, Map map) => Galaxy.fromMap(id, map);

  @override
  Map toJson(Galaxy obj) => obj.toJson();
}


// system
class Systems extends ObjectManager<System> {
  Systems() : super('systems');

  @override
  System build(String id, Map map) => System.fromMap(id, map);

  @override
  Map toJson(System obj) => obj.toJson();
}


// star
class Stars extends ObjectManager<Star> {
  Stars() : super('stars');

  @override
  Star build(String id, Map map) => Star.fromMap(id, map);

  @override
  Map toJson(Star obj) => obj.toJson();
}


// satellite
class Satellites extends ObjectManager<NaturalSatellite> {
  Satellites() : super('satellites');

  @override
  NaturalSatellite build(String id, Map map) => NaturalSatellite.fromMap(id, map);

  @override
  Map toJson(NaturalSatellite obj) => obj.toJson();
}

// orbits
class Orbits extends ObjectManager<Orbit> {
  Orbits() : super('orbits');

  @override
  Orbit build(String id, Map map) => Orbit.fromMap(id, map);

  @override
  Map toJson(Orbit obj) => obj.toJson();
}