import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    Key key,
    this.icon,
    this.press,
  }) : super(key: key);

  final String icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 3.w),
        padding: EdgeInsets.all(2.w),
        height: 5.h,
        width: 5.h,
        decoration:
            BoxDecoration(color: Colors.grey[200], shape: BoxShape.circle),
        child: SvgPicture.asset(icon),
      ),
    );
  }
}
