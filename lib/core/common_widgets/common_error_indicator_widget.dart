import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hipster_prac/core/constants/color_constants.dart';
import 'package:hipster_prac/core/extensions/text_style_extensions.dart';

class CommonErrorIndicatorWidget extends StatefulWidget {
  const CommonErrorIndicatorWidget({
    super.key,
    required this.onRetry,
    required this.title,
  });

  final String title;
  final Function onRetry;

  @override
  State<CommonErrorIndicatorWidget> createState() =>
      _CommonErrorIndicatorWidgetState();
}

class _CommonErrorIndicatorWidgetState
    extends State<CommonErrorIndicatorWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Text(
              widget.title,
              textAlign: TextAlign.center,
              style: context.robotoRegular.copyWith(fontSize: 19.sp),
            ),
          ),
          SizedBox(height: 12.h),
          GestureDetector(
            onTap: () {
              widget.onRetry.call();
            },
            child: Container(
              height: 45.h,
              width: 150.w,
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.circular(100.r),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Retry",
                    style: context.robotoMedium.copyWith(
                      fontSize: 18.sp,
                      color: ColorConstants.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
