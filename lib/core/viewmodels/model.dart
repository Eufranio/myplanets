import 'package:flutter/material.dart';

abstract class Model {
  Widget getInfo();
  Widget getEdit();
  String name;
  String id;

  bool operator == (m) => m is Model && id == m.id;
}