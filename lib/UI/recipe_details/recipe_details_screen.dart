import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foody_app/UI/add_new_recipe/addNewRecipe.dart';
import 'package:foody_app/UI/recipe_details/recipe_details_presenter.dart';
import 'package:foody_app/UI/recipe_details/recipe_details_provider.dart';

import 'package:foody_app/colors.dart';
import 'package:foody_app/responses/recipe_response.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RecipeDetailsScreen extends StatelessWidget {
  static final String routeName = "/RecipeDetailsScreen";
  RecipeDetailsPresenter presenter = RecipeDetailsPresenter();

  @override
  Widget build(BuildContext _) {
    return ChangeNotifierProvider(
        create: (_) => RecipeDetailsProvider(),
        builder: (context, child) {
          final provider =
              Provider.of<RecipeDetailsProvider>(context, listen: true);
          return FutureBuilder(
            future: presenter.getRecipeDetails(),
            builder: (context, AsyncSnapshot<RecipeResponse> snapshot) {
              RecipeResponse response = snapshot.data;
              return Scaffold(
                body: SafeArea(
                    child: snapshot.hasData
                        ? Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 2.h),
                            color: Color(0xFFF3F4F5),
                            child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    buildAppBar(context),
                                    buildRecipeTitle(response),
                                    buildRecipeDescription(response),
                                    buildUserPhotoAndName(response),
                                    buildRecipePhoto(),
                                    buildIngredients(response, provider),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top: 1.h),
                                          child: Text("Steps",
                                              textAlign: TextAlign.start,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontFamily: "Plex",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15.sp)),
                                        ),
                                        Container(
                                          height: 120.h,
                                          child: ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: response.result.recipe
                                                .directions.length,
                                            itemBuilder: (context, index) =>
                                                Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: .5.h),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .checkCircle,
                                                  ),
                                                  SizedBox(width: 1.h),
                                                  Container(
                                                    width: 80.w,
                                                    child: Text(
                                                      response.result.recipe
                                                          .directions[index],
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.grey[700],
                                                          fontFamily: "Plex",
                                                          // fontWeight: FontWeight.bold,
                                                          fontSize: 11.sp),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          )
                        : Center(child: CircularProgressIndicator())),
              );
            },
          );
        });
  }

  Widget buildIngredients(
      RecipeResponse response, RecipeDetailsProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1.h),
          child: Text("Ingredients",
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontFamily: "Plex",
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp)),
        ),
        Container(
          height: 65.h,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: response.result.recipe.ingredients.length,
            itemBuilder: (context, index) => buildIngredientCheckBox(
              onChanged: (bool newValue) => provider.value = newValue,
              text: response.result.recipe.ingredients[index],
              value: provider.value,
            ),
          ),
        )
      ],
    );
  }
}

Container buildUserPhotoAndName(RecipeResponse response) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: .5.h),
    child: Row(
      children: [
        CircleAvatar(
          radius: 2.h,
          backgroundImage: AssetImage("assets/images/doctor.png"),
        ),
        SizedBox(width: 2.h),
        Text(
          response.result.recipe.username,
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontFamily: "Plex", fontWeight: FontWeight.bold, fontSize: 11.sp),
        )
      ],
    ),
  );
}

Container buildRecipeDescription(RecipeResponse response) {
  return Container(
    margin: EdgeInsets.only(bottom: 1.h),
    width: 90.w,
    child: Text(
      response.result.recipe.description,
      textAlign: TextAlign.start,

      // overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontFamily: "Plex",
          // fontWeight: FontWeight.bold,
          fontSize: 13.sp),
    ),
  );
}

Container buildRecipeTitle(RecipeResponse response) {
  return Container(
    margin: EdgeInsets.only(bottom: 1.h),
    child: Text(
      response.result.recipe.title,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontFamily: "Plex", fontWeight: FontWeight.bold, fontSize: 15.sp),
    ),
  );
}

Center buildRecipePhoto() {
  return Center(
    child: Container(
      margin: EdgeInsets.only(bottom: 1.h, top: 1.h),
      height: 25.h,
      width: 90.w,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/food.jpeg"), fit: BoxFit.cover),
          color: MColors.covidMain,
          borderRadius: BorderRadius.circular(3.h)),
    ),
  );
}

Center buildAppBar(BuildContext context) {
  return Center(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          Spacer(flex: 2),
          Text(
            "Recipe Details",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.grey[700],
                fontFamily: "Plex",
                fontWeight: FontWeight.bold,
                fontSize: 14.sp),
          ),
          Spacer(flex: 2),
          buildAdd(context),
        ],
      ),
    ),
  );
}

Widget buildAdd(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.pushNamed(context, AddNewRecipeScreen.routeName),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      width: 5.h,
      height: 5.h,
      child: Icon(Icons.add, color: MColors.covidMain),
    ),
  );
}

class buildIngredientCheckBox extends StatelessWidget {
  const buildIngredientCheckBox({
    Key key,
    this.value,
    this.onChanged,
    this.text,
  }) : super(key: key);
  final bool value;
  final Function(bool) onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
          ),
          Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.grey[700],
                fontFamily: "Plex",
                // fontWeight: FontWeight.bold,
                fontSize: 11.sp),
          ),
        ],
      ),
    );
  }
}
