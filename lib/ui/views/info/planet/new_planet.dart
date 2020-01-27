import 'package:flutter/material.dart';
import 'package:planets/core/viewmodels/planetModel.dart';
import 'package:planets/ui/views/info/planet/planet_info.dart';

class EditPlanetScreen extends StatefulWidget {

  final Planet planet;

  EditPlanetScreen({this.planet});

  @override
  _EditPlanetScreenState createState() => _EditPlanetScreenState();
}

class _EditPlanetScreenState extends State<EditPlanetScreen> {
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
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.planet?.description,
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
      onPressed: () {},
    );

    var button_Deletar = RaisedButton(
      color: Colors.deepPurple[600],
      child: IconButton(
        color: Colors.white, icon: Icon(
        Icons.delete,color: Colors.white,

      ),),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {},
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
