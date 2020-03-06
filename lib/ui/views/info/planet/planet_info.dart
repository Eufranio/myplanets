import 'package:flutter/material.dart';
import 'package:planets/core/viewmodels/planetModel.dart';

class PlanetInfoScreen extends StatefulWidget {
  final Planet planet;

  PlanetInfoScreen({this.planet});

  @override
  _PlanetInfoState createState() => _PlanetInfoState();
}

class _PlanetInfoState extends State<PlanetInfoScreen> {
  @override
  Widget build(BuildContext context) {

    showAlertDialog1(BuildContext context)
    {
      // configura o button

      // configura o  AlertDialog
      AlertDialog alerta = AlertDialog(
        title: Text("Sistema: Via Láctea"),
        content: Text("Orbitantes: \n - Lua \n - Satélite"),
        actions: [
        ],
      );
      // exibe o dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alerta;
        },
      );
    }

    Widget edit = IconButton(
      color: Colors.white,
      icon: Icon(
        Icons.edit,
        size: 20,
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (_) => widget.planet.getEdit(),
        ));
      },
    );

    Widget info = IconButton(
      color: Colors.white,
      icon: Icon(
        Icons.info,
        size: 20,
      ),
      onPressed: () {showAlertDialog1(context);
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
              height: 120,
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Center(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          widget.planet.size,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        'Tamanho',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Center(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          widget.planet.weight,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        'Peso',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Center(
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          widget.planet.gravity,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Text(
                                        'Gravidade',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.deepPurple,
                                            fontSize: 10),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ),
                    ],
                  )),
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
                      padding: const EdgeInsets.all(0.0),
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