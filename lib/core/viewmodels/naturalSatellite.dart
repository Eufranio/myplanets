import 'package:flutter/cupertino.dart';

import 'model.dart';

class NaturalSatellite extends Model {

  String id,
      name,
      composition,
      size,
      weight;

  List<String> planets, stars;

  NaturalSatellite({this.id, this.name, this.composition, this.size, this.weight, this.planets, this.stars});

  NaturalSatellite.fromMap(String id, Map snapshot) :
        id = id,
        name = snapshot['name'],
        composition = snapshot['composition'],
        size = snapshot['size'],
        weight = snapshot['weight'],
        planets = snapshot['planets'],
        stars  = snapshot['stars'];

  toJson() {
    return {
      "name": name,
      "composition": composition,
      "size": size,
      "weight": weight,
      "planets": planets,
      "stars": stars
    };
  }

  Widget getInfo() => null;

  Widget getEdit() => null;

}