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
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/views/info/galaxy/new_galaxy.dart';
import 'package:planets/ui/views/info/orbit/new_orbit.dart';
import 'package:planets/ui/views/info/satellite/new_satellite.dart';
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
        padding: EdgeInsets.all(15),
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        children: [
          buildButton(context,
              ListEntitiesSpecificScreen<PlanetCRUD>(
                  editScreen: EditModelScreen(
                      null, () => Planet(), () => EditPlanetState())),
              'Planetas'),
          buildButton(context,
              ListEntitiesSpecificScreen<GalaxyCRUD>(
                  editScreen: EditModelScreen(
                      null, () => Galaxy(), () => EditGalaxyState()),
                  childInfoFunction: EditGalaxyState.shortInfo,
                  buttonSize: 130),
              'Galáxias'),
          buildButton(context, ListEntitiesSpecificScreen<SystemCRUD>(
              editScreen: EditModelScreen(
                  null, () => System(), () => EditSystemState())),
              'Sistema Planetário'),
          buildButton(context, ListEntitiesSpecificScreen<StarCRUD>(
              editScreen: EditModelScreen(
                  null, () => Planet(), () => EditPlanetState())), 'Estrelas'),
          buildButton(context, ListEntitiesSpecificScreen<SatelliteCRUD>(
              editScreen: EditModelScreen(
                  null, () => NaturalSatellite(), () => EditSatelliteState())),
              'Satélites Naturais'),
          buildButton(context, ListEntitiesSpecificScreen<OrbitCRUD>(
            editScreen: EditModelScreen(
                null, () => Orbit(), () => EditOrbitState()
            ),
          ), 'Órbitas')
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