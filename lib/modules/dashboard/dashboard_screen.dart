import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hipster_prac/core/common_widgets/common_error_indicator_widget.dart';
import 'package:hipster_prac/core/common_widgets/common_image_viewer.dart';
import 'package:hipster_prac/core/constants/color_constants.dart';
import 'package:hipster_prac/core/extensions/text_style_extensions.dart';
import 'package:hipster_prac/core/helpers/get_safe_area.dart';
import 'package:hipster_prac/core/helpers/response_status.dart';
import 'package:hipster_prac/data/models/user_list_model.dart';
import 'package:hipster_prac/modules/dashboard/dashboard_controller.dart';
import 'package:hipster_prac/modules/dashboard/widgets/placeholder_list.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const routeName = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final DashboardController _dashboardController =
      Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(1.sw, 64.h),
        child: AppBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            "Dashboard",
            style: context.robotoRegular.copyWith(
              fontSize: 22.sp,
              color: ColorConstants.blackColor,
            ),
          ),
        ),
      ),
      body: Obx(() {
        switch (_dashboardController.userListResponseStatus.resType) {
          case ResponseType.success:
            return getAllDataList();
          case ResponseType.loading:
            return const PlaceHolderList();
          case ResponseType.error:
            return CommonErrorIndicatorWidget(
              onRetry: _dashboardController.getUserList,
              title: _dashboardController.userListResponseStatus.error
                  .toString(),
            );
          default:
            return const SizedBox();
        }
      }),
    );
  }

  Widget getAllDataList() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        bottom: bottomSafeArea,
        top: 20.h,
      ),
      itemBuilder: (context, index) {
        User user = _dashboardController.userList[index];
        return Row(
          children: [
            user.profileImageUrl == null || user.profileImageUrl == ""
                ? Container(
                    height: 60.h,
                    width: 60.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstants.primaryColor.withValues(alpha: .3),
                    ),
                    child: Center(
                      child: Text(
                        user.name?.substring(0, 1).toUpperCase() ?? '',
                        style: context.robotoBold.copyWith(
                          fontSize: 20.sp,
                          color: ColorConstants.primaryColor,
                        ),
                      ),
                    ),
                  )
                : CommonImageViewer(
                    imgLink: user.profileImageUrl ?? '',
                    height: 60.h,
                    width: 60.h,
                    borderRadius: 100.r,
                  ),
            SizedBox(width: 15.w),
            Expanded(
              child: Text(
                user.name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.robotoRegular.copyWith(fontSize: 19.sp),
              ),
            ),
            SizedBox(width: 10.w),
            IconButton(
              onPressed: () {
                _dashboardController.startMeeting(user);
              },
              icon: Icon(
                Icons.video_call_outlined,
                size: 30.h,
                color: ColorConstants.primaryColor,
              ),
            ),
          ],
        );
      },
      itemCount: _dashboardController.userList.length,
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
