import 'package:flutter/cupertino.dart';

import 'model.dart';

class System extends Model {

  String id,
      name,
      age,
      size,
      distance,
      death;

  int type;

  bool isBlackHole;

  System({this.id, this.name, this.age, this.size, this.distance, this.death, this.type, this.isBlackHole});

  System.fromMap(String id, Map snapshot) :
        id = id,
        name = snapshot['name'],
        age = snapshot['age'],
        size = snapshot['size'],
        distance = snapshot['distance'],
        death = snapshot['death'],
        type = int.parse(snapshot['type']),
        isBlackHole = bool.fromEnvironment(snapshot['isBlackHole']);

  toJson() {
    return {
      "name": name,
      "age": age,
      "distance": distance,
      "death": death,
      "type": type.toString(),
      isBlackHole: isBlackHole.toString()
    };
  }

  Widget getInfo() => null;

  Widget getEdit() => null;

}