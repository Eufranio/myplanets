import 'package:flutter/material.dart';
import 'package:planets/core/services/systemCrud.dart';
import 'package:planets/core/viewmodels/system.dart';
import 'package:planets/ui/views/info/edit_model.dart';

class EditSystemState extends EditModelScreenState<System, SystemCRUD> {

  @override
  Iterable<Widget> getFields() {
    return [

    ];
  }

  @override
  String getTitle() => 'Sistema Planetário';
}