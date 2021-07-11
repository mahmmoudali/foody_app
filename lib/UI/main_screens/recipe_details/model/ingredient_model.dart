import 'package:flutter/cupertino.dart';

class Ingredient {
  bool _value = false;

  get value => this._value;

  set value(value) => this._value = value;

  final String name;

  Ingredient({@required this.name}) {
    value = false;
  }
}
