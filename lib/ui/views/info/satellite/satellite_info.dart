import 'package:flutter/material.dart';
import 'package:planets/core/viewmodels/naturalSatellite.dart';
import 'package:planets/ui/views/info/info_model.dart';

class SatelliteInfoState extends InfoModelScreenState<NaturalSatellite> {

  @override
  Iterable<Widget> getFields() {
    return [Text('Bondia')];
  }

}