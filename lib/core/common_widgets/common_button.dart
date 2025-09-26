import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hipster_prac/core/constants/color_constants.dart';
import 'package:hipster_prac/core/extensions/text_style_extensions.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.height,
    required this.width,
    required this.title,
    required this.borderRadius,
    this.isLoading = false,
    this.onTap,
  });

  final double height;
  final double width;
  final double borderRadius;
  final String title;
  final VoidCallback? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: ColorConstants.primaryColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                height: 45.h,
                child: LoadingIndicator(
                  indicatorType: Indicator.ballPulseSync,
                  strokeWidth: 20.spMin,
                  colors: const [ColorConstants.whiteColor],
                ),
              )
            : Text(
                title,
                style: context.robotoMedium.copyWith(
                  fontSize: 19.sp,
                  color: ColorConstants.whiteColor,
                ),
              ),
      ),
    );
  }
}
