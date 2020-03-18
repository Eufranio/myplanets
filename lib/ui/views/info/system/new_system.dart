import 'package:flutter/material.dart';
import 'package:planets/core/services/planetCrud.dart';
import 'package:planets/core/services/systemCrud.dart';
import 'package:planets/core/viewmodels/planetModel.dart';
import 'package:planets/core/viewmodels/system.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/systemCrud.dart';


class EditSystemState extends EditModelScreenState<System, SystemCRUD>{

  @override
  String getTitle() {
    return 'Sistema Panetário';
  }

  @override
  Iterable<Widget> getFields() {
    var planetProvider = Provider.of<PlanetCRUD>(context, listen: false);

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

    var planetas = RaisedButton.icon(
      color: Colors.deepPurple[900],
      icon: Icon(Icons.public, size: 20, color: Colors.white,),
      label: Text('Planetas', style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 15
      )),
      onPressed: () async {
        List<Planet> planets = (await planetProvider.fetch())
            .cast<Planet>()
            .where((planet) => widget.model.planets.contains(planet.id))
            .toList();
        showDialog(context: context, builder: (context) =>
            buildDialog(widget.model.planets.isEmpty, 'Planetas', ListView.builder(
                itemCount: planets.length,
                itemBuilder: (context, index) =>
                    ListTile(
                      title: Text(planets[index].name),
                      onTap: () =>
                          Navigator.push(context, MaterialPageRoute(
                              builder: (_) => planets[index].getInfo())),
                    )
            )));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );

    var add = FlatButton(
      color: Colors.deepPurple[900],
      child: Icon(Icons.add, color: Colors.white),
      shape: CircleBorder(),
      onPressed: () async {
        List<Planet> planets = (await planetProvider.fetch()).cast<Planet>();
        showDialog(context: context, builder: (context) =>
            buildDialog(planets.isEmpty, 'Planetas', ListView.builder(
                itemCount: planets.length,
                itemBuilder: (context, index) =>
                    ListTile(
                        title: Text(planets[index].name),
                        onTap: () async {
                          var planet = planets[index];

                          if (!widget.model.planets.contains(planet.id))
                            widget.model.planets.add(planet.id);

                          if (!planet.systems.contains(widget.model.id))
                            planet.systems.add(widget.model.id);
                          
                          planetProvider.update(planet, planet.id);
                          Navigator.of(context).pop();
                        }
                    )
            )));
      },
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
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50, width: 130, child: planetas),
          SizedBox(height: 0, width: 10),
          SizedBox(height: 50, width: 55, child: add)
        ],
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