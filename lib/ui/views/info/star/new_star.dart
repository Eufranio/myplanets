import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planets/core/services/orbitCrud.dart';
import 'package:planets/core/services/starCrud.dart';
import 'package:planets/core/services/systemCrud.dart';
import 'package:planets/core/viewmodels/orbit.dart';
import 'package:planets/core/viewmodels/star.dart';
import 'package:planets/core/viewmodels/system.dart';
import 'package:planets/locator.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/widgets/custom_dropdown.dart';
import 'package:planets/ui/widgets/relation_list.dart';
import 'package:provider/provider.dart';

class EditStarState extends EditModelScreenState<Star, StarCRUD> {

  var systems = Map<String, System>();

  @override
  void onDelete() async {
    var systemProvider = Provider.of<SystemCRUD>(context, listen: false);
    var orbitProvider = Provider.of<OrbitCRUD>(context, listen: false);

    editingModel.systems.forEach((id) =>
        systemProvider.getById(id).then((value) {
          var system = value as System;
          system.stars.remove(editingModel.id);
          systemProvider.update(system, system.id);
        }));

    var orbits = await orbitProvider.fetch().then((value) => value.cast<Orbit>());
    orbits.forEach((orbit) {
      if (orbit.star == editingModel.id)
        orbitProvider.remove(orbit.id);
    });
  }

  @override
  void postSave() {
    var systemProvider = locator<SystemCRUD>();
    editingModel.systems.forEach((id) async {
      var system = await systemProvider.getById(id).then((value) => value as System);
      if (!system.stars.contains(editingModel.id)) {
        system.stars.add(editingModel.id);
        await systemProvider.update(system, system.id);
      }
    });
  }

  @override
  Widget getImage() => Container(
    width: double.maxFinite,
    height: 250,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage('assets/star.png'), fit: BoxFit.fitHeight)),
  );

  @override
  String getTitle() {
    return 'Estrela';
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
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
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

    var decoration = InputDecoration(
        fillColor: Colors.white.withOpacity(0.5),
        filled: true,
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10))
    );

    var tipo = CustomDropdownButtonFormField<StarType>(
      isExpanded: true,
      onSaved: (val) => editingModel.type = val,
      onChanged: (_) {},
      value: editingModel.type,
      decoration: decoration.copyWith(hintText: 'Tipo'),
      items: StarType.values.map((type) => DropdownMenuItem(
        value: type,
        child: Text(getNameFromType(type)),
      )).toList()
    );

    var morta = CustomDropdownButtonFormField<bool>(
        isExpanded: true,
        onSaved: (val) => editingModel.died = val,
        onChanged: (_) {},
        //value: editingModel.died ?? false,
        decoration: decoration.copyWith(hintText: 'Morta'),
        items: [
          DropdownMenuItem(
            value: true,
            child: Text('Sim'),
          ),
          DropdownMenuItem(
            value: false,
            child: Text('Não'),
          )
        ]
    );

    var systemButton = RelationListButton(
      future: Provider.of<SystemCRUD>(context, listen: false).fetch(),
      isEmpty: editingModel.systems?.isEmpty,
      title: 'Sistemas',
      consumer: (list) => this.systems = Map.fromIterable(list.cast<System>(), key: (e) => e.id, value: (e) => e),
      filter: (model) => editingModel.systems.contains(model.id),
      trailing: (model) =>
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                var system = model as System;
                editingModel.systems.remove(system.id);
                system.stars.remove(editingModel.id);
                Provider.of<SystemCRUD>(context, listen: false).update(system, system.id);
                Navigator.pop(context);
              }
          ),
    );

    var addSystem = FlatButton(
      padding: EdgeInsets.zero,
      color: Colors.deepPurple[800],
      child: Icon(Icons.add, color: Colors.white),
      shape: CircleBorder(),
      onPressed: () =>
          showDialog(context: context, builder: (context) =>
              RelationListButton.buildDialog(
                  'Sistemas', context, FutureList<System>(
                future: Provider.of<SystemCRUD>(context, listen: false).fetch(),
                nameFunction: (system) => system.name,
                filter: (system) => !system.stars.contains(editingModel.id) && !editingModel.systems.contains(system.id),
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
          SizedBox(height: 60, width: 155, child: idade),
          SizedBox(height: 60, width: 155, child: distancia),
        ],
      )),
      SizedBox(height: 10, width: 1),
      SizedBox(height: 60, width: 320, child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 60, width: 155, child: tamanho),
          SizedBox(height: 60, width: 155, child: tipo)
        ],
      )),
      SizedBox(height: 10, width: 1),
      Padding(
        padding: EdgeInsets.fromLTRB(35, 0, 35, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(height: 45, width: 120, child: systemButton),
            SizedBox(height: 45, width: 55, child: addSystem),
            SizedBox(height: 50, width: 150, child: morta)
          ],
        ),
      )
    ];
  }

  static String getNameFromType(type) {
    switch (type) {
      case StarType.RedDwarf:
        return 'Anã Vermelha';
      case StarType.WhiteDwarf:
        return 'Anã Branca';
      case StarType.BinaryStar:
        return 'Estrela Binária';
      case StarType.BlueGiant:
        return 'Gigante Azul';
      case StarType.RedGiant:
        return 'Gigante Vermelha';
    }
  }
}