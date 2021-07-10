import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class CustomSuffixIcon extends StatelessWidget {
  const CustomSuffixIcon({Key key, this.svgIcon, this.color}) : super(key: key);

  final String svgIcon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0,
        4.w,
        4.w,
        4.w,
      ),
      child: SvgPicture.asset(
        svgIcon,
        color: color,
        // height: .05.h,
      ),
    );
  }
}
