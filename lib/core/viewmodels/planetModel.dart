import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/views/info/info_model.dart';
import 'package:planets/ui/views/info/planet/new_planet.dart';

import 'model.dart';
import 'package:flutter/material.dart';
import 'package:planets/ui/views/info/planet/planet_info.dart';

class Planet extends Model {

  String id,
      name,
      size,
      weight,
      gravity,
      composition;

  List<String> systems;

  Planet({this.id, this.name, this.size, this.weight, this.gravity, this.composition, this.systems});

  Planet.fromMap(String id, Map snapshot) :
        id = id,
        name = snapshot['name'],
        size = snapshot['size'],
        weight = snapshot['weight'],
        gravity = snapshot['gravity'],
        composition = snapshot['description'],
        systems = List.from(snapshot['systems'] ?? []);

  toJson() {
    return {
      "name": name,
      "size": size,
      "weight": weight,
      "gravity": gravity,
      "description": composition,
      "systems": systems
    };
  }

  @override
  Widget getInfo() {
    return InfoModelScreen(this, () => PlanetInfoState());
  }

  Widget getEdit() {
    return EditModelScreen(this, () => Planet(), () => EditPlanetState());
  }

}