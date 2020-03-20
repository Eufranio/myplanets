import 'package:flutter/material.dart';
import 'package:planets/core/viewmodels/star.dart';
import 'package:planets/ui/views/info/info_model.dart';
import 'package:planets/ui/views/info/star/new_star.dart';
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
                  Text(widget.model.died ? 'Morta' : 'Viva', style: TextStyle(
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
      )
    ];
  }

}