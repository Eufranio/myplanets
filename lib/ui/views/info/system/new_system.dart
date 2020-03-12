import 'package:flutter/material.dart';
import 'package:planets/core/services/systemCrud.dart';
import 'package:planets/core/viewmodels/system.dart';
import 'package:planets/ui/views/info/edit_model.dart';
import 'package:provider/provider.dart';

import '../../../../core/services/systemCrud.dart';


class EditSystemState extends EditModelScreenState<System, SystemCRUD>{

  @override
  String getTitle() {
    return 'Sistemas Panetários';
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


    return [
      SizedBox(height: 50, width: 320,
        child: nome,
      ),
      SizedBox(height: 20, width: 1,
      ),
      SizedBox(height: 50, width: 320,
       child: idade,
      ),
    ];
  }

}