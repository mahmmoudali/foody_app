import 'package:flutter/material.dart';
import 'package:foody_app/responses/recipe_response.dart';

class RecipeDetailsProvider extends ChangeNotifier {
  bool _value = false;

  get value => this._value;

  set value(value) {
    this._value = value;
    notifyListeners();
  }
}
