import 'package:flutter/material.dart';
import 'UI/main_screens/add_new_recipe/addNewRecipe.dart';
import 'UI/main_screens/recipe_details/recipe_details_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = {
    RecipeDetailsScreen.routeName: (context) => RecipeDetailsScreen(),
    AddNewRecipeScreen.routeName: (context) => AddNewRecipeScreen(),
  };
}
