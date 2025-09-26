import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:hipster_prac/modules/dashboard/dashboard_binding.dart';
import 'package:hipster_prac/modules/dashboard/dashboard_screen.dart';
import 'package:hipster_prac/modules/signin/signin_binding.dart';
import 'package:hipster_prac/modules/signin/signin_screen.dart';
import 'package:hipster_prac/modules/signup/signup_binding.dart';
import 'package:hipster_prac/modules/signup/signup_screen.dart';
import 'package:hipster_prac/modules/splash/splash_binding.dart';
import 'package:hipster_prac/modules/splash/splash_screen.dart';

class AppRoutes {
  static final List<GetPage> pages = [
    GetPage(
      name: SplashScreen.routeName,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: SigninScreen.routeName,
      page: () => const SigninScreen(),
      binding: SigninBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: SignupScreen.routeName,
      page: () => const SignupScreen(),
      binding: SignupBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: DashboardScreen.routeName,
      page: () => const DashboardScreen(),
      binding: DashboardBinding(),
      transition: Transition.cupertino,
    ),
  ];
}
