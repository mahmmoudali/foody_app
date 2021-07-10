import 'package:flutter/material.dart';
import 'package:foody_app/routes.dart';
import 'package:sizer/sizer.dart';

import 'UI/recipe_details/recipe_details_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MaterialApp(
        title: 'Foody',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        initialRoute: RecipeDetailsScreen.routeName,
        routes: Routes.routes,
      );
    });
  }
}
