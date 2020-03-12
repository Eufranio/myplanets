import 'package:flutter/cupertino.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/views/info/system/new_system.dart';

import 'model.dart';

class System extends Model {

  String id,
      name,
      age;

  int get planetCount => this.planets.length;
  int get starCount => this.stars.length;

  List<String> planets, stars;

  System({this.id, this.name, this.age, this.planets, this.stars});

  System.fromMap(String id, Map snapshot) :
        id = id,
        name = snapshot['name'],
        age = snapshot['age'],
        planets = List.from(snapshot['planets'] ?? []),
        stars = List.from(snapshot['stars'] ?? []);

  toJson() {
    return {
      "name": name,
      "age": age,
      "planets": planets,
      "stars": stars
    };
  }

  Widget getInfo() => null;

  Widget getEdit() => EditModelScreen(this, () => System(), () => EditSystemState());

}