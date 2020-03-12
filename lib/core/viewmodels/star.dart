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

  Star({this.id, this.name, this.age, this.size, this.distance, this.death, this.type});

  Star.fromMap(String id, Map snapshot) :
        id = id,
        name = snapshot['name'],
        age = snapshot['age'],
        size = snapshot['size'],
        distance = snapshot['distance'],
        death = snapshot['death'],
        type = StarType.values[snapshot['type']];

  toJson() {
    return {
      "name": name,
      "age": age,
      "size": size,
      "distance": distance,
      "death": death,
      "type": type.index
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