import 'dart:io';
import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foody_app/UI/components/default_button.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

class AddNewRecipeScreen extends StatefulWidget {
  static String routeName = '/AddNewRecipeScreen';

  @override
  _AddNewRecipeScreenState createState() => _AddNewRecipeScreenState();
}

class _AddNewRecipeScreenState extends State<AddNewRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ingredientKey = GlobalKey<FormState>();
  final _stepKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController ingredientController = TextEditingController();
  TextEditingController stepController = TextEditingController();

  List<File> images = [];
  List<String> ingredients = [];
  List<String> steps = [];

  bool ingredientError = false;
  bool stepError = false;
  bool recipeError = false;
  bool imageError = false;
  bool ingredientFormError = false;
  bool stepFormError = false;

  String title, recipetype = "Breakfast", ingredient, step, description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildAddImagesBar(context),
                        ValidationError(
                          condition: imageError,
                          error: "Maximum 10 Images",
                        ),
                        buildTitleAndDescriptionForm(),
                        buildRecipeTypeDropDown(),
                        ValidationError(
                          condition: recipeError,
                          error: "Recipe type required",
                        ),
                        buildIngredientsPart(context),
                        buildStepsPart(context),
                        SizedBox(height: 2.h),
                        Container(
                          child: DefaultButton(
                            color: Theme.of(context).primaryColor,
                            press: () {
                              if (recipetype == null)
                                recipeError = true;
                              else
                                recipeError = false;
                              if (ingredients.length > 30 ||
                                  ingredients.length < 1)
                                ingredientError = true;
                              else
                                ingredientError = false;
                              if (steps.length > 30 || steps.length < 2)
                                stepError = true;
                              else
                                stepError = false;
                              if (images.length > 9)
                                imageError = true;
                              else
                                imageError = false;

                              setState(() {
                                _formKey.currentState.validate();
                                _formKey.currentState.save();
                                stepFormError = false;
                                ingredientFormError = false;
                              });
                              if (!recipeError &&
                                  !ingredientError &&
                                  !stepError &&
                                  !imageError) {
                                print("---------------Result---------------");
                                print(images.toString());
                                print(title);
                                print(description);
                                print(recipetype);
                                print(ingredients);
                                print(steps);
                                print("-----------------End-----------------");
                              }
                              //action here to submit data using post api
                            },
                            text: "Submit",
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Column buildIngredientsPart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildIngredientTextFormFieldWithAdd(context),
        ValidationError(
          condition: ingredientFormError,
          error: ingredientController.text.length > 63
              ? "Ingredient maximum is 64 chars"
              : "Ingredient minimum is 2 chars",
        ),
        ValidationError(
          condition: ingredientError,
          error: ingredients.length > 29
              ? "Maximum 30 ingredients"
              : "Minimum is 1 ingredient",
        ),
        Visibility(
          visible: ingredients.length > 0,
          child: Container(
            padding: EdgeInsets.all(.3.h),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blue[800])),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 15.h, minHeight: 10.h),
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: ingredients.length,
                itemBuilder: (context, index) => Container(
                    child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: .2.h),
                        decoration: BoxDecoration(
                            color: Colors.green[300].withOpacity(.5)),
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 1.w),
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Text(
                            ingredients[index],
                            style: TextStyle(
                                fontFamily: "Plex",
                                fontSize: 14.sp,
                                // fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )),
                    Positioned(
                      right: 1.w,
                      // top: 1.h,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            ingredients.removeAt(index);
                          });
                        },
                        child: Container(
                          height: 4.h,
                          width: 4.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            // color:
                            //     Theme.of(context).primaryColor
                          ),
                          child: Icon(FontAwesomeIcons.trash,
                              size: 2.h, color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
        )
      ],
    );
  }

  Column buildStepsPart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildStepsTextFormFieldWithAdd(context),
        ValidationError(
          condition: stepFormError,
          error: stepController.text.length > 255
              ? "Step maximum is 256 chars"
              : "Step minimum is 8 chars",
        ),
        ValidationError(
          condition: stepError,
          error: steps.length > 29 ? "Maximum 30 steps" : "Minimum is 2 step",
        ),
        Visibility(
          visible: steps.length > 0,
          child: Container(
            padding: EdgeInsets.all(.3.h),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.blue[800])),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 15.h, minHeight: 10.h),
              child: ListView.builder(
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: steps.length,
                itemBuilder: (context, index) => Container(
                    child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: .2.h),
                        decoration: BoxDecoration(
                            color: Colors.green[300].withOpacity(.5)),
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 1.w),
                        child: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Text(
                            steps[index],
                            style: TextStyle(
                                fontFamily: "Plex",
                                fontSize: 14.sp,
                                // fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        )),
                    Positioned(
                      right: 1.w,
                      // top: 1.h,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            steps.removeAt(index);
                          });
                        },
                        child: Container(
                          height: 4.h,
                          width: 4.h,
                          decoration: BoxDecoration(),
                          child: Icon(FontAwesomeIcons.trash,
                              size: 2.h, color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ],
                )),
              ),
            ),
          ),
        )
      ],
    );
  }

  Container buildIngredientTextFormFieldWithAdd(BuildContext context) {
    return Container(
      width: 100.w,
      child: Row(
        children: [
          Container(width: 80.w, child: buildIngredientFormField()),
          Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                FocusScope.of(context).unfocus();

                if (ingredientController.text.length > 63 ||
                    ingredientController.text.length <= 1) {
                  ingredientFormError = true;
                } else {
                  ingredientFormError = false;
                  ingredientError = false;
                  ingredients.add(ingredientController.text);
                  print(ingredients);
                  ingredientController.clear();
                }
              });
            },
            child: ingredients.length > 29
                ? Container()
                : Container(
                    height: 6.5.h,
                    width: 5.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Theme.of(context).primaryColor),
                    child: Icon(Icons.add, size: 3.h, color: Colors.white),
                  ),
          ),
        ],
      ),
    );
  }

  Container buildStepsTextFormFieldWithAdd(BuildContext context) {
    return Container(
      width: 100.w,
      child: Row(
        children: [
          Container(width: 80.w, child: buildStepFormField()),
          Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                FocusScope.of(context).unfocus();
                if (stepController.text.length > 255 ||
                    stepController.text.length < 8) {
                  stepFormError = true;
                } else {
                  stepFormError = false;
                  if (steps.length >= 1) stepError = false;
                  steps.add(stepController.text);
                  print(steps);
                  stepController.clear();
                }
              });
            },
            child: steps.length > 29
                ? Container()
                : Container(
                    height: 6.5.h,
                    width: 5.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Theme.of(context).primaryColor),
                    child: Icon(Icons.add, size: 3.h, color: Colors.white),
                  ),
          ),
        ],
      ),
    );
  }

  Container buildRecipeTypeDropDown() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select Recipe type",
            style: TextStyle(
                fontFamily: "Plex",
                fontSize: 14.sp,
                // fontWeight: FontWeight.bold,
                color: Colors.grey[600]),
          ),
          AwesomeDropDown(
            isBackPressedOrTouchedOutSide: false,
            dropDownBorderRadius: 3,
            dropDownTopBorderRadius: 1.h,
            dropDownBottomBorderRadius: 1.h,
            dropDownListTextStyle: TextStyle(
              fontFamily: "Plex",
              fontSize: 14.sp,
            ),
            isPanDown: false,
            dropDownList: ["Breakfast", "Launch", "Dinner", "Dessert"],
            dropDownIcon: Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
              size: 23,
            ),
            selectedItem: recipetype,
            onDropDownItemClick: (selectedItem) {
              recipetype = selectedItem;
            },
            dropStateChanged: (isOpened) {
              // _isDropDownOpened = isOpened;
              // if (!isOpened) {
              //   _isBackPressedOrTouchedOutSide = false;                    }
            },
          ),
        ],
      ),
    );
  }

  Widget buildTitleAndDescriptionForm() {
    return Column(
      children: [
        buildTitleFormField(),
        SizedBox(height: .5.h),
        buildDescriptionFormField(),
      ],
    );
  }

  Column buildAddImagesBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Row(
            children: [
              Container(
                height: 15.h,
                width: 90.w,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        List<PickedFile> pickedImages = await ImagePicker()
                            .getMultiImage(
                                maxWidth: 1920,
                                maxHeight: 1200,
                                imageQuality: 80);
                        pickedImages.forEach((e) => images.add(File(e.path)));
                        setState(() {
                          print(images);
                          if (images.length > 9)
                            _scaffoldKey.currentState.showSnackBar(SnackBar(
                              content: Text("Maximum 10 images"),
                              backgroundColor: Theme.of(context).errorColor,
                            ));
                        });
                      },
                      child: Container(
                        width: images.length > 0 ? 20.w : 90.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(2.h)),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Icon(FontAwesomeIcons.camera, color: Colors.white),
                            SizedBox(width: 2.w),
                            images.length > 0
                                ? Container()
                                : Text(
                                    "ADD",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Plex",
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11.sp),
                                  ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: images.length > 0,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2.w),
                        height: 15.h,
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(maxWidth: 1000.h, minWidth: 0.h),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: images.length,
                            itemBuilder: (context, index) => Stack(
                              // alignment: Alignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 2.w),
                                  // height: 15.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: FileImage(
                                              File(images[index].path)),
                                          fit: BoxFit.cover),
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(2.h)),
                                ),
                                Positioned(
                                  right: 5.w,
                                  top: 1.h,
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        images.removeAt(index);
                                      });
                                    },
                                    child: Container(
                                      height: 4.h,
                                      width: 4.h,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Theme.of(context).primaryColor),
                                      child: Icon(FontAwesomeIcons.trash,
                                          size: 2.h, color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  TextFormField buildTitleFormField() {
    return TextFormField(
      onSaved: (newValue) => title = newValue,
      validator: (value) {
        if (value.isEmpty)
          return "You must enter recipe title";
        else if (value.length < 7)
          return "recipe title must be more than 8 chars";
        else if (value.length > 63)
          return "recipe title maximum is 64 chars";
        else
          return null;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).unfocus();
        _formKey.currentState.validate();
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // hintText: 'Enter your email',

        labelText: 'Title',
      ),
    );
  }

  TextFormField buildDescriptionFormField() {
    return TextFormField(
      inputFormatters: [
        // LengthLimitingTextInputFormatter(maxLength)
      ],
      onSaved: (newValue) => description = newValue,
      validator: (value) {
        if (value.isEmpty)
          return "You must enter recipe description";
        else if (value.length < 15)
          return "recipe decription must be more than 8 chars";
        else if (value.length > 127)
          return "recipe decription maximum is 128 chars";
        else
          return null;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).unfocus();
        _formKey.currentState.validate();
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // hintText: 'Enter your email',

        labelText: 'Description',
      ),
    );
  }

  Widget buildIngredientFormField() {
    return TextFormField(
      controller: ingredientController,
      onSaved: (newValue) => ingredient = newValue,
      // validator: (value) {
      //   if (value.isEmpty)
      //     return "You must enter ingredient content";
      //   else if (value.length < 8)
      //     return "ingredient must be more than 10 chars";
      //   else
      //     return null;
      // },
      onFieldSubmitted: (value) {
        FocusScope.of(context).unfocus();
        _ingredientKey.currentState.validate();
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // hintText: 'Enter your email',

        labelText: 'Ingredient',
      ),
    );
  }

  Widget buildStepFormField() {
    return TextFormField(
      controller: stepController,
      onSaved: (newValue) => ingredient = newValue,
      // validator: (value) {
      //   if (value.isEmpty)
      //     return "You must enter step content";
      //   else if (value.length < 8)
      //     return "step must be more than 10 chars";
      //   else
      //     return null;
      // },
      onFieldSubmitted: (value) {
        FocusScope.of(context).unfocus();
        _stepKey.currentState.validate();
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // hintText: 'Enter your email',

        labelText: 'Step',
      ),
    );
  }
}

class ValidationError extends StatelessWidget {
  const ValidationError({
    Key key,
    @required this.condition,
    this.error,
  }) : super(key: key);

  final bool condition;
  final String error;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: condition,
      child: Container(
        child: Text(
          error,
          style: TextStyle(
              // fontFamily: "Plex",
              fontSize: 14.sp,
              // fontWeight: FontWeight.bold,
              color: Theme.of(context).errorColor),
        ),
      ),
    );
  }
}
