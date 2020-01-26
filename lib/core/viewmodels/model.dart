import 'package:flutter/material.dart';

abstract class Model {
  Widget getInfoScreen();
  Widget getNewPlanet();
  String name;
}