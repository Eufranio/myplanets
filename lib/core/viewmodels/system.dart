import 'package:flutter/cupertino.dart';

import 'model.dart';

class System extends Model {

  String id,
      name,
      age;

  int planetCount,
      starCount;

  List<String> planets, stars;

  System({this.id, this.name, this.age, this.planetCount, this.starCount, this.planets, this.stars});

  System.fromMap(String id, Map snapshot) :
        id = id,
        name = snapshot['name'],
        age = snapshot['age'],
        planetCount = int.parse(snapshot['planetCount']),
        starCount = int.parse(snapshot['starCount']),
        planets = snapshot['planets'],
        stars = snapshot['stars'];

  toJson() {
    return {
      "name": name,
      "age": age,
      "planetCount": planetCount.toString(),
      "starCount": starCount.toString(),
      "planets": planets,
      "stars": stars
    };
  }

  Widget getInfo() => null;

  Widget getEdit() => null;

}