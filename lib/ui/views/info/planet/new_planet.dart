import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planets/core/services/planetCrud.dart';
import 'package:planets/core/viewmodels/planetModel.dart';
import 'package:planets/ui/views/info/edit_model.dart';

class EditPlanetState extends EditModelScreenState<Planet, PlanetCRUD> {
  @override
  String getTitle() {
    return 'Planeta';
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
          hintText: 'Nome',
          hintStyle: style,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    var tamanho = TextFormField(
      onSaved: (val) => editingModel.size = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.size,
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
      onSaved: (val) => editingModel.weight = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.weight,
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
      onSaved: (val) => editingModel.gravity = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.gravity,
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
      onSaved: (val) => editingModel.composition = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.composition,
      decoration: InputDecoration(
          labelText: 'Composição',
          labelStyle: style2,
          hintText: 'Composição',
          hintStyle: style,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    return [
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
      )
    ];
  }
}