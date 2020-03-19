import 'package:flutter/material.dart';
import 'package:planets/core/services/systemCrud.dart';
import 'package:planets/core/viewmodels/galaxy.dart';
import 'package:planets/core/viewmodels/system.dart';
import 'package:planets/ui/views/info/info_model.dart';
import 'package:planets/ui/views/list_models.dart';
import 'package:planets/ui/widgets/info_box.dart';

class GalaxyInfoState extends InfoModelScreenState<Galaxy> {

  @override
  String getImage() => 'assets/galaxy.png';

  @override
  String getTitle() => 'Galáxia';

  Iterable<Widget> getFields() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InfoBox(
            width: 100, height: 100,
            value: Text(widget.model.distance, textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)
            ),
            title: Text(
              'Distância', textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 12),
            ),
          ),
          SizedBox.fromSize(size: Size.square(30)),
          InfoBox(
            width: 100, height: 100,
            value: Text(
              widget.model.systemCount.toString(), textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            title: Text(
              'Sistemas', textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 12),
            ),
          ),
        ],
      ),
      SizedBox.fromSize(size: Size.square(30)),
      SizedBox(
        width: 180,
        height: 60,
        child: RaisedButton.icon(
            color: Colors.deepPurple[900],
            icon: Icon(Icons.public, size: 40, color: Colors.white,),
            label: Text('Sistemas', style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20
            )),
            onPressed: () {
              if (widget.model.systems.isEmpty) {
                showDialog(context: context, builder: (context) => AlertDialog(
                  title: Text('Erro'),
                  content: Text('Não há sistemas para listar!'),
                  actions: <Widget>[
                    FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text('Fechar'))
                  ],
                ));
              } else {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) =>
                        ListModelsScreen<SystemCRUD, System>((system) => widget.model.systems.contains(system.id))
                    )
                );
              }
            },
        ),
      )
    ];
  }
}