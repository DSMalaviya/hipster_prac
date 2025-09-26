import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hipster_prac/core/constants/color_constants.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CommonImageViewer extends StatelessWidget {
  final String imgLink;
  final double height;
  final double width;
  final double? borderRadius;
  final Color? placeHolderColor;

  const CommonImageViewer({
    super.key,
    required this.imgLink,
    required this.height,
    required this.width,
    this.borderRadius,
    this.placeHolderColor,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 10.r),
      child: CachedNetworkImage(
        imageUrl: imgLink,
        fit: BoxFit.cover,
        placeholder: (context, url) => Shimmer(
          child: Container(
            height: height,
            width: width,
            color: ColorConstants.whiteShimmerColor,
          ),
        ),
        errorWidget: (context, url, error) => placeHolderColor != null
            ? Container(color: placeHolderColor, height: height, width: width)
            : Container(
                height: height,
                width: width,
                color: ColorConstants.whiteShimmerColor,
                child: Center(
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: ColorConstants.redColor,
                    size: 28.h,
                  ),
                ),
              ),
        height: height,
        width: width,
      ),
    );
  }
}
