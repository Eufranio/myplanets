import 'package:flutter/material.dart';
import 'package:planets/core/services/systemCrud.dart';
import 'package:planets/core/viewmodels/star.dart';
import 'package:planets/core/viewmodels/system.dart';
import 'package:planets/ui/views/info/info_model.dart';
import 'package:planets/ui/views/info/star/new_star.dart';
import 'package:planets/ui/views/list_models.dart';
import 'package:planets/ui/widgets/info_box.dart';

class StarInfoState extends InfoModelScreenState<Star> {

  @override
  Widget getImage() =>
      Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fitHeight,
                      image: AssetImage('assets/star.png'))
              ),
            ),
          ),
          Positioned(
              right: 80,
              bottom: 80,
              child: Text(widget.model.name, textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ))
          ),
        ],
      );

  @override
  Iterable<Widget> getFields() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InfoBox(
            value: Text(widget.model.size, textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                )),
            title: Text('Tamanho',
                style: TextStyle(color: Colors.deepPurple, fontSize: 12)),
            size: 90,
          ),
          InfoBox(
            value: Text(
                widget.model.age, textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 14,
                fontWeight: FontWeight.bold
            )),
            title: Text('Idade',
                style: TextStyle(color: Colors.deepPurple, fontSize: 12)),
            size: 90,
          ),
          InfoBox(
            value: Text(widget.model.distance, textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.deepPurple,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                )),
            title: Text('Distância',
                style: TextStyle(color: Colors.deepPurple, fontSize: 12)),
            size: 90,
          )
        ],
      ),
      SizedBox(height: 20, width: 0),
      Container(
        width: 330,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(EditStarState.getNameFromType(widget.model.type),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      )),
                  widget.model.type == StarType.RedGiant ?
                  Text(widget.model.died ?? false ? 'Morta' : 'Viva', style: TextStyle(
                      color: Colors.white,
                      fontSize: 16
                  )) :
                  SizedBox.shrink()
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              Image.asset('assets/star.png')
            ],
          ),
        ),
      ),
      SizedBox(height: 20, width: 0),
      SizedBox(
        width: 180,
        height: 60,
        child: RaisedButton.icon(
          color: Colors.deepPurple[900],
          icon: Icon(Icons.public, size: 40, color: Colors.white),
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