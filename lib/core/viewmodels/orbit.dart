import 'package:flutter/material.dart';
import 'package:planets/core/api/crud.dart';
import 'package:planets/core/services/planetCrud.dart';
import 'package:planets/core/services/satelliteCrud.dart';
import 'package:planets/core/services/starCrud.dart';
import 'package:planets/core/viewmodels/model.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/views/info/orbit/new_orbit.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget getInfo() => null;

  @override
  Widget getEdit() => EditModelScreen(this, () => Orbit(), () => EditOrbitState());

  @override
  Widget getDisplayButton(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        getName(Provider.of<PlanetCRUD>(context, listen: false), this.planet),
        getName(Provider.of<SatelliteCRUD>(context, listen: false), this.satellite),
        getName(Provider.of<StarCRUD>(context, listen: false), this.star)
      ],
    );
  }
  
  Widget getName(CRUD crud, String id) {
    if (id == null || id.isEmpty) return SizedBox.shrink();
    return FutureBuilder(
        future: crud.getById(id),
        builder: (context, AsyncSnapshot<Model> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.name, style: TextStyle(fontSize: 25));
          }
          return Text('Loading');
        }
    );
  }



}