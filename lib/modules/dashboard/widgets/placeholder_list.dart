import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hipster_prac/core/constants/color_constants.dart';
import 'package:hipster_prac/core/helpers/get_safe_area.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class PlaceHolderList extends StatefulWidget {
  const PlaceHolderList({super.key});

  @override
  State<PlaceHolderList> createState() => _PlaceHolderListState();
}

class _PlaceHolderListState extends State<PlaceHolderList> {
  @override
  Widget build(BuildContext context) {
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
        return Row(
          children: [
            Shimmer(
              child: Container(
                height: 60.h,
                width: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  color: ColorConstants.whiteShimmerColor,
                ),
              ),
            ),
            SizedBox(width: 15.w),
            Shimmer(
              child: Container(
                height: 26.h,
                width: 250.w,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                  color: ColorConstants.whiteShimmerColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
            const Spacer(),
            Shimmer(
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.video_call_outlined,
                  size: 30.h,
                  color: ColorConstants.whiteShimmerColor,
                ),
              ),
            ),
          ],
        );
      },
      itemCount: 10,
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
