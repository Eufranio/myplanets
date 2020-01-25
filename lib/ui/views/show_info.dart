import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle());


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: new LoginPage(),
        theme: new ThemeData(primarySwatch: Colors.blue));
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/backg.png'), fit: BoxFit.cover),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 00),
              child: topButtons,
            ),
            Center(
              child: planet_name,
            ),
            Container(
              width: 330,
              height: 140,
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
                                          '20',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
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
                                          '20',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
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
                                          '10',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.deepPurple,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
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
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'A composição da superfície é fundamentalmente de basalto vulcânico com um alto conteúdo em óxidos de ferro que proporcionam o vermelho característico da superfície. Pela sua natureza, assemelha-se com a limonite, óxido de ferro muito hidratado',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

Widget infoPlanetas = Center(
  child: Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 60,
      height: 60,
      color: Colors.white.withOpacity(0.6),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text('Tamanho'),
      ),
    ),
  ),
);

Widget boxInfos = Container(
  child: Row(
    children: <Widget>[Container()],
  ),
);

Widget planet_name = Container(
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
              alignment: Alignment.topRight,
              child: Text(
                "Planeta Terra",
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

Widget infoButton = Container(
  width: 50,
  height: 50,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        color: Colors.blue,
      ),
      Container(
        color: Colors.red,
      ),
    ],
  ),
);

Widget topButtons =
Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
  backButton,
  closeButton,
]);

Widget closeButton = IconButton(
  color: Colors.white,
  icon: Icon(
    Icons.close,
    size: 30,
  ),
  onPressed: () {},
);

Widget backButton = IconButton(
  color: Colors.white,
  icon: Icon(
    Icons.arrow_back,
    size: 30,
  ),
  onPressed: () {},
);
