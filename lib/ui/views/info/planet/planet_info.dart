import 'package:flutter/material.dart';
import 'package:planets/core/services/orbitCrud.dart';
import 'package:planets/core/services/systemCrud.dart';
import 'package:planets/core/viewmodels/orbit.dart';
import 'package:planets/core/viewmodels/planetModel.dart';
import 'package:planets/core/viewmodels/system.dart';
import 'package:planets/ui/views/info/info_model.dart';
import 'package:planets/ui/views/list_models.dart';
import 'package:planets/ui/widgets/info_box.dart';
import 'package:planets/ui/widgets/relation_list.dart';

class PlanetInfoState extends InfoModelScreenState<Planet> {

  @override
  Iterable<Widget> getFields() {
    Widget info = IconButton(
        color: Colors.white,
        icon: Icon(Icons.info, size: 25),
        onPressed: () => showDialog(context: context, child:
          RelationListButton.buildDialog('Relações', context, ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                title: Text('Sistemas Planetários'),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>
                      ListModelsScreen<SystemCRUD, System>((system) => system.planets.contains(widget.model.id))
                  ))
              ),
              ListTile(
                title: Text('Órbitas'),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) =>
                    ListModelsScreen<OrbitCRUD, Orbit>((orbit) => orbit.planet == widget.model.id)
                )),
              )
            ],
          ))
        )
    );

    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InfoBox(
            value: Text(widget.model.size, textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 14)
            ),
            title: Text('Tamanho', textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 12),
            ),
          ),
          InfoBox(
            value: Text(widget.model.weight, textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 14),
            ),
            title: Text('Peso', textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 12),
            ),
          ),
          InfoBox(
            value: Text(widget.model.gravity, textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 14),
            ),
            title: Text('Gravidade', textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 12),
            ),
          ),
        ],
      ),
      SizedBox.fromSize(size: Size.square(30)),
      Container(
        width: 330,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                  child: info,
                ),
                Text(
                  widget.model.composition,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            )
        ),
      )
    ];
  }
}