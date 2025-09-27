import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hipster_prac/core/constants/color_constants.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoaderUtils {
  //variable to track if existing loader is shown or not
  static bool isLoaderShown = false;

  static void showLoader() {
    if (!isLoaderShown) {
      isLoaderShown = true;
      Get.dialog(
        barrierColor: ColorConstants.blackColor.withValues(alpha: 0.1),
        PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: ColorConstants.transperentColor,
            elevation: 0,
            child: Center(
              child: SizedBox(
                height: 65.h,
                width: 65.h,
                child: const LoadingIndicator(
                  indicatorType: Indicator.ballRotateChase,
                  colors: [ColorConstants.primaryColor],
                ),
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  static void hideLoader() {
    if (isLoaderShown) {
      Get.back();
      isLoaderShown = false;
    }
  }
}
