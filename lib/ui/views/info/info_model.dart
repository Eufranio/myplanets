import 'package:flutter/material.dart';
import 'package:planets/core/viewmodels/model.dart';

class InfoModelScreen<T extends Model> extends StatefulWidget {

  InfoModelScreen(this.model, this.stateFunction);

  T model;
  final Function stateFunction;

  @override
  InfoModelScreenState createState() => this.stateFunction.call();
}

abstract class InfoModelScreenState<T extends Model> extends State<InfoModelScreen> {

  Iterable<Widget> getFields();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/backg.png'), fit: BoxFit.cover),
          ),
          child: Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: <Widget>[
                  IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.edit, size: 20),
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => widget.model.getEdit()))
                          .then((value) {
                        setState(() {
                          if (value != null)
                            widget.model = value;
                        });
                      })
                  )
                ]
              ),
              SizedBox(
                height: 300,
                width: 300,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill, image: AssetImage('assets/planet.png')),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 100, right: 50),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(widget.model.name, textAlign: TextAlign.right, style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                    )
                  ],
                ),
              )
            ].toList() + this.getFields(),
          ),
        )
    );
  }

}