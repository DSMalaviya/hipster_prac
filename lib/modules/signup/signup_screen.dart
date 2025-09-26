import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hipster_prac/core/common_widgets/common_button.dart';
import 'package:hipster_prac/core/common_widgets/common_text_field.dart';
import 'package:hipster_prac/core/constants/color_constants.dart';
import 'package:hipster_prac/core/constants/validation_contants.dart';
import 'package:hipster_prac/core/extensions/text_style_extensions.dart';
import 'package:hipster_prac/modules/signup/signup_controller.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const routeName = '/signup';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final SignupController _signupController = Get.find<SignupController>();

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
            "Register",
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
                key: _signupController.formKey,
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
        SizedBox(height: 200.h),
        CommonTextField(
          maxLines: 1,
          label: "Name",
          hintText: "Enter your name",
          controller: _signupController.nameController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          validator: ValidationContants.nameValidator,
        ),
        SizedBox(height: 20.h),
        CommonTextField(
          maxLines: 1,
          label: "Email",
          hintText: "Enter your email",
          controller: _signupController.emailController,
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
            controller: _signupController.passwordController,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            validator: ValidationContants.passwordValidator,
            isObsecured: !_signupController.isPasswordVisible,
            suffixIcon: IconButton(
              onPressed: _signupController.togglePasswordVisibility,
              icon: Icon(
                _signupController.isPasswordVisible
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
            title: "Register",
            borderRadius: 100.r,
            isLoading: _signupController.isLoading,
            onTap: _signupController.registerUser,
          ),
        ),
        SizedBox(height: 10.h),
        RichText(
          text: TextSpan(
            text: "Already have an account? ",
            style: context.robotoRegular.copyWith(
              fontSize: 15.sp,
              color: ColorConstants.greyColor,
            ),
            children: [
              TextSpan(
                text: "Login",
                recognizer: TapGestureRecognizer()
                  ..onTap = _signupController.onLoginClick,
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
