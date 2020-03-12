import 'package:flutter/cupertino.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/views/info/info_model.dart';
import 'package:planets/ui/views/info/satellite/new_satellite.dart';
import 'package:planets/ui/views/info/satellite/satellite_info.dart';

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
        planets = snapshot['planets'] ?? [],
        stars  = snapshot['stars'] ?? [];

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

  Widget getInfo() => InfoModelScreen(this, () => SatelliteInfoState());

  Widget getEdit() => EditModelScreen(this, () => NaturalSatellite(), () => EditSatelliteState());

}