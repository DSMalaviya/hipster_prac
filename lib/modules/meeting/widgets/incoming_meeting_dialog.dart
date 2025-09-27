import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hipster_prac/core/constants/color_constants.dart';
import 'package:hipster_prac/core/constants/string_constants.dart';
import 'package:hipster_prac/core/extensions/text_style_extensions.dart';
import 'package:hipster_prac/core/helpers/permission_helper.dart';
import 'package:hipster_prac/data/models/meeting_creation_model.dart';
import 'package:hipster_prac/modules/meeting/meeting_screen.dart';

Future<void> showIncomingMeetingDialog(MeetingDetails meetingDetails) async {
  Get.dialog(
    CupertinoAlertDialog(
      content: Text(
        "Incoming call from ${meetingDetails.attendee1Name}",
        style: Get.context!.robotoMedium.copyWith(fontSize: 16.sp),
      ),
      actions: [
        CupertinoDialogAction(
          onPressed: () async {
            if (await PermissionHelper.checkCameraAndMicrophonePermission()) {
              Get.back();
              Get.toNamed(
                MeetingScreen.routeName,
                arguments: {
                  ArgConstants.meetingDetailArg: meetingDetails,
                  ArgConstants.isCallerArg: false,
                },
              );
            }
          },
          child: Text(
            "Accept",
            style: Get.context!.robotoMedium.copyWith(
              fontSize: 16.sp,
              color: ColorConstants.greenColor,
            ),
          ),
        ),
        CupertinoDialogAction(
          onPressed: () {
            Get.back();
          },
          child: Text(
            "Reject",
            style: Get.context!.robotoMedium.copyWith(
              fontSize: 16.sp,
              color: ColorConstants.redColor,
            ),
          ),
        ),
      ],
    ),
  );
}
