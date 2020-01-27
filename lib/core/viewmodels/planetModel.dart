import 'model.dart';
import 'package:flutter/material.dart';
import 'package:planets/ui/views/info/planet/planet_info.dart';
import 'package:planets/ui/views/info/planet/new_planet.dart';

class Planet extends Model {

  String id,
      name,
      size,
      weight,
      gravity,
      description;

  Planet({this.id, this.name, this.size, this.weight, this.gravity, this.description});

  Planet.fromMap(String id, Map snapshot) :
        id = id,
        name = snapshot['name'],
        size = snapshot['size'],
        weight = snapshot['weight'],
        gravity = snapshot['gravity'],
        description = snapshot['description'];

  toJson() {
    return {
      "name": name,
      "size": size,
      "weight": weight,
      "gravity": gravity,
      "description": description
    };
  }

  @override
  Widget getInfoScreen() {
    return PlanetInfoScreen(planet: this);
  }

  Widget getNewPlanet() {
    return EditPlanetScreen(planet: this);
  }

}