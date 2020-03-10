import 'package:flutter/material.dart';
import 'package:planets/core/services/galaxyCrud.dart';
import 'package:planets/core/viewmodels/galaxy.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:planets/ui/widgets/info_box.dart';

class EditGalaxyState extends EditModelScreenState<Galaxy, GalaxyCRUD> {

  static Function get shortInfo {
    return (Galaxy val) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
            children: <Widget>[
              SizedBox(width: 120),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(val.name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        InfoBox(
                          value: Text(val.distance, style: TextStyle(
                              fontSize: 12, color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                          title: Text('Distância', style: TextStyle(
                              fontSize: 10, color: Colors.deepPurple)),
                          size: 75,
                        ),
                        InfoBox(
                          value: Text(val.systemCount.toString(), style: TextStyle(
                              fontSize: 12, color: Colors.deepPurple, fontWeight: FontWeight.bold)),
                          title: Text('Sistemas', style: TextStyle(
                              fontSize: 10, color: Colors.deepPurple)),
                          size: 75,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ]
        )
      );
  }

  @override
  String getTitle() {
    return 'Galáxia';
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

    var distancia = TextFormField(
      onSaved: (val) => editingModel.distance = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.distance,
      decoration: InputDecoration(
          labelText: 'Distância da Terra',
          labelStyle: style2,
          hintText: 'Distância da Terra',
          hintStyle: style,
          fillColor: Colors.white.withOpacity(0.5),
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );

    return [
      SizedBox(height: 50, width: 320,
        child: nome,
      ),
      SizedBox(height: 50, width: 320,
        child: distancia,
      ),
    ];
  }

}