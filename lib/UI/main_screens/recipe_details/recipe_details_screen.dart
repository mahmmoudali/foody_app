import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foody_app/UI/main_screens/add_new_recipe/addNewRecipe.dart';
import 'package:foody_app/UI/main_screens/recipe_details/recipe_details_presenter.dart';
import 'package:foody_app/UI/main_screens/recipe_details/recipe_details_provider.dart';
import 'package:foody_app/responses/recipe_response.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class RecipeDetailsScreen extends StatelessWidget {
  static final String routeName = "/RecipeDetailsScreen";

  final RecipeDetailsPresenter presenter = RecipeDetailsPresenter();

  List<String> images = [
    "assets/images/food.jpeg",
    "assets/images/food2.jpeg",
    "assets/images/food3.jpeg"
  ];

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
                                    buildRecipePhoto(context, images),
                                    buildIngredients(response, context),
                                    buildSteps(response, context)
                                  ]),
                            ),
                          )
                        : Center(child: CircularProgressIndicator())),
              );
            },
          );
        });
  }

  Column buildSteps(RecipeResponse response, BuildContext context) {
    final provider = Provider.of<RecipeDetailsProvider>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 300.h, minHeight: 0.h),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: response.result.recipe.directions.length,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(vertical: .5.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => provider.changeStepValue(
                        response.result.recipe.directions[index],
                        !provider
                            .steps[response.result.recipe.directions[index]]),
                    child:
                        provider.steps[response.result.recipe.directions[index]]
                            ? Icon(FontAwesomeIcons.solidCheckCircle,
                                color: Theme.of(context).primaryColor)
                            : Icon(
                                FontAwesomeIcons.checkCircle,
                                color: Colors.black,
                              ),
                  ),
                  SizedBox(width: 1.h),
                  Container(
                    padding: EdgeInsets.only(top: .5.h),
                    width: 80.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Step ${index + 1}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontFamily: "Plex",
                              fontWeight: FontWeight.bold,
                              fontSize: 11.sp),
                        ),
                        SizedBox(height: .5.h),
                        Text(
                          response.result.recipe.directions[index],
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontFamily: "Plex",
                              // fontWeight: FontWeight.bold,
                              fontSize: 11.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildIngredients(RecipeResponse response, BuildContext context) {
    final provider = Provider.of<RecipeDetailsProvider>(context, listen: true);

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
        provider.ingredients != null
            ? ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 300.h, minHeight: 0.h),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: provider.ingredients.length,
                  itemBuilder: (context, index) => buildIngredientCheckBox(
                    lineThrough: provider
                        .ingredients[response.result.recipe.ingredients[index]],
                    onChanged: (bool newValue) =>
                        // provider.value = newValue,
                        provider.changeIngredientValue(
                            response.result.recipe.ingredients[index],
                            newValue),
                    text: response.result.recipe.ingredients[index],
                    value: provider
                        .ingredients[response.result.recipe.ingredients[index]],
                  ),
                ),
              )
            : Container()
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
          backgroundImage: AssetImage("assets/images/doctor.jpg"),
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

Center buildRecipePhoto(BuildContext context, List<String> images) {
  return Center(
    child: Visibility(
      visible: images.length > 0,
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 2.w),
        height: 25.h,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1000.h, minWidth: 0.h),
          child: ListView.builder(
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (context, index) => Stack(
              // alignment: Alignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 1.h, top: 1.h, right: 3.w),
                  width: 90.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(images[index]), fit: BoxFit.cover),
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(3.h)),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
    // child: Container(
    //   margin: EdgeInsets.only(bottom: 1.h, top: 1.h),
    //   height: 25.h,
    //   width: 90.w,
    //   decoration: BoxDecoration(
    //       image: DecorationImage(
    //           image: AssetImage("assets/images/food2.jpeg"), fit: BoxFit.cover),
    //       color: Theme.of(context).primaryColor,
    //       borderRadius: BorderRadius.circular(3.h)),
    // ),
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
      child: Icon(Icons.add, color: Theme.of(context).primaryColor),
    ),
  );
}

class buildIngredientCheckBox extends StatelessWidget {
  const buildIngredientCheckBox({
    Key key,
    this.value,
    this.onChanged,
    this.text,
    this.lineThrough,
  }) : super(key: key);
  final bool value;
  final Function(bool) onChanged;
  final String text;
  final bool lineThrough;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            checkColor: Colors.white,
            activeColor: Theme.of(context).primaryColor,
          ),
          Text(
            text,
            textAlign: TextAlign.start,
            style: TextStyle(
                decoration: lineThrough
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
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
