import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planets/core/services/orbitCrud.dart';
import 'package:planets/core/services/planetCrud.dart';
import 'package:planets/core/services/systemCrud.dart';
import 'package:planets/core/viewmodels/orbit.dart';
import 'package:planets/core/viewmodels/planetModel.dart';
import 'package:planets/core/viewmodels/system.dart';
import 'package:planets/locator.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/widgets/relation_list.dart';
import 'package:provider/provider.dart';

class EditPlanetState extends EditModelScreenState<Planet, PlanetCRUD> {

  @override
  void onDelete() async {
    var systemProvider = Provider.of<SystemCRUD>(context, listen: false);
    var orbitProvider = Provider.of<OrbitCRUD>(context, listen: false);

    editingModel.systems.forEach((id) =>
        systemProvider.getById(id).then((value) {
          var system = value as System;
          system.planets.remove(editingModel.id);
          systemProvider.update(system, system.id);
        }));

    var orbits = await orbitProvider.fetch().then((value) => value.cast<Orbit>());
    orbits.forEach((orbit) {
      if (orbit.planet == editingModel.id)
        orbitProvider.remove(orbit.id);
    });
  }

  @override
  void postSave() async {
    var systemProvider = locator<SystemCRUD>();
    editingModel.systems.forEach((id) async {
      var system = await systemProvider.getById(id).then((value) => value as System);
      if (!system.planets.contains(editingModel.id)) {
        system.planets.add(editingModel.id);
        await systemProvider.update(system, system.id);
      }
    });
  }

  @override
  String getTitle() {
    return 'Planeta';
  }

  @override
  Iterable<Widget> getFields() {
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
    );

    var tamanho = TextFormField(
      onSaved: (val) => editingModel.size = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.size,
      decoration: InputDecoration(
          labelText: 'Tamanho',
          labelStyle: style2,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
    );

    var peso = TextFormField(
      onSaved: (val) => editingModel.weight = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.weight,
      decoration: InputDecoration(
          labelText: 'Peso',
          labelStyle: style2,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
    );

    var gravidade = TextFormField(
      onSaved: (val) => editingModel.gravity = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.gravity,
      decoration: InputDecoration(
          labelText: 'Gravidade',
          labelStyle: style2,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
    );

    var composicao = TextFormField(
      onSaved: (val) => editingModel.composition = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.composition,
      decoration: InputDecoration(
          labelText: 'Composição',
          labelStyle: style2,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
    );

    var systemButton = RelationListButton(
      future: Provider.of<SystemCRUD>(context, listen: false).fetch(),
      isEmpty: editingModel.systems?.isEmpty ?? true,
      title: 'Sistemas',
      filter: (model) => editingModel.systems.contains(model.id),
      trailing: (model) =>
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                var system = model as System;
                editingModel.systems.remove(system.id);
                system.planets.remove(editingModel.id);
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
                filter: (system) => !system.planets.contains(editingModel.id) && !editingModel.systems.contains(system.id),
                onTap: (system) {
                  if (!editingModel.systems.contains(system.id))
                    editingModel.systems.add(system.id);
                  Navigator.of(context).pop();
                },
              ))
          ),
    );

    return [
      SizedBox(height: 60, width: 320, child: nome),
      SizedBox(height: 10, width: 1),
      SizedBox(height: 60, width: 320, child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(height: 60, width: 100, child: tamanho),
          SizedBox(height: 60, width: 100, child: peso),
          SizedBox(height: 60, width: 100, child: gravidade),
        ],
      )),
      SizedBox(height: 10, width: 1),
      SizedBox(height: 60, width: 320, child: composicao),
      SizedBox(height: 10, width: 1),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 45, width: 120, child: systemButton),
          SizedBox(height: 0, width: 1),
          SizedBox(height: 45, width: 55, child: addSystem)
        ],
      ),
    ];
  }
}