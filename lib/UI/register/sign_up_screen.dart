import 'package:flutter/material.dart';
import 'package:foody_app/colors.dart';
import 'package:foody_app/components/custom_suffix_icon.dart';
import 'package:foody_app/components/default_button.dart';
import 'package:foody_app/components/social_card.dart';
import 'package:foody_app/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sizer/sizer.dart';

class AddNewRecipeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> errors = [];

  String email, password, name, age;
  static String routeName = '/AddNewRecipeScreen';
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
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                  child: Column(
                    children: [
                      buildBackToLoginArrow(context),
                      buildLogoArea(),
                      buildSignInForm(context),
                      // SizedBox(height: 5.h),
                      // buildSocialLogin(),
                      SizedBox(height: 1.h),
                      Text(
                          'By Continuing your confirm that means you \nagree with our terms and conditions ',
                          textAlign: TextAlign.center)
                    ],
                  ),
                ),
              ),
            ),
            // provider.isLoading
            //     ? Align(
            //         alignment: Alignment.bottomCenter,
            //         child: LoadingIndicator(size: 11),
            //       )
            //     : Container()
          ],
        ));
  }

  Form buildSignInForm(BuildContext context) {
    return Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          width: double.infinity,
          child: Column(
            children: [
              buildNameFormField(),
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

  TextFormField buildNameFormField() {
    return TextFormField(
      onSaved: (newValue) => name = newValue,
      validator: (value) {
        if (value.isEmpty)
          return "You must enter your name";
        else
          return null;
      },
      onFieldSubmitted: (value) {
        _formKey.currentState.validate();
      },
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // hintText: 'Enter your email',
        suffixIcon: CustomSuffixIcon(
          svgIcon: 'assets/icons/User.svg',
        ),
        labelText: 'Name',
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
