import 'package:flutter/material.dart';

abstract class Model {
  Widget getInfo();
  Widget getEdit();
  String name;
  String id;
}