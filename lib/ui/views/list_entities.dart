import 'package:flutter/material.dart';
import 'package:planets/core/services/galaxyCrud.dart';
import 'package:planets/core/services/starCrud.dart';
import 'package:planets/core/services/systemCrud.dart';
import 'package:planets/ui/views/info/planet/new_planet.dart';
import 'package:planets/ui/widgets/widgets.dart';
import 'list_entities_specific.dart';
import 'package:planets/core/services/planetCrud.dart';

class ListEntitiesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontSize: 30,
        color: Colors.white,
        fontWeight: FontWeight.bold,
    );
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg-list-entities.png'),
              fit: BoxFit.cover
          ),
        ),
        child: Column(
          children: <Widget>[
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0
            ),
            Text('Entidades', style: style),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: buildList(context),
              )
            )
          ],
        ),
      ),
    );
  }

  Widget buildList(context) {
    return GridView.count(
      padding: EdgeInsets.all(15),
      crossAxisCount: 3,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      children: [
        buildButton(context, ListEntitiesSpecificScreen<GalaxyCRUD>(EditPlanetScreen(planet: null)), 'Galáxias'),
        buildButton(context, ListEntitiesSpecificScreen<SystemCRUD>(EditPlanetScreen(planet: null)), 'Sistema Planetário'),
        buildButton(context, ListEntitiesSpecificScreen<PlanetCRUD>(EditPlanetScreen(planet: null)), 'Planetas'),
        buildButton(context, ListEntitiesSpecificScreen<StarCRUD>(EditPlanetScreen(planet: null)), 'Estrelas'),
        buildButton(context, ListEntitiesSpecificScreen<GalaxyCRUD>(EditPlanetScreen(planet: null)), 'Satélites Naturais')
      ]
    );
  }

  Widget buildButton(context, nextScreen, text) {
    return ImageButton(
          image: AssetImage('assets/list-button-bg.png'),
          child: Text(text),
          align: Alignment.bottomCenter,
          padding: EdgeInsets.all(8),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => nextScreen))
      );
  }
}