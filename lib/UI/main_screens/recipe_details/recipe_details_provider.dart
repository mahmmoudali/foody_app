import 'package:flutter/material.dart';
import 'package:foody_app/UI/main_screens/recipe_details/recipe_details_presenter.dart';
import 'package:foody_app/responses/recipe_response.dart';

class RecipeDetailsProvider extends ChangeNotifier {
  RecipeDetailsPresenter presenter = RecipeDetailsPresenter();
  RecipeResponse response = RecipeResponse();
  RecipeDetailsProvider() {
    loadData();
  }
  Future loadData() async {
    response = await presenter.getRecipeDetails();
    response.result.recipe.ingredients.forEach((element) {
      addIngredient(element);
    });
    response.result.recipe.directions.forEach((element) {
      addStep(element);
    });
  }

  bool _value = false;

  get value => this._value;

  set value(value) {
    this._value = value;
    notifyListeners();
  }

  Map<String, bool> ingredients = {};

  addIngredient(String value) {
    ingredients.addAll({value: false});
    notifyListeners();
  }

  changeIngredientValue(String ingredient, bool value) {
    ingredients[ingredient] = value;
    notifyListeners();
  }

  Map<String, bool> steps = {};

  addStep(String value) {
    steps.addAll({value: false});
    notifyListeners();
  }

  changeStepValue(String step, bool value) {
    steps[step] = value;
    notifyListeners();
  }
}
