import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planets/core/services/starCrud.dart';
import 'package:planets/core/viewmodels/star.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/widgets/custom_dropdown.dart';

class EditStarState extends EditModelScreenState<Star, StarCRUD> {

  @override
  Widget getImage() => Container(
    width: double.maxFinite,
    height: 250,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage('assets/star.png'), fit: BoxFit.fitHeight)),
  );

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

    var tamanho = TextFormField(
      onSaved: (val) => editingModel.size = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.size,
      decoration: InputDecoration(
          labelText: 'Tamanho',
          labelStyle: style2,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
    );

    var decoration = InputDecoration(
        fillColor: Colors.white.withOpacity(0.5),
        filled: true,
        border: UnderlineInputBorder(borderRadius: BorderRadius.circular(10))
    );

    var tipo = CustomDropdownButtonFormField<StarType>(
      isExpanded: true,
      onSaved: (val) => editingModel.type = val,
      onChanged: (_) {},
      value: editingModel.type,
      decoration: decoration.copyWith(hintText: 'Tipo'),
      items: StarType.values.map((type) => DropdownMenuItem(
        value: type,
        child: Text(getNameFromType(type)),
      )).toList()
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
        padding: EdgeInsets.fromLTRB(35, 0, 35, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              height: 50,
              width: 150,
              child: tamanho,
            ),
            SizedBox(
              height: 50,
              width: 150,
              child: tipo,
            )
          ],
        ),
      )
    ];
  }

  static String getNameFromType(type) {
    switch (type) {
      case StarType.RedDwarf:
        return 'Anã Vermelha';
      case StarType.WhiteDwarf:
        return 'Anã Branca';
      case StarType.BinaryStar:
        return 'Estrela Binária';
      case StarType.BlueGiant:
        return 'Gigante Azul';
      case StarType.RedGiant:
        return 'Gigante Vermelha';
    }
  }
}