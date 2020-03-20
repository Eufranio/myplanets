import 'package:flutter/material.dart';
import 'package:planets/core/services/orbitCrud.dart';
import 'package:planets/core/viewmodels/naturalSatellite.dart';
import 'package:planets/core/viewmodels/orbit.dart';
import 'package:planets/ui/views/info/info_model.dart';
import 'package:planets/ui/views/list_models.dart';
import 'package:planets/ui/widgets/info_box.dart';

class SatelliteInfoState extends InfoModelScreenState<NaturalSatellite> {

  void showOrbitants(context) => showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Orbitantes'),
        content: Container(
            height: 300,
            width: 300,
            child: ListView(
              children: ListTile.divideTiles(
                  context: context,
                  tiles: <Widget>[
                    ListTile(
                      title: Text('Órbitas'),
                      onTap: () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) =>
                              ListModelsScreen<OrbitCRUD, Orbit>((orbit) => orbit.satellite == widget.model.id)
                          )
                      ),
                    )
                  ]
              ).toList(),
            )
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ));

  @override
  Widget getImage() => Stack(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitHeight, image: AssetImage('assets/satellite.png'))
          ),
        ),
      ),
      Positioned(
          right: 80,
          bottom: 125,
          child: Text(widget.model.name, textAlign: TextAlign.right, style: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ))
      ),
    ],
  );

  @override
  Iterable<Widget> getFields() {

    Widget info = IconButton(
        color: Colors.white,
        icon: Icon(
          Icons.info,
          size: 25,
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) =>
                ListModelsScreen<OrbitCRUD, Orbit>((orbit) => orbit.satellite == widget.model.id)
            )
        )
    );

    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InfoBox(
            value: Text(widget.model.size, textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)
            ),
            title: Text(
              'Tamanho', textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 12),
            ),
          ),
          SizedBox.fromSize(size: Size.square(20)),
          InfoBox(
            value: Text(widget.model.weight, textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            title: Text('Peso', textAlign: TextAlign.center, style: TextStyle(
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
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ],
            )
        ),
      )
    ];
  }

}