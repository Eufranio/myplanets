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
import 'package:planets/locator.dart';
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

  @override
  void onDelete() async {
    var galaxyProvider = Provider.of<GalaxyCRUD>(context, listen: false);
    await galaxyProvider.getById(editingModel.galaxy).then((value) {
          var galaxy = value as Galaxy;
          galaxy.systems.remove(editingModel.id);
          galaxyProvider.update(galaxy, galaxy.id);
        });

    var planetProvider = Provider.of<PlanetCRUD>(context, listen: false);
    editingModel.planets.forEach((id) =>
        planetProvider.getById(id).then((value) {
          var planet = value as Planet;
          planet.systems.remove(editingModel.id);
          planetProvider.update(planet, planet.id);
        }));

    var starProvider = Provider.of<StarCRUD>(context, listen: false);
    editingModel.stars.forEach((id) =>
        starProvider.getById(id).then((value) {
          var star = value as Star;
          star.systems.remove(editingModel.id);
          starProvider.update(star, star.id);
        }));
  }

  @override
  Widget getImage() => Container(
    width: 350,
    height: 250,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage('assets/system.png'), fit: BoxFit.contain),),
  );

  @override
  Future<bool> save(context) async {
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

    return true;
  }

  @override
  void postSave() async {
    editingModel.planets ??= [];
    editingModel.stars ??= [];

    var planetProvider = locator<PlanetCRUD>();
    editingModel.planets.forEach((id) async {
      var planet = await planetProvider.getById(id).then((value) => value as Planet);
      if (!planet.systems.contains(editingModel.id)) {
        planet.systems.add(editingModel.id);
        await planetProvider.update(planet, planet.id);
      }
    });

    var starProvider = locator<StarCRUD>();
    editingModel.stars.forEach((id) async {
      var star = await starProvider.getById(id).then((value) => value as Star);
      if (!star.systems.contains(editingModel.id)) {
        star.systems.add(editingModel.id);
        await starProvider.update(star, star.id);
      }
    });

    var galaxyProvider = locator<GalaxyCRUD>();
    var galaxy = await galaxyProvider.getById(editingModel.galaxy).then((value) => value as Galaxy);
    if (!galaxy.systems.contains(editingModel.id)) {
      galaxy.systems.add(editingModel.id);
      await galaxyProvider.update(galaxy, galaxy.id);
    }
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
            var galaxies = Map.fromIterable(snapshot.data.cast<Galaxy>(), key: (e) => e.id, value: (e) => e);
            return CustomDropdownButtonFormField(
              onSaved: (val) {
                if (editingModel.galaxy != null) {
                  var previousGalaxy = galaxies[editingModel.galaxy];
                  previousGalaxy.systems.remove(editingModel.id);
                  galaxyCrud.update(previousGalaxy, previousGalaxy.id);
                }
                editingModel.galaxy = val?.id;
              },
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