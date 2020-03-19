import 'package:flutter/material.dart';
import 'package:planets/core/services/galaxyCrud.dart';
import 'package:planets/core/services/planetCrud.dart';
import 'package:planets/core/services/starCrud.dart';
import 'package:planets/core/services/systemCrud.dart';
import 'package:planets/core/viewmodels/galaxy.dart';
import 'package:planets/core/viewmodels/model.dart';
import 'package:planets/core/viewmodels/planetModel.dart';
import 'package:planets/core/viewmodels/star.dart';
import 'package:planets/core/viewmodels/system.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/widgets/custom_dropdown.dart';
import 'package:planets/ui/widgets/info_box.dart';
import 'package:planets/ui/widgets/relation_list.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/systemCrud.dart';


class EditSystemState extends EditModelScreenState<System, SystemCRUD> {

  static Function get shortInfo {
    return (System val) =>
        Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Row(
                children: <Widget>[
                  SizedBox(width: 120),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(val.name, style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            InfoBox(
                              value: Text(val.starCount.toString(), style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold)),
                              title: Text('Estrelas', style: TextStyle(
                                  fontSize: 10, color: Colors.deepPurple)),
                              size: 65,
                            ),
                            InfoBox(
                              value: Text(val.planetCount.toString(), style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold)),
                              title: Text('Planetas', style: TextStyle(
                                  fontSize: 10, color: Colors.deepPurple)),
                              size: 65,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ]
            )
        );
  }

  var planets = Map<String, Planet>();
  var stars = Map<String, Star>();
  var galaxies = Map<String, Galaxy>();

  @override
  bool save(context) {
    if (editingModel.galaxy == null) {
      showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text('Erro'),
                content: Text(
                    'Você precisa selecionar uma galáxia para criar um sistema planetário!'),
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

    if (this.planets.isNotEmpty)
      editingModel.planets.forEach((id) async {
        var planet = planets[id];
        if (!planet.systems.contains(editingModel.id)) {
          planet.systems.add(editingModel.id);
          await Provider.of<PlanetCRUD>(context, listen: false).update(
              planet, planet.id);
        }
      });

    if (this.stars.isNotEmpty)
      editingModel.stars.forEach((id) async {
        var star = stars[id];
        if (!star.systems.contains(editingModel.id)) {
          star.systems.add(editingModel.id);
          await Provider.of<StarCRUD>(context, listen: false).update(
              star, star.id);
        }
      });

    var galaxy = galaxies[editingModel.galaxy];
    galaxy.systems.add(editingModel.id);
    Provider.of<GalaxyCRUD>(context, listen: false).update(galaxy, galaxy.id);

    return true;
  }

  @override
  String getTitle() {
    return 'Sistema Panetário';
  }

  @override
  Iterable<Widget> getFields() {
    var planetProvider = Provider.of<PlanetCRUD>(context, listen: false);
    var starProvider = Provider.of<StarCRUD>(context, listen: false);
    var galaxyCrud = Provider.of<GalaxyCRUD>(context, listen: false);

    var nome = TextFormField(
      onSaved: (val) => editingModel.name = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.name,
      decoration: InputDecoration(
          labelText: 'Nome',
          labelStyle: style2,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none)),
    );

    var idade = TextFormField(
      onSaved: (val) => editingModel.age = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.age,
      decoration: InputDecoration(
          labelText: 'Idade',
          labelStyle: style2,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none)),
    );

    var planetsButton = RelationListButton(
      future: planetProvider.fetch(),
      isEmpty: editingModel.planets.isEmpty,
      title: 'Planetas',
      consumer: (list) =>
      planets = Map.fromIterable(
          list.cast<Planet>(), key: (e) => e.id, value: (e) => e),
      filter: (model) => editingModel.planets.contains(model.id),
      trailing: (model) =>
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                editingModel.planets.remove(model.id);
                Navigator.pop(context);
              }
          ),
    );

    var addPlanet = FlatButton(
      color: Colors.deepPurple[800],
      child: Icon(Icons.add, color: Colors.white),
      shape: CircleBorder(),
      onPressed: () =>
          showDialog(context: context, builder: (context) =>
              RelationListButton.buildDialog(
                  'Planetas', context, FutureList<Planet>(
                future: planetProvider.fetch(),
                nameFunction: (planet) => planet.name,
                onTap: (planet) {
                  if (!editingModel.planets.contains(planet.id))
                    editingModel.planets.add(planet.id);
                  Navigator.of(context).pop();
                },
              ))
          ),
    );


    // ESTRELAS


    var starsButton = RelationListButton(
        future: starProvider.fetch(),
        isEmpty: editingModel.stars.isEmpty,
        title: 'Estrelas',
        consumer: (list) =>
        this.stars = Map.fromIterable(
            list.cast<Star>(), key: (e) => e.id, value: (e) => e),
        filter: (model) => editingModel.stars.contains(model.id),
        trailing: (model) =>
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  editingModel.stars.remove(model.id);
                  Navigator.pop(context);
                }
            )
    );

    var addStar = FlatButton(
        color: Colors.deepPurple[800],
        child: Icon(Icons.add, color: Colors.white),
        shape: CircleBorder(),
        onPressed: () =>
            showDialog(context: context, builder: (context) =>
                RelationListButton.buildDialog(
                    'Estrelas', context, FutureList<Star>(
                  future: starProvider.fetch(),
                  nameFunction: (star) => star.name,
                  onTap: (star) {
                    if (!editingModel.stars.contains(star.id))
                      editingModel.stars.add(star.id);
                    Navigator.of(context).pop();
                  },
                ))
            )
    );

    var decoration = InputDecoration(
        fillColor: Colors.white.withOpacity(0.5),
        filled: true,
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10))
    );

    var galaxy = FutureBuilder(
      future: galaxyCrud.fetch(),
        builder: (context, AsyncSnapshot<List<Model>> snapshot) {
          if (snapshot.hasData) {
            this.galaxies = Map.fromIterable(snapshot.data.cast<Galaxy>(), key: (e) => e.id, value: (e) => e);
            return CustomDropdownButtonFormField(
              onSaved: (val) => editingModel.galaxy = val?.id,
              onChanged: (_) {},
              value: editingModel.galaxy == null ? null : galaxies[editingModel.galaxy],
              decoration: decoration.copyWith(hintText: 'Galáxia'),
              items: galaxies.values.map((galaxy) => DropdownMenuItem(
                value: galaxy,
                child: Text(galaxy.name ?? 'Unknown'),
              )).toList()
            );
          }
          return SizedBox.fromSize(size: Size.square(50), child: CircularProgressIndicator());
        }
    );

    return [
      SizedBox(height: 50, width: 320,
        child: nome,
      ),
      SizedBox(height: 20, width: 1,
      ),
      SizedBox(height: 50, width: 320,
        child: idade,
      ),
      SizedBox(height: 20, width: 0),
      SizedBox(height: 50, width: 320, child: galaxy),
      SizedBox(height: 20, width: 0),
      Padding(
        padding: EdgeInsets.only(left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 45, width: 115, child: planetsButton),
            SizedBox(height: 0, width: 1),
            SizedBox(height: 45, width: 55, child: addPlanet),
            SizedBox(height: 0, width: 20),
            SizedBox(height: 45, width: 115, child: starsButton),
            SizedBox(height: 0, width: 1),
            SizedBox(height: 45, width: 55, child: addStar),
          ],
        ),
      )
    ];
  }

  Widget buildDialog(bool isEmpty, String title, Widget child) {
    if (isEmpty)
      return AlertDialog(
        title: Text('Erro'),
        content: Text('Não há nada para listar!'),
        actions: <Widget>[
          FlatButton(onPressed: () => Navigator.of(context).pop(),
              child: Text('Fechar'))
        ],
      );
    return AlertDialog(
      title: Text(title),
      content: Container(
        width: double.maxFinite,
        child: child,
      ),
      actions: <Widget>[
        FlatButton(onPressed: () => Navigator.of(context).pop(),
            child: Text('Fechar'))
      ],
    );
  }

}