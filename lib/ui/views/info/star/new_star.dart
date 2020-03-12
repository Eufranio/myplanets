import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planets/core/services/starCrud.dart';
import 'package:planets/core/viewmodels/star.dart';
import 'package:planets/ui/views/info/edit_model.dart';

class EditStarState extends EditModelScreenState<Star, StarCRUD> {
  @override
  String getTitle() {
    return 'Estrela';
  }

  @override
  Iterable<Widget> getFields() {
    var nome = TextFormField(
      onSaved: (val) => editingModel.name = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.name,
      decoration: InputDecoration(
          labelText: 'Nome',
          labelStyle: style2,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
    );

    var idade = TextFormField(

      onSaved: (val) => editingModel.age = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.age,
      decoration: InputDecoration(
          labelText: 'Idade',
          labelStyle: style2,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
    );

    var distancia = TextFormField(
      onSaved: (val) => editingModel.distance = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.distance,
      decoration: InputDecoration(
          labelText: 'Distância da Terra',
          labelStyle: style2,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
    );

    var gravidade = TextFormField(
      onSaved: (val) => editingModel.gravity = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.gravity,
      decoration: InputDecoration(
          labelText: 'Gravidade',
          labelStyle: style2,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
    );

    var peso = TextFormField(
      onSaved: (val) => editingModel.size = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.size,
      decoration: InputDecoration(
          labelText: 'Massa Molar',
          labelStyle: style2,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
    );

    return [
      SizedBox(
        height: 50,
        width: 320,
        child: nome,
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(35, 20, 35, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: 50,
              width: 150,
              child: idade,
            ),
            SizedBox(
              height: 50,
              width: 150,
              child: distancia,
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(35, 10, 35, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: 50,
              width: 150,
              child: gravidade,
            ),
            SizedBox(
              height: 50,
              width: 150,
              child: peso,
            ),
          ],
        ),
      ),

    ];
  }
}