import 'package:flutter/material.dart';
import 'package:planets/core/services/orbitCrud.dart';
import 'package:planets/core/services/satelliteCrud.dart';
import 'package:planets/core/viewmodels/orbit.dart';
import 'package:planets/core/viewmodels/planetModel.dart';
import 'package:planets/ui/views/list_models.dart';
import 'package:planets/ui/widgets/image_button.dart';
import 'package:planets/ui/widgets/info_box.dart';

class PlanetInfoScreen extends StatefulWidget {
  Planet planet;

  PlanetInfoScreen({this.planet});

  @override
  _PlanetInfoState createState() => _PlanetInfoState();
}

class _PlanetInfoState extends State<PlanetInfoScreen> {

  Widget showOrbitants(context) {

    Widget satellites = ListView(
      children: ListTile.divideTiles(
          context: context,
          tiles: <Widget>[
            ListTile(
              title: Text('Satélites'),
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) =>
                      ListModelsScreen<OrbitCRUD, Orbit>((orbit) => orbit.planet == widget.planet.id)
                  )
              ),
            )
          ]
      ).toList(),
    );

    AlertDialog dialog = AlertDialog(
      title: Text('Orbitantes'),
      content: Container(
        height: 300,
        width: 300,
        child: satellites
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Fechar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );

    showDialog(context: context, builder: (_) => dialog);
  }

  @override
  Widget build(BuildContext context) {

    Widget edit = IconButton(
      color: Colors.white,
      icon: Icon(
        Icons.edit,
        size: 20,
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => widget.planet.getEdit(),
        )).then((val) {
          setState(() {
            if (val != null)
              widget.planet = val;
          });
        });
      },
    );

    Widget info = IconButton(
      color: Colors.white,
      icon: Icon(
        Icons.info,
        size: 20,
      ),
      onPressed: () {
        this.showOrbitants(context);
      }
    );

    return new Scaffold(
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
            Container(
              width: 360,
              height: 25,
              child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 100,
                  height: 25,
                  color: Colors.transparent,
                  child: edit,
                ),
              ),
            ),
            Center(
              child: planet_name(widget.planet),
            ),

            Container(
              width: 330,
              height: 80,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  //lista das caracteristicas
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      InfoBox(
                        value: Text('12312312122', textAlign: TextAlign.center, style: TextStyle(
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
                        value: Text(widget.planet.weight, textAlign: TextAlign.center, style: TextStyle(
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
                        value: Text(widget.planet.gravity, textAlign: TextAlign.center, style: TextStyle(
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
                  )),
            ),

            SizedBox(
              height: 30,
              width: 30,
            ),
            Container(
                width: 330,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Center(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topRight,
                            child: info,
                          ),
                          Text(
                            widget.planet.composition,
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      )

                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}


Widget boxInfos = Container(
  child: Row(
    children: <Widget>[Container()],
  ),
);

Widget planet_name(Planet planet) => Container(
  width: 300,
  height: 300,
  child: Stack(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill, image: AssetImage('assets/planet.png')),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(80, 150, 0, 20),
        child: Container(
          width: 220,
          height: 75,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                planet.name,
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 28.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  ),
);