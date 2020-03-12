import 'package:flutter/cupertino.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/views/info/galaxy/galaxy_info.dart';
import 'package:planets/ui/views/info/galaxy/new_galaxy.dart';
import 'package:planets/ui/views/info/info_model.dart';

import 'model.dart';

class Galaxy extends Model {

  String id,
      name,
      distance;

  List<String> systems;

  int get systemCount => this.systems.length;

  Galaxy({this.id, this.name, this.distance, this.systems});

  Galaxy.fromMap(String id, Map snapshot) :
        id = id,
        name = snapshot['name'],
        distance = snapshot['distance'],
        systems = List.from(snapshot['systems'] ?? []);

  toJson() {
    return {
      "name": name,
      "distance": distance,
      "systems": systems
    };
  }

  Widget getInfo() => InfoModelScreen(this, () => GalaxyInfoState());

  Widget getEdit() => EditModelScreen(this, () => Galaxy(), () => EditGalaxyState());

}