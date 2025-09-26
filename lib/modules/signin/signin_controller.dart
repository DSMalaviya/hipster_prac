import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hipster_prac/core/constants/pref_constants.dart';
import 'package:hipster_prac/core/helpers/overlay_utils.dart';
import 'package:hipster_prac/core/helpers/toast_utils.dart';
import 'package:hipster_prac/data/data_provider/api_provider.dart';
import 'package:hipster_prac/data/models/signin_model.dart';
import 'package:hipster_prac/data/preferences/preference_manager.dart';
import 'package:hipster_prac/modules/dashboard/dashboard_screen.dart';
import 'package:hipster_prac/modules/signup/signup_screen.dart';

class SigninController extends GetxController {
  late final ApiProvider _apiProvider = Get.find<ApiProvider>();
  late final PreferenceManager _preferenceManager = PreferenceManager();

  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RxBool _isPasswordVisible = false.obs;

  //
  final RxBool _isLoading = false.obs;

  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

  void onRegisterClick() {
    Get.offNamed(SignupScreen.routeName);
  }

  @override
  void onClose() {
    super.onClose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> loginUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        OverlayUtils.showOverlay();
        _isLoading(true);
        var response = await _apiProvider.loginUser(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          fcmToken: "",
        );
        SignInModel userLoginModel = SignInModel.fromJson(response);
        await _preferenceManager.setString(
          PrefConstants.authToken,
          userLoginModel.token ?? "",
        );
        Get.offNamed(DashboardScreen.routeName);
      } catch (e) {
        _isLoading(false);
        makeToast(toastData: e.toString());
      } finally {
        OverlayUtils.hideOverlay();
      }
    }
  }

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  bool get isPasswordVisible => _isPasswordVisible.value;
  bool get isLoading => _isLoading.value;
  GlobalKey<FormState> get formKey => _formKey;
}
