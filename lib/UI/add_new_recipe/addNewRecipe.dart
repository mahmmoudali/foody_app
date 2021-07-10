import 'dart:io';
import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:find_dropdown/find_dropdown.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foody_app/colors.dart';
import 'package:foody_app/components/custom_suffix_icon.dart';
import 'package:foody_app/components/default_button.dart';
import 'package:foody_app/components/social_card.dart';
import 'package:foody_app/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

class AddNewRecipeScreen extends StatefulWidget {
  static String routeName = '/AddNewRecipeScreen';

  @override
  _AddNewRecipeScreenState createState() => _AddNewRecipeScreenState();
}

class _AddNewRecipeScreenState extends State<AddNewRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController ingredientController = TextEditingController();

  final List<String> errors = [];

  List<File> images = [];
  List<String> ingredients = [];

  String email, password, title, age, recipetype, ingredient;

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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildAddImagesBar(context),
                      ValidationError(
                        condition: images.length > 9,
                        error: "Maximum 10 Images",
                      ),
                      buildTitleAndDescriptionForm(),
                      buildRecipeTypeDropDown(),
                      Column(
                        children: [
                          buildIngredientTextFormFieldWithAdd(context),
                          Container(
                            height: 30.h,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: ingredients.length,
                              itemBuilder: (context, index) =>
                                  Container(child: Text(ingredients[index])),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
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
                ingredients.add(ingredientController.text);
                print(ingredients);
                ingredientController.clear();
              });
            },
            child: Container(
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
            dropDownList: ["Breakfast", "Launch", "Dinner"],
            dropDownIcon: Icon(
              Icons.arrow_drop_down,
              color: Colors.grey,
              size: 23,
            ),
            selectedItem: recipetype ?? "Not selected",
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

  Form buildTitleAndDescriptionForm() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            buildTitleFormField(),
            SizedBox(height: .5.h),
            buildDescriptionFormField(),
          ],
        ));
  }

  Column buildAddImagesBar(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Insert Recipe Images",
          style: TextStyle(
              fontFamily: "Plex",
              fontSize: 16.sp,
              // fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Row(
            children: [
              Container(
                height: 15.h,
                width: 90.w,
                child: ListView(
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
                        width: 20.w,
                        height: 15.h,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(2.h)),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Spacer(),
                            Icon(FontAwesomeIcons.plusSquare,
                                color: Colors.white),
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
                        width: images.length > 0
                            ? ((images.length + 1) * 41.w) - 25.w
                            : 100.w,
                        child: ListView.builder(
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
                                        image:
                                            FileImage(File(images[index].path)),
                                        fit: BoxFit.cover),
                                    color: MColors.covidMain,
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
                                        color: Theme.of(context).primaryColor),
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
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Form buildSignInForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          width: double.infinity,
          child: Column(
            children: [
              // buildNameFormField(),
              SizedBox(height: 1.h),
              buildAgeFormField(),
              SizedBox(height: 1.h),
              buildEmailFormField(context),
              SizedBox(height: 1.h),
              buildPasswordFormField(context),
              SizedBox(height: 4.h),
              DefaultButton(
                text: 'Continue',
                press: () {
                  submit(context);
                },
              ),
            ],
          ),
        ));
  }

  Future submit(BuildContext context) async {
    // final provider = Provider.of<EmailSignInProvider>(context, listen: false);
    // provider.isLogin = false;
    // FocusScope.of(context).unfocus();
    // if (_formKey.currentState.validate()) {
    //   _formKey.currentState.save();
    //   final isSuccess = await provider.login();
    //   if (isSuccess) {
    //     final msg = "Account Registered";
    //     _scaffoldKey.currentState.showSnackBar(SnackBar(
    //       content: Text(msg),
    //       backgroundColor: MColors.covidMain,
    //     ));

    //     await Future.delayed(Duration(seconds: 1));
    //     Navigator.pop(context);
    //   } else {
    //     final msg = "An error occurred, please check your credential";
    //     _scaffoldKey.currentState.showSnackBar(SnackBar(
    //       content: Text(msg),
    //       backgroundColor: Theme.of(context).errorColor,
    //     ));
    //   }
    // }
  }

  Align buildBackToLoginArrow(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios, size: 2.h),
              Text(
                "login",
                style: TextStyle(color: MColors.kTextColor),
              )
            ],
          )),
    );
  }

  Widget buildLogoArea() {
    return Column(
      children: [
        Container(
          height: 15.h,
          width: 20.h,
          child: Image.asset("assets/images/logo-trial.png"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "COVID-19 ",
              style: TextStyle(
                  fontFamily: "Plex",
                  fontSize: 2.5.h,
                  fontWeight: FontWeight.bold,
                  color: MColors.covidMain),
            ),
            Text(
              "APP",
              style: TextStyle(
                  fontFamily: "Plex",
                  fontSize: 2.5.h,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightGreen),
            )
          ],
        ),
      ],
    );
  }

  buildSocialLogin() {
    return Column(
      children: [
        Text(
          "Or you can register with",
          style: TextStyle(fontFamily: "Plex", color: MColors.kTextColor),
        ),
        SizedBox(height: 1.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialCard(
              icon: 'assets/icons/google-icon.svg',
              press: () {},
            ),
            SocialCard(
              icon: 'assets/icons/facebook-2.svg',
              press: () {},
            ),
          ],
        ),
      ],
    );
  }

  TextFormField buildPasswordFormField(BuildContext context) {
    // final provider = Provider.of<EmailSignInProvider>(context);
    return TextFormField(
      onSaved: (newValue) => password = newValue,
      validator: (value) {
        if (value.isEmpty)
          return "You must enter a password";
        else if (value.length < 8)
          return "Password must be more than 8 chars";
        else
          return null;
      },
      onFieldSubmitted: (value) {
        _formKey.currentState.validate();
      },
      obscureText: true,
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // hintText: 'nter your password',
        suffixIcon: CustomSuffixIcon(
          svgIcon: 'assets/icons/Lock.svg',
        ),
        labelText: 'Password',
      ),
    );
  }

  TextFormField buildEmailFormField(BuildContext context) {
    // final provider = Provider.of<EmailSignInProvider>(context);

    return TextFormField(
      onSaved: (newValue) => email = newValue,
      validator: (value) {
        if (value.isEmpty)
          return "You must enter an email";
        else if (!emailValidatorRegExp.hasMatch(value))
          return "You must enter a valid email";
        else
          return null;
      },
      onFieldSubmitted: (value) {
        _formKey.currentState.validate();
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // hintText: 'Enter your email',
        suffixIcon: CustomSuffixIcon(
          svgIcon: 'assets/icons/Mail.svg',
        ),
        labelText: 'Email',
      ),
    );
  }

  TextFormField buildTitleFormField() {
    return TextFormField(
      onSaved: (newValue) => title = newValue,
      validator: (value) {
        if (value.isEmpty)
          return "You must enter recipe title";
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
      onSaved: (newValue) => title = newValue,
      validator: (value) {
        if (value.isEmpty)
          return "You must enter recipe description";
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

  TextFormField buildIngredientFormField() {
    return TextFormField(
      controller: ingredientController,
      onSaved: (newValue) => ingredient = newValue,
      validator: (value) {
        if (value.isEmpty)
          return "You must enter recipe description";
        else
          return null;
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).unfocus();
        // _formKey.currentState.validate();
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // hintText: 'Enter your email',

        labelText: 'Description',
      ),
    );
  }

  TextFormField buildAgeFormField() {
    return TextFormField(
      onSaved: (newValue) => age = newValue,
      validator: (value) {
        if (value.isEmpty)
          return "You must enter your age";
        else
          return null;
      },
      onFieldSubmitted: (value) {
        _formKey.currentState.validate();
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // hintText: 'Enter your email',
        suffixIcon: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Icon(FontAwesomeIcons.calendarAlt),
        ),
        labelText: 'Age',
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
