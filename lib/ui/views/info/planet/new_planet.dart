import 'package:flutter/material.dart';
import 'package:planets/core/services/planetCrud.dart';
import 'package:planets/core/viewmodels/planetModel.dart';
import 'package:planets/ui/views/info/planet/planet_info.dart';
import 'package:provider/provider.dart';

class EditPlanetScreen extends StatefulWidget {

  Planet planet;

  EditPlanetScreen({this.planet});

  @override
  _EditPlanetScreenState createState() => _EditPlanetScreenState();
}

class _EditPlanetScreenState extends State<EditPlanetScreen> {

  Planet planet;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.planet != null) { // editing an element
      planet = widget.planet;
    } else {
      planet = Planet();
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontWeight: FontWeight.normal
    );

    TextStyle style2 = TextStyle(
        fontSize: 15,
        color: Colors.white,
        fontWeight: FontWeight.bold
    );

    var nome = TextFormField(
      onSaved: (val) => planet.name = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.planet?.name,
      decoration: InputDecoration(
          labelText: 'Nome',
          labelStyle: style2,
          hintText: 'Nome',
          hintStyle: style,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    var tamanho = TextFormField(
      onSaved: (val) => planet.size = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.planet?.size,
      decoration: InputDecoration(
          labelText: 'Tamanho',
          labelStyle: style2,
          hintText: 'Tamanho',
          hintStyle: style,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    var peso = TextFormField(
      onSaved: (val) => planet.weight = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.planet?.weight,
      decoration: InputDecoration(
          labelText: 'Peso',
          labelStyle: style2,
          hintStyle: style,
          hintText: 'Peso',
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    var gravidade = TextFormField(
      onSaved: (val) => planet.gravity = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.planet?.gravity,
      decoration: InputDecoration(
          labelText: 'Gravidade',
          hintText: 'Gravidade',
          labelStyle: style2,
          hintStyle: style,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    var composicao = TextFormField(
      onSaved: (val) => planet.composition = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.planet?.composition,
      decoration: InputDecoration(
          labelText: 'Composição',
          labelStyle: style2,
          hintText: 'Composição',
          hintStyle: style,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    var button_Salvar = RaisedButton(
      color: Colors.deepPurple[900],
      child: Text('Salvar', style: style),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () async {
        _formKey.currentState.save();

        if (widget.planet != null) {
          await Provider.of<PlanetCRUD>(context, listen: false).update(planet, planet.id);
        } else {
          await Provider.of<PlanetCRUD>(context, listen: false).addModel(planet);
        }

        Navigator.of(context).pop(planet);
      },
    );

    var button_Deletar = RaisedButton(
      color: Colors.deepPurple[600],
      child: IconButton(
        color: Colors.white,
        icon: Icon(
        Icons.delete,
          color: Colors.white,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () async {
        await Provider.of<PlanetCRUD>(context, listen: false).remove(planet.id);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/backg.png'), fit: BoxFit.cover),
        ),
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
                child: Column(
                  children: <Widget>[
                    AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0
                    ),
                    Text('Planeta', style: TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)
                    ),
                    SizedBox(
                      height: 70,
                      width: 100,
                    ),
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/planet.png'), fit: BoxFit.cover),
                      ),

                    ),
                    SizedBox(
                      height: 70,
                      width: 100,
                    ),
                    SizedBox(
                      height: 50,
                      width: 320,
                      child: nome,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(35, 20, 35, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: tamanho,
                          ),
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: peso,
                          ),
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: gravidade,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                      width: 320,
                      child: composicao,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(90, 20, 80, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          widget.planet == null ? SizedBox.shrink() :
                          Center(
                            child: SizedBox(
                              height: 50,
                              width: 80,
                              child: button_Deletar,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 100,
                            child: button_Salvar,
                          ),
                        ],
                      ),
                    ),
                  ],

                )),
          ),
        ),
      ),
    );
  }


}
