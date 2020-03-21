import 'package:flutter/material.dart';
import 'package:planets/core/services/galaxyCrud.dart';
import 'package:planets/core/services/planetCrud.dart';
import 'package:planets/core/services/starCrud.dart';
import 'package:planets/core/services/systemCrud.dart';
import 'package:planets/core/viewmodels/galaxy.dart';
import 'package:planets/core/viewmodels/planetModel.dart';
import 'package:planets/core/viewmodels/star.dart';
import 'package:planets/core/viewmodels/system.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/widgets/info_box.dart';
import 'package:planets/ui/widgets/relation_list.dart';
import 'package:provider/provider.dart';

class EditGalaxyState extends EditModelScreenState<Galaxy, GalaxyCRUD> {

  static Function get shortInfo {
    return (Galaxy val) =>
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            InfoBox(
                              value: Text(val.distance, style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold)),
                              title: Text('Distância', style: TextStyle(
                                  fontSize: 10, color: Colors.deepPurple)),
                              size: 75,
                            ),
                            InfoBox(
                              value: Text(
                                  val.systemCount.toString(), style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold)),
                              title: Text('Sistemas', style: TextStyle(
                                  fontSize: 10, color: Colors.deepPurple)),
                              size: 75,
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

  var systems = Map<String, System>();

  @override
  void onDelete() async {
    var systemProvider = Provider.of<SystemCRUD>(context, listen: false);
    var planetProvider = Provider.of<PlanetCRUD>(context, listen: false);
    var starProvider = Provider.of<StarCRUD>(context, listen: false);

    editingModel.systems.forEach((id) =>
        systemProvider.getById(id).then((value) {
            var system = value as System;
            system.planets.forEach((id) =>
                planetProvider.getById(id).then((value) {
                  var planet = value as Planet;
                  planet.systems.remove(system.id);
                  planetProvider.update(planet, planet.id);
                }));

            system.stars.forEach((id) =>
                starProvider.getById(id).then((value) {
                  var star = value as Star;
                  star.systems.remove(system.id);
                  starProvider.update(star, star.id);
                }));

            systemProvider.remove(system.id);
        }));
  }

  @override
  Widget getImage() => Container(
    height: 300,
    width: 350,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage('assets/galaxy.png'), fit: BoxFit.scaleDown)),
  );

  @override
  Future<bool> save(context) async {
    if (this.systems.isNotEmpty)
      editingModel.systems.forEach((id) async {
        var system = systems[id];
        if (system.galaxy != editingModel.id) {
          system.galaxy = editingModel.id;
          await Provider.of<SystemCRUD>(context, listen: false).update(system, system.id);
        }
      });

    return true;
  }

  @override
  String getTitle() {
    return 'Galáxia';
  }

  @override
  Iterable<Widget> getFields() {
    editingModel.systems ??= [];

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

    var distancia = TextFormField(
      onSaved: (val) => editingModel.distance = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.distance,
      decoration: InputDecoration(
          labelText: 'Distância da Terra',
          labelStyle: style2,

          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none)),
    );

    var systemButton = RelationListButton(
      future: Provider.of<SystemCRUD>(context, listen: false).fetch(),
      isEmpty: editingModel.systems?.isEmpty ?? true,
      title: 'Sistemas',
      consumer: (list) => this.systems = Map.fromIterable(list.cast<System>(), key: (e) => e.id, value: (e) => e),
      filter: (model) => editingModel.systems?.contains(model.id),
      trailing: (model) =>
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                var system = model as System;
                editingModel.systems.remove(system.id);
                system.galaxy = null;
                Provider.of<SystemCRUD>(context, listen: false).update(system, system.id);
                Navigator.pop(context);
              }
          ),
    );

    var addSystem = FlatButton(
      color: Colors.deepPurple[800],
      child: Icon(Icons.add, color: Colors.white),
      shape: CircleBorder(),
      onPressed: () =>
          showDialog(context: context, builder: (context) =>
              RelationListButton.buildDialog(
                  'Sistemas', context, FutureList<System>(
                future: Provider.of<SystemCRUD>(context, listen: false).fetch(),
                nameFunction: (system) => system.name,
                filter: (system) => system.galaxy == null && !editingModel.systems.contains(system.id),
                onTap: (system) {
                  if (!editingModel.systems.contains(system.id))
                    editingModel.systems.add(system.id);
                  Navigator.of(context).pop();
                },
              ))
          ),
    );

    return [
      SizedBox(height: 50, width: 320, child: nome),
      SizedBox(height: 20, width: 0),
      SizedBox(height: 50, width: 320, child: distancia),
      SizedBox(height: 20, width: 0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 45, width: 120, child: systemButton),
          SizedBox(height: 0, width: 1),
          SizedBox(height: 45, width: 55, child: addSystem)
        ],
      )
    ];
  }

}