import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hipster_prac/core/constants/color_constants.dart';
import 'package:hipster_prac/core/extensions/text_style_extensions.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final bool isObsecured;

  const CommonTextField({
    super.key,
    required this.label,
    required this.controller,
    this.maxLines,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.suffixIcon,
    this.isObsecured = false,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: context.robotoRegular.copyWith(fontSize: 16.sp)),
        SizedBox(height: 8.h),
        TextFormField(
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          controller: controller,
          style: context.robotoMedium.copyWith(fontSize: 16.sp),
          validator: validator,
          maxLines: maxLines,
          obscureText: isObsecured,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            hint: Text(
              hintText,
              style: context.robotoRegular.copyWith(fontSize: 16.sp),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.spMin),
              borderSide: BorderSide(
                color: ColorConstants.greyColor,
                width: 1.spMin,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.spMin),
              borderSide: BorderSide(
                color: ColorConstants.borderColor,
                width: 1.spMin,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
