import 'package:flutter/cupertino.dart';

import 'model.dart';

class Star extends Model {

  String id,
      name,
      age,
      size,
      distance,
      death;

  StarType type;

  bool isBlackHole;

  List<String> systems;

  Star({this.id, this.name, this.age, this.size, this.distance, this.death, this.type, this.systems});

  Star.fromMap(String id, Map snapshot) :
        id = id,
        name = snapshot['name'],
        age = snapshot['age'],
        size = snapshot['size'],
        distance = snapshot['distance'],
        death = snapshot['death'],
        type = StarType.values[snapshot['type']],
        systems = List.from(snapshot['systems'] ?? []);

  toJson() {
    return {
      "name": name,
      "age": age,
      "size": size,
      "distance": distance,
      "death": death,
      "type": type.index,
      "systems": systems
    };
  }

  Widget getInfo() => null;

  Widget getEdit() => null;

}

enum StarType {
  RedDwarf,
  WhiteDwarf,
  BinaryStar,
  BlueGiant,
  RedGiant
}