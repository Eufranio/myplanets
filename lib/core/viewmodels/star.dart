import 'package:flutter/cupertino.dart';

import 'model.dart';

class Star extends Model {

  String id,
      name,
      age,
      size,
      distance,
      death,
      gravity;

  int type;

  bool isBlackHole;

  Star({this.id, this.name, this.age, this.size, this.distance, this.death, this.gravity, this.type, this.isBlackHole});

  Star.fromMap(String id, Map snapshot) :
        id = id,
        name = snapshot['name'],
        age = snapshot['age'],
        size = snapshot['size'],
        distance = snapshot['distance'],
        death = snapshot['death'],
        gravity = snapshot['gravity'],
        type = int.parse(snapshot['type']),
        isBlackHole = bool.fromEnvironment(snapshot['isBlackHole']);


  toJson() {
    return {
      "name": name,
      "age": age,
      "distance": distance,
      "death": death,
      "gravity": gravity,
      "type": type,

      isBlackHole: isBlackHole
    };
  }

  Widget getInfo() => null;

  Widget getEdit() => null;

}