import 'package:flutter/material.dart';
import 'package:foody_app/UI/info_details/recipe_details_presenter.dart';
import 'package:foody_app/colors.dart';
import 'package:foody_app/responses/recipe_response.dart';
import 'package:sizer/sizer.dart';

class RecipeDetailsScreen extends StatelessWidget {
  static final String routeName = "/RecipeDetailsScreen";
  RecipeDetailsPresenter presenter = RecipeDetailsPresenter();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: presenter.getRecipeDetails(),
        builder: (context, snapshot) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                color: Color(0xFFF3F4F5),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        buildAppBar(context),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 1.h, top: 2.h),
                            height: 25.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/images/baby.jpg"),
                                    fit: BoxFit.cover),
                                color: MColors.covidMain,
                                borderRadius: BorderRadius.circular(3.h)),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 1.h),
                          child: Text(
                            snapshot.data.title,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: "Plex",
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 1.h),
                          width: 90.w,
                          child: Text(
                            snapshot.data.description,
                            maxLines: 100,
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontFamily: "Plex",
                                // fontWeight: FontWeight.bold,
                                fontSize: 14.sp),
                          ),
                        )
                      ]),
                ),
              ),
            ),
          );
        });
  }

  Center buildAppBar(BuildContext context) {
    return Center(
      child: Container(
        child: Row(
          children: [
            buildButtonBack(context),
            Spacer(),
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
          ],
        ),
      ),
    );
  }

  Widget buildButtonBack(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: EdgeInsets.all(1.h),
        width: 5.h,
        height: 5.h,
        child: Icon(Icons.arrow_back_ios, color: MColors.covidMain),
      ),
    );
  }
}
