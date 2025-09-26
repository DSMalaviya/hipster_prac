import 'package:get/get.dart';
import 'package:hipster_prac/modules/signin/signin_controller.dart';

class SigninBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SigninController>(() => SigninController());
  }
}
