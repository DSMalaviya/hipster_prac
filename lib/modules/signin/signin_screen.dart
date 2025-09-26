import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hipster_prac/core/common_widgets/common_button.dart';
import 'package:hipster_prac/core/common_widgets/common_text_field.dart';
import 'package:hipster_prac/core/constants/color_constants.dart';
import 'package:hipster_prac/core/constants/validation_contants.dart';
import 'package:hipster_prac/core/extensions/text_style_extensions.dart';
import 'package:hipster_prac/modules/signin/signin_controller.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  static const String routeName = "/signin";

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late final SigninController _signInController = Get.find<SigninController>();

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
            "Login",
            style: context.robotoRegular.copyWith(
              fontSize: 22.sp,
              color: ColorConstants.blackColor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
              child: Form(
                key: _signInController.formKey,
                child: _buildFormBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 220.h),
        CommonTextField(
          maxLines: 1,
          label: "Email",
          hintText: "Enter your email",
          controller: _signInController.emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: ValidationContants.emailValidator,
        ),
        SizedBox(height: 20.h),
        Obx(
          () => CommonTextField(
            maxLines: 1,
            label: "Password",
            hintText: "Enter your password",
            controller: _signInController.passwordController,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            validator: ValidationContants.passwordValidator,
            isObsecured: !_signInController.isPasswordVisible,
            suffixIcon: IconButton(
              onPressed: _signInController.togglePasswordVisibility,
              icon: Icon(
                _signInController.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: ColorConstants.greyColor,
                size: 25.h,
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Obx(
          () => CommonButton(
            height: 60.h,
            width: double.infinity,
            title: "Login",
            borderRadius: 100.r,
            isLoading: _signInController.isLoading,
            onTap: _signInController.loginUser,
          ),
        ),
        SizedBox(height: 10.h),
        RichText(
          text: TextSpan(
            text: "Don't have an account? ",
            style: context.robotoRegular.copyWith(
              fontSize: 15.sp,
              color: ColorConstants.greyColor,
            ),
            children: [
              TextSpan(
                text: "Register",
                recognizer: TapGestureRecognizer()
                  ..onTap = _signInController.onRegisterClick,
                style: context.robotoMedium.copyWith(
                  fontSize: 15.sp,
                  color: ColorConstants.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
