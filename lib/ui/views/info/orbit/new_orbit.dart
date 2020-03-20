import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:planets/core/services/orbitCrud.dart';
import 'package:planets/core/services/planetCrud.dart';
import 'package:planets/core/services/satelliteCrud.dart';
import 'package:planets/core/services/starCrud.dart';
import 'package:planets/core/viewmodels/model.dart';
import 'package:planets/core/viewmodels/naturalSatellite.dart';
import 'package:planets/core/viewmodels/orbit.dart';
import 'package:planets/core/viewmodels/planetModel.dart';
import 'package:planets/core/viewmodels/star.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';

class EditOrbitState extends EditModelScreenState<Orbit, OrbitCRUD> {

  static Widget futureBuilder(future) {
    return FutureBuilder(
        future: future,
        builder: (context, AsyncSnapshot<Model> snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.name, style: TextStyle(fontSize: 25));
          }
          return SizedBox.fromSize(
              size: Size.square(10), child: CircularProgressIndicator());
        }
    );
  }

  static Function shortInfo(context) {
    var planetProvider = Provider.of<PlanetCRUD>(context, listen: false);
    var starProvider = Provider.of<StarCRUD>(context, listen: false);
    var satelliteProvider = Provider.of<SatelliteCRUD>(context, listen: false);

    return (Orbit val) =>
        Padding(
            padding: EdgeInsets.only(top: 8, bottom: 8, left: 30),
            child: SizedBox.expand(
              child: Row(
                children: <Widget>[
                  val.planet == null ? SizedBox.shrink() : futureBuilder(planetProvider.getById(val.planet)),
                  val.star == null ? SizedBox.shrink() : futureBuilder(starProvider.getById(val.star)),
                  val.satellite == null ? SizedBox.shrink() : futureBuilder(satelliteProvider.getById(val.satellite))
                ],
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              ),
            )
        );
  }

  var planets = List<Planet>();
  var stars = List<Star>();
  var satellites = List<NaturalSatellite>();

  var decoration = InputDecoration(
      fillColor: Colors.white.withOpacity(0.5),
      filled: true,
      border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10))
  );

  @override
  Future<bool> save(context) async {
    if ([editingModel.satellite == null,
      editingModel.star == null,
      editingModel.planet == null]
        .where((e) => e)
        .length >= 2) {
      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text('Erro'),
                content: Text(
                    'Você precisa selecionar pelo menos duas entidades para criar uma órbita!'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Fechar'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              )
      );
      return false;
    }

    var orbits = await Provider.of<OrbitCRUD>(context, listen: false).fetch().then((value) => value.cast<Orbit>());
    if (orbits.where((o) => o.planet == editingModel.planet &&
        o.satellite == editingModel.satellite &&
        o.star == editingModel.star).isNotEmpty) {
      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text('Erro'),
                content: Text(
                    'Essa órbita já existe!'),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Fechar'),
                    onPressed: () => Navigator.of(context).pop(),
                  )
                ],
              )
      );
      return false;
    }

    return true;
  }

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
      Padding(
        padding: EdgeInsets.fromLTRB(35, 20, 35, 20),
        child: SizedBox(
          height: 50, width: 320,
          child: star,
        )
      ),
      SizedBox(
        height: 50, width: 320,
        child: satellite,
      )
    ];
  }

  Widget buildPlanetList() {
    return CustomDropdownButtonFormField(
      onSaved: (val) => editingModel.planet = val?.id,
      onChanged: (_) {},
      value: editingModel.planet == null ? null : planets.firstWhere((e) => e.id == editingModel.planet, orElse: () => null),
      decoration: decoration.copyWith(hintText: 'Planeta'),
      items: planets.map((planet) => DropdownMenuItem(
        value: planet,
        child: Text(planet.name ?? 'Unknown'),
      )).toList() + [noneButton<Planet>(Planet())],
    );
  }

  Widget buildStarList() {
    return CustomDropdownButtonFormField(
      onSaved: (val) => editingModel.star = val?.id,
      onChanged: (_) {},
      value: editingModel.star == null ? null : stars.firstWhere((e) => e.id == editingModel.star, orElse: () => null),
      decoration: decoration.copyWith(hintText: 'Estrela'),
      items: stars.map((star) => DropdownMenuItem(
        value: star,
        child: Text(star.name ?? 'Unknown'),
      )).toList() + [noneButton<Star>(Star())],
    );
  }

  Widget buildSatelliteList() {
    return CustomDropdownButtonFormField(
      onSaved: (val) async {
        editingModel.satellite = val?.id;
      },
      onChanged: (_) {},
      value: editingModel.satellite == null ? null : satellites.firstWhere((e) => e.id == editingModel.satellite, orElse: () => null),
      decoration: decoration.copyWith(hintText: 'Satélite Natural'),
      items: satellites.map((satellite) => DropdownMenuItem(
        value: satellite,
        child: Text(satellite.name ?? 'Unknown'),
      )).toList() + [noneButton<NaturalSatellite>(NaturalSatellite())],
    );
  }
  
  DropdownMenuItem<T> noneButton<T>(T value) {
    return DropdownMenuItem<T>(
      value: value,
      child: Text('Nenhum')
    );
  }

  @override
  String getTitle() {
    return 'Órbita';
  }

}