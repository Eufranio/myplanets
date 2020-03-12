import 'package:flutter/cupertino.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/views/info/galaxy/new_galaxy.dart';

import 'model.dart';

class Galaxy extends Model {

  String id,
      name,
      distance;

  int systemCount;

  List<String> systems;

  Galaxy({this.id, this.name, this.distance, this.systemCount, this.systems});

  Galaxy.fromMap(String id, Map snapshot) :
        id = id,
        name = snapshot['name'],
        distance = snapshot['distance'],
        systemCount = int.parse(snapshot['systemCount'] == 'null' ? '0' : snapshot['systemCount']),
        systems = snapshot['systems'] ?? [];

  toJson() {
    return {
      "name": name,
      "distance": distance,
      "systemCount": systemCount.toString(),
      "systems": systems
    };
  }

  Widget getInfo() => null;

  Widget getEdit() => EditModelScreen(this, () => Galaxy(), () => EditGalaxyState());

}