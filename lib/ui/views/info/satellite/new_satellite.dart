import 'package:flutter/material.dart';
import 'package:planets/core/services/orbitCrud.dart';
import 'package:planets/core/services/satelliteCrud.dart';
import 'package:planets/core/viewmodels/naturalSatellite.dart';
import 'package:planets/core/viewmodels/orbit.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class EditSatelliteState extends EditModelScreenState<NaturalSatellite, SatelliteCRUD> {

  @override
  void onDelete() async {
    var orbitProvider = Provider.of<OrbitCRUD>(context, listen: false);

    var orbits = await orbitProvider.fetch().then((value) => value.cast<Orbit>());
    orbits.forEach((orbit) {
      if (orbit.satellite == editingModel.id)
        orbitProvider.remove(orbit.id);
    });
  }

    @override
    Widget getImage() => Container(
      width: double.maxFinite,
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/satellite.png'), fit: BoxFit.fitHeight),),
    );

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

    var tamanho = TextFormField(
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
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

    var peso = TextFormField(
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      keyboardType: TextInputType.number,
      onSaved: (val) => editingModel.weight = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.weight,
      decoration: InputDecoration(
          labelText: 'Peso',
          labelStyle: style2,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
    );

    var composicao = TextFormField(
      onSaved: (val) => editingModel.composition = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.composition,
      decoration: InputDecoration(
          labelText: 'Composição',
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
        padding: const EdgeInsets.fromLTRB(35, 20, 35, 20),
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
              child: peso,
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

  @override
  String getTitle() => 'Satélite Natural';

}