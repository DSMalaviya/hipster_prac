import 'package:get/get.dart';
import 'package:hipster_prac/core/constants/pref_constants.dart';
import 'package:hipster_prac/data/database_manager/databaes_manager_service.dart';
import 'package:hipster_prac/data/preferences/preference_manager.dart';
import 'package:hipster_prac/modules/dashboard/dashboard_screen.dart';
import 'package:hipster_prac/modules/signin/signin_screen.dart';

class SplashController extends GetxController {
  late final PreferenceManager _preferenceManager = PreferenceManager();
  late final DatabaseManager _dbManager = Get.find<DatabaseManager>();

  navigateToNextScreen() async {
    await _dbManager.initDatabse();
    String authToken = await _preferenceManager.getString(
      PrefConstants.authToken,
    );
    if (authToken.isEmpty) {
      Get.offNamed(SigninScreen.routeName);
    } else {
      Get.offNamed(DashboardScreen.routeName);
    }
  }
}
