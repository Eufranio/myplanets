import 'package:flutter/material.dart';
import 'package:planets/core/services/galaxyCrud.dart';
import 'package:planets/core/services/planetCrud.dart';
import 'package:planets/core/services/starCrud.dart';
import 'package:planets/core/viewmodels/galaxy.dart';
import 'package:planets/core/viewmodels/model.dart';
import 'package:planets/core/viewmodels/planetModel.dart';
import 'package:planets/core/viewmodels/star.dart';
import 'package:planets/core/viewmodels/system.dart';
import 'package:planets/ui/views/info/info_model.dart';
import 'package:planets/ui/views/list_models.dart';
import 'package:planets/ui/widgets/image_button.dart';
import 'package:planets/ui/widgets/info_box.dart';
import 'package:planets/ui/widgets/relation_list.dart';
import 'package:provider/provider.dart';

class SystemInfoState extends InfoModelScreenState<System> {

  Galaxy galaxy;

  @override
  Widget getImage() => Stack(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(20),
        child: Container(
          height: 220,
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitHeight, image: AssetImage('assets/system.png'))
          ),
        ),
      ),
      Positioned(
          right: 40,
          bottom: 60,
          child: Text(widget.model.name, textAlign: TextAlign.right, style: TextStyle(
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
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InfoBox(
            value: Text(widget.model.starCount.toString(), textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 20),
            ),
            title: Text('Estrelas', textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 12),
            ),
            size: 100,
          ),
          InfoBox(
            value: Text(widget.model.planetCount.toString(), textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 20)
            ),
            title: Text('Planetas', textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 12),
            ),
            size: 100,
          ),
          InfoBox(
            value: Text(widget.model.age, textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontWeight: FontWeight.bold,
                fontSize: 14),
            ),
            title: Text('Idade', textAlign: TextAlign.center, style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 12),
            ),
            size: 100,
          )
        ],
      ),
      SizedBox(height: 30, width: 0),
      SizedBox(height: 80, width: 280,
          child: ImageButton(
              image: AssetImage('assets/button-search-galaxy.png'),
              child: Padding(
                padding: const EdgeInsets.only(right: 30),
                child: FutureBuilder(
                  future: Provider.of<GalaxyCRUD>(context, listen: false).getById(widget.model.galaxy),
                    builder: (context, AsyncSnapshot<Model> snapshot) {
                      if (snapshot.hasData) {
                        this.galaxy = snapshot.data;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(galaxy.name, style: TextStyle(fontSize: 25)),
                            Text('Galáxia')
                          ],
                        );
                      }
                      return SizedBox.fromSize(size: Size.square(30), child: CircularProgressIndicator());
                    }
                ),
              ),
              align: Alignment.centerRight,
              onPressed: () {
                if (this.galaxy != null)
                  Navigator.push(context, MaterialPageRoute(builder: (_) => galaxy.getInfo()));
              }
          )
      ),
      SizedBox(height: 20, width: 0),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 55, width: 132, child: ImageButton(
              image: AssetImage('assets/list-button-bg.png'),
              child: Text('Planetas', style: TextStyle(fontSize: 15)),
              onPressed: () {
                if (widget.model.planets.isEmpty) {
                  showDialog(context: context,
                      child: RelationListButton.buildDialog(
                          'Erro', context,
                          Text('Não há nada para exibir!')));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) =>
                          ListModelsScreen<PlanetCRUD, Planet>((planet) => widget.model.planets.contains(planet.id))
                      )
                  );
                }
              }
          )),
          SizedBox(height: 0, width: 17),
          SizedBox(height: 55, width: 132, child: ImageButton(
              image: AssetImage('assets/list-button-star.png'),
              child: Text('Estrelas', style: TextStyle(fontSize: 15)),
              onPressed: () {
                if (widget.model.stars.isEmpty) {
                  showDialog(context: context,
                      child: RelationListButton.buildDialog(
                          'Erro', context,
                          Text('Não há nada para exibir!')));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) =>
                          ListModelsScreen<StarCRUD, Star>((star) => widget.model.stars.contains(star.id))
                      )
                  );
                }
              }
          ))
        ],
      )
    ];
  }

}