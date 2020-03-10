import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planets/core/services/orbitCrud.dart';
import 'package:planets/core/services/planetCrud.dart';
import 'package:planets/core/services/satelliteCrud.dart';
import 'package:planets/core/services/starCrud.dart';
import 'package:planets/core/viewmodels/naturalSatellite.dart';
import 'package:planets/core/viewmodels/orbit.dart';
import 'package:planets/core/viewmodels/planetModel.dart';
import 'package:planets/core/viewmodels/star.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';

class EditOrbitState extends EditModelScreenState<Orbit, OrbitCRUD> {

  var planets = List<Planet>();
  var stars = List<Star>();
  var satellites = List<NaturalSatellite>();

  InputDecoration decoration = InputDecoration(
      fillColor: Colors.white.withOpacity(0.5),
      filled: true,
      border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10))
  );

  @override
  Iterable<Widget> getFields() {
    var planetProvider = Provider.of<PlanetCRUD>(context, listen: false);
    Widget planet = planets.isNotEmpty ? buildPlanetList() : StreamBuilder(
      stream: planetProvider.fetchAsStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          planets = snapshot.data.documents
              .map((doc) => planetProvider.api.build(doc.documentID, doc.data))
              .toList();
          return buildPlanetList();
        }
        return Text('Loading');
      },
    );

    var starProvider = Provider.of<StarCRUD>(context, listen: false);
    Widget star = stars.isNotEmpty ? buildStarList() : StreamBuilder(
      stream: starProvider.fetchAsStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          stars = snapshot.data.documents
              .map((doc) => starProvider.api.build(doc.documentID, doc.data))
              .toList();
          return buildStarList();
        }
        return Text('Loading');
      },
    );

    var satelliteProvider = Provider.of<SatelliteCRUD>(context, listen: false);
    Widget satellite = satellites.isNotEmpty ? buildSatelliteList() : StreamBuilder(
      stream: satelliteProvider.fetchAsStream(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          satellites = snapshot.data.documents
              .map((doc) => satelliteProvider.api.build(doc.documentID, doc.data))
              .toList();
          return buildSatelliteList();
        }
        return Text('Loading');
      },
    );

    return [
      SizedBox(
        height: 50, width: 320,
        child: planet,
      ),
      SizedBox(
        height: 50, width: 320,
        child: star,
      ),
      SizedBox(
        height: 50, width: 320,
        child: satellite,
      )
    ];
  }

  Widget buildPlanetList() {
    return CustomDropdownButtonFormField(
      onSaved: (val) => editingModel.planet = val.id,
      onChanged: (_) {},
      decoration: decoration.copyWith(hintText: 'bondia'),
      items: planets.map((planet) => DropdownMenuItem(
        value: planet,
        child: Text(planet.name),
      )).toList(),
    );
  }

  Widget buildStarList() {
    return CustomDropdownButtonFormField(
      onSaved: (val) => editingModel.star = val.id,
      onChanged: (_) {},
      decoration: decoration.copyWith(hintText: 'bondia'),
      items: stars.map((star) => DropdownMenuItem(
        value: star,
        child: Text(star.name),
      )).toList(),
    );
  }

  Widget buildSatelliteList() {
    return CustomDropdownButtonFormField(
      onSaved: (val) => editingModel.satellite = val.id,
      onChanged: (_) {},
      decoration: decoration.copyWith(hintText: 'bondia'),
      items: satellites.map((satellite) => DropdownMenuItem(
        value: satellite,
        child: Text(satellite.name),
      )).toList(),
    );
  }

  @override
  String getTitle() {
    return 'Órbita';
  }

}