import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foody_app/colors.dart';
import 'package:sizer/sizer.dart';

class FormError extends StatelessWidget {
  const FormError({
    Key key,
    @required this.errors,
  }) : super(key: key);

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
            errors.length, (index) => formErrorText(error: errors[index])));
  }

  Widget formErrorText({String error}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: .2.h),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/Error.svg',
            height: 2.h,
            width: 2.w,
          ),
          SizedBox(
            width: 1.w,
          ),
          Text(
            error,
            style: TextStyle(color: MColors.kTextColor),
          )
        ],
      ),
    );
  }
}
