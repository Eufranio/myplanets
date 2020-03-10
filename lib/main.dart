import 'package:flutter/material.dart';
import 'package:planets/core/services/orbitCrud.dart';
import 'AuthService.dart';
import 'package:provider/provider.dart';
import 'package:planets/locator.dart';
import 'package:planets/core/services/planetCrud.dart';
import 'package:planets/core/services/galaxyCrud.dart';
import 'package:planets/core/services/satelliteCrud.dart';
import 'package:planets/core/services/starCrud.dart';
import 'package:planets/core/services/systemCrud.dart';
import 'router.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => locator<PlanetCRUD>()),
        ChangeNotifierProvider(create: (_) => locator<GalaxyCRUD>()),
        ChangeNotifierProvider(create: (_) => locator<SatelliteCRUD>()),
        ChangeNotifierProvider(create: (_) => locator<StarCRUD>()),
        ChangeNotifierProvider(create: (_) => locator<SystemCRUD>()),
        ChangeNotifierProvider(create: (_) => locator<OrbitCRUD>()),
        ChangeNotifierProvider(create: (_) => AuthService())
      ],
      child: MaterialApp(
        title: 'MyPlanets',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Montserrat',
        ),
        initialRoute: '/',
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}