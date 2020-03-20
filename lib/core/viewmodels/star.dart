import 'package:flutter/cupertino.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/views/info/info_model.dart';
import 'package:planets/ui/views/info/star/new_star.dart';
import 'package:planets/ui/views/info/star/star_info.dart';

import 'model.dart';

class Star extends Model {

  String id,
      name,
      age,
      size,
      distance;

  bool died;

  List<String> systems;

  StarType type;

  Star({this.id, this.name, this.age, this.size, this.distance, this.type, this.died});

  Star.fromMap(String id, Map snapshot) :
        id = id,
        name = snapshot['name'],
        age = snapshot['age'],
        size = snapshot['size'],
        distance = snapshot['distance'],
        died = snapshot['died'],
        type = StarType.values[snapshot['type']],
        systems = List.from(snapshot['systems'] ?? []);

  toJson() {
    return {
      "name": name,
      "age": age,
      "size": size,
      "distance": distance,
      "died": died,
      "type": type.index,
      "systems": systems
    };
  }

  Widget getInfo() => InfoModelScreen(this, () => StarInfoState());

  Widget getEdit() => EditModelScreen(this, () => Star(), () => EditStarState());

}

enum StarType {
  RedDwarf,
  WhiteDwarf,
  BinaryStar,
  BlueGiant,
  RedGiant
}