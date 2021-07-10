import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foody_app/colors.dart';
import 'package:sizer/sizer.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key key,
    @required this.size,
  }) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.h,
      width: size.h,
      padding: EdgeInsets.all(3.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.h)),
      child: SpinKitFadingCube(
        itemBuilder: (context, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? MColors.covidMain : Colors.green,
            ),
          );
        },
      ),
    );
  }
}
