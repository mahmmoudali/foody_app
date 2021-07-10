import 'package:flutter/material.dart';
import 'package:foody_app/UI/info_details/recipe_details_screen.dart';
import 'package:foody_app/UI/register/sign_up_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> routes = {
    RecipeDetailsScreen.routeName: (context) => RecipeDetailsScreen(),
    AddNewRecipeScreen.routeName: (context) => AddNewRecipeScreen(),
  };
}
