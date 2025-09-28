import 'package:flutter/material.dart';
import 'package:flutter_aws_chime/models/join_info.model.dart';
import 'package:flutter_aws_chime/views/meeting.view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hipster_prac/core/constants/color_constants.dart';
import 'package:hipster_prac/core/constants/string_constants.dart';
import 'package:hipster_prac/core/extensions/text_style_extensions.dart';
import 'package:hipster_prac/core/helpers/get_safe_area.dart';
import 'package:hipster_prac/core/helpers/toast_utils.dart';
import 'package:hipster_prac/modules/meeting/meeting_controller.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({super.key});

  static const String routeName = "/meetingScreen";

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  late final _meetingController = Get.find<MeetingController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blackColor,
      appBar: PreferredSize(
        preferredSize: Size(1.sw, 64.h),
        child: AppBar(
          automaticallyImplyLeading: false,
          surfaceTintColor: ColorConstants.blackColor,
          backgroundColor: ColorConstants.blackColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Dashboard",
            style: context.robotoRegular.copyWith(
              fontSize: 22.sp,
              color: ColorConstants.whiteColor,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildMeetingWidget()),
          Center(
            child: GestureDetector(
              onTap: _meetingController.endMeeting,
              child: Container(
                width: 140.w,
                height: 40.h,
                margin: EdgeInsets.only(bottom: bottomSafeArea),
                decoration: BoxDecoration(
                  color: ColorConstants.redColor,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Icon(
                  Icons.call_end,
                  color: ColorConstants.whiteColor,
                  size: 25.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeetingWidget() {
    var meetingDetails = _meetingController.meetingDetails;
    return MeetingView(
      JoinInfo(
        MeetingInfo(
          meetingDetails?.meetingId ?? "",
          meetingDetails?.externalMeetingId ?? "",
          StringConstants.awsMediaRegion,
          MediaPlacement(
            meetingDetails?.mediaPlacementInfo?.audioHostUrl ?? "",
            meetingDetails?.mediaPlacementInfo?.audioFallbackUrl ?? "",
            meetingDetails?.mediaPlacementInfo?.signalingUrl ?? "",
            meetingDetails?.mediaPlacementInfo?.turnControlUrl ?? "",
          ),
        ),
        _meetingController.isParticipant
            ? AttendeeInfo(
                meetingDetails?.attendee1ExternalUserId ?? "",
                meetingDetails?.attendee1 ?? "",
                meetingDetails?.attendee1JoinToken ?? "",
              )
            : AttendeeInfo(
                meetingDetails?.attendee2ExternalUserId ?? "",
                meetingDetails?.attendee2 ?? "",
                meetingDetails?.attendee2JoinToken ?? "",
              ),
      ),
      onLeave: (didStop) {
        Get.back();
        makeToast(toastData: "Meeting ended");
      },
    );
  }
}
