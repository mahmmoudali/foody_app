import 'package:flutter/material.dart';

class RecipeDetailsProvider extends ChangeNotifier {
  bool _value = false;

  get value => this._value;

  set value(value) {
    this._value = value;
    notifyListeners();
  }

  Map<String, bool> _ingredients = {};

  get ingredients => this._ingredients;

  set ingredients(value) {
    this._ingredients = value;
    notifyListeners();
  }

  addIngredient(String value) {
    this._ingredients.addAll({value: false});
    notifyListeners();
  }
}
