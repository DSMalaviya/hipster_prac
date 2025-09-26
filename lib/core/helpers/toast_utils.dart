import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:hipster_prac/core/extensions/text_style_extensions.dart';

makeToast({String? toastData, Alignment? toastAlign}) {
  showToast(
    toastData ?? "Oops something went wrong",
    context: Get.overlayContext,
    backgroundColor: Colors.black.withValues(alpha: 0.9),
    textStyle: CustomTextStyles.robotoMedium(
      Get.context!,
    ).copyWith(color: Colors.white, fontSize: 15.sp),
    animation: StyledToastAnimation.slideFromBottomFade,
    reverseAnimation: StyledToastAnimation.fade,
    duration: const Duration(seconds: 3),
    alignment: toastAlign ?? Alignment.bottomCenter,
    borderRadius: BorderRadius.circular(30.r),
  );
}
