import 'package:flutter/cupertino.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/views/info/info_model.dart';
import 'package:planets/ui/views/info/system/new_system.dart';
import 'package:planets/ui/views/info/system/system_info.dart';

import 'model.dart';

class System extends Model {

  String id,
      name,
      age,
      galaxy;

  int get planetCount => this.planets.length;
  int get starCount => this.stars.length;

  List<String> planets, stars;

  System({this.id, this.name, this.age, this.planets, this.stars});

  System.fromMap(String id, Map snapshot) :
        id = id,
        name = snapshot['name'],
        age = snapshot['age'],
        planets = List.from(snapshot['planets'] ?? []),
        stars = List.from(snapshot['stars'] ?? []),
        galaxy = snapshot['galaxy'];

  toJson() {
    return {
      "name": name,
      "age": age,
      "planets": planets,
      "stars": stars,
      "galaxy": galaxy
    };
  }

  Widget getInfo() => InfoModelScreen(this, () => SystemInfoState());

  Widget getEdit() => EditModelScreen(this, () => System(), () => EditSystemState());

}