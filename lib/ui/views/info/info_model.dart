import 'package:flutter/material.dart';
import 'package:planets/core/viewmodels/model.dart';

class InfoModelScreen<T extends Model> extends StatefulWidget {

  InfoModelScreen(this.model, this.stateFunction);

  T model;
  final Function stateFunction;

  @override
  InfoModelScreenState createState() => this.stateFunction.call();
}

abstract class InfoModelScreenState<T extends Model> extends State<InfoModelScreen<T>> {

  Iterable<Widget> getFields();

  Widget getImage() => Stack(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitHeight, image: AssetImage('assets/planet.png'))
          ),
        ),
      ),
      Positioned(
          right: 80,
          bottom: 80,
          child: Text(widget.model.name, textAlign: TextAlign.right, style: TextStyle(
            fontSize: 30.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ))
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => widget.model.getEdit()))
              .then((value) => this.setState(() { widget.model = value ?? widget.model; })),
          child: Icon(Icons.edit),
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/backg.png'), fit: BoxFit.cover),
          ),
          child: Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0
              ),
              SizedBox(
                height: 300,
                width: double.infinity,
                child: this.getImage(),
              )
            ].toList() + this.getFields(),
          ),
        )
    );
  }

}