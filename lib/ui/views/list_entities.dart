import 'package:flutter/material.dart';
import 'package:planets/core/services/galaxyCrud.dart';
import 'package:planets/core/services/orbitCrud.dart';
import 'package:planets/core/services/satelliteCrud.dart';
import 'package:planets/core/services/starCrud.dart';
import 'package:planets/core/services/systemCrud.dart';
import 'package:planets/core/viewmodels/galaxy.dart';
import 'package:planets/core/viewmodels/naturalSatellite.dart';
import 'package:planets/core/viewmodels/orbit.dart';
import 'package:planets/core/viewmodels/planetModel.dart';
import 'package:planets/core/viewmodels/star.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/views/info/galaxy/new_galaxy.dart';
import 'package:planets/ui/views/info/orbit/new_orbit.dart';
import 'package:planets/ui/views/info/satellite/new_satellite.dart';
import 'package:planets/ui/views/info/star/new_star.dart';
import 'package:planets/ui/views/info/system/new_system.dart';
import 'package:planets/ui/views/info/planet/new_planet.dart';
import 'package:planets/ui/widgets/image_button.dart';
import '../../core/viewmodels/system.dart';
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
        padding: EdgeInsets.all(30),
        crossAxisCount: 2,
        mainAxisSpacing: 40,
        crossAxisSpacing: 40,
        children: [
          buildButton(context,
              ListEntitiesSpecificScreen<GalaxyCRUD>(
                  editScreen: EditModelScreen(
                      null, () => Galaxy(), () => EditGalaxyState()),
                  childInfoFunction: EditGalaxyState.shortInfo,
                  buttonSize: 130),
              'Galáxias', 'assets/list-button-galaxy.png'),
          buildButton(context, ListEntitiesSpecificScreen<SystemCRUD>(
              editScreen: EditModelScreen(
                  null, () => System(planets: [], stars: []), () => EditSystemState()),
            childInfoFunction: EditSystemState.shortInfo,
            buttonSize: 120),
              'Sistemas Planetários','assets/list-button-system.png'),
          buildButton(context,
              ListEntitiesSpecificScreen<PlanetCRUD>(
                  editScreen: EditModelScreen(
                      null, () => Planet(), () => EditPlanetState())),
              'Planetas','assets/list-button-bg.png'),
          buildButton(context, ListEntitiesSpecificScreen<SatelliteCRUD>(
              editScreen: EditModelScreen(
                  null, () => NaturalSatellite(), () => EditSatelliteState())),
              'Satélites Naturais','assets/list-button-satellite.png'),
          buildButton(context, ListEntitiesSpecificScreen<StarCRUD>(
              editScreen: EditModelScreen(
                  null, () => Star(), () => EditStarState())), 'Estrelas', 'assets/list-button-star.png'),
          buildButton(context, ListEntitiesSpecificScreen<OrbitCRUD>(
            editScreen: EditModelScreen(
                null, () => Orbit(), () => EditOrbitState()
            ),
          ), 'Órbitas', 'assets/list-button-bg.png')
        ]
    );
  }

  Widget buildButton(context, nextScreen, text, image) {
    return ImageButton(
          image: AssetImage(image),

          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(text, style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
          ),
          align: Alignment.bottomCenter,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => nextScreen))
      );
  }
}