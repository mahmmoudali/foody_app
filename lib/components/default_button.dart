import 'package:flutter/material.dart';
import 'package:foody_app/colors.dart';

import 'package:sizer/sizer.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key key,
    this.press,
    this.text,
    this.color,
    this.textColor,
    this.size,
  }) : super(key: key);
  final Function press;
  final String text;
  final double size;

  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 6.h,
      child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: color ?? MColors.covidMain,
          onPressed: press,
          child: Text(
            '$text',
            style: TextStyle(
                fontFamily: "Plex",
                fontWeight: FontWeight.bold,
                fontSize: size ?? 16.sp,
                color: textColor ?? Colors.white),
          )),
    );
  }
}
