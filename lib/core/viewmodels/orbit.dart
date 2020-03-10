import 'package:planets/core/viewmodels/model.dart';

class Orbit extends Model {

  String id,
      name,
      planet,
      star,
      satellite;

  Orbit({this.id, this.planet, this.star, this.satellite});

  Orbit.fromMap(String id, Map snapshot) :
        id = id,
        name = id,
        planet = snapshot['planet'],
        star = snapshot['star'],
        satellite = snapshot['satellite'];

  toJson() {
    return {
      "planet": planet,
      "star": star,
      "satellite": satellite
    };
  }

  getInfo() => null;

  getEdit() => null;

}