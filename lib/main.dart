import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hipster_prac/core/constants/color_constants.dart';
import 'package:hipster_prac/core/constants/string_constants.dart';
import 'package:hipster_prac/core/extensions/text_style_extensions.dart';
import 'package:hipster_prac/data/data_provider/api_provider.dart';
import 'package:hipster_prac/data/database_manager/databaes_manager_service.dart';
import 'package:hipster_prac/modules/splash/splash_screen.dart';
import 'package:hipster_prac/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      // designSize:
      //     context.isTablet ? const Size(834, 1194) : const Size(430, 932),
      designSize: context.isTablet
          ? const Size(708.9, 1014.9)
          : const Size(430, 932),
      builder: (context, child) => GetMaterialApp(
        initialBinding: InitialBindings(),
        getPages: AppRoutes.pages,
        initialRoute: SplashScreen.routeName,
        locale: Get.deviceLocale,
        title: StringConstants.appTitle,
        themeMode: ThemeMode.light,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: ColorConstants.primaryColor,
          ),
          scaffoldBackgroundColor: ColorConstants.whiteColor,
          useMaterial3: true,
          fontFamily: CustomTextStyles.roboto,
        ),
      ),
    );
  }
}

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DatabaseManager());
    Get.lazyPut(() => ApiProvider());
  }
}
