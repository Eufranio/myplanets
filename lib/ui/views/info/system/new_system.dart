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
  Future<void> onSave() async {
    await Provider.of<SystemCRUD>(context, listen: false).remove(editingModel.id);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Future<void> onDelete() async {
    await Provider.of<SystemCRUD>(context, listen: false).remove(editingModel.id);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
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

    var idade = TextFormField(
      onSaved: (val) => editingModel.age = val,
      style: style,
      textAlign: TextAlign.center,
      initialValue: widget.model?.age,
      decoration: InputDecoration(
          labelText: 'Idade',
          labelStyle: style2,
          hintText: 'Idade',
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
       child: idade,
      ),
    ];
  }

}