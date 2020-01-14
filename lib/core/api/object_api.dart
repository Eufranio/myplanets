import 'package:planets/core/api/database_api.dart';
import 'package:planets/core/viewmodels/planetModel.dart';

abstract class ObjectManager<T> extends Api {
  ObjectManager(String db) : super(db);
  T build(String id, Map map);
  Map toJson(T obj);
}

class Planets extends ObjectManager<Planet> {
  Planets() : super('planets');

  @override
  Planet build(String id, Map map) => Planet.fromMap(id, map);

  @override
  Map toJson(Planet obj) => obj.toJson();
}