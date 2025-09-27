import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hipster_prac/core/constants/color_constants.dart';
import 'package:hipster_prac/core/extensions/text_style_extensions.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> checkCameraAndMicrophonePermission() async {
    return (await PermissionHelper.checkPermission(
          permission: Permission.camera,
          permissionName: "camera",
        ) &&
        await PermissionHelper.checkPermission(
          permission: Permission.microphone,
          permissionName: "microphone",
        ));
  }

  static Future<bool> checkPermission({
    required Permission permission,
    required String permissionName,
  }) async {
    final permissionStatus = await permission.request();
    if (permissionStatus == PermissionStatus.granted ||
        permissionStatus == PermissionStatus.provisional) {
      return true;
    } else {
      //open alert dialog for permission
      Get.dialog(
        CupertinoAlertDialog(
          content: Text(
            "Please allow $permissionName permission",
            style: Get.context!.robotoMedium.copyWith(fontSize: 16.sp),
          ),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Get.back();
                openAppSettings();
              },
              child: Text(
                "Ok",
                style: Get.context!.robotoMedium.copyWith(
                  fontSize: 16.sp,
                  color: ColorConstants.blackColor,
                ),
              ),
            ),
            CupertinoDialogAction(
              onPressed: () => Get.back(),
              child: Text(
                "Cancel",
                style: Get.context!.robotoMedium.copyWith(
                  fontSize: 16.sp,
                  color: ColorConstants.redColor,
                ),
              ),
            ),
          ],
        ),
      );
      return false;
    }
  }
}
