import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:hipster_prac/core/constants/api_constants.dart';
import 'package:hipster_prac/core/constants/pref_constants.dart';
import 'package:hipster_prac/data/data_provider/dio_client.dart';
import 'package:hipster_prac/data/preferences/preference_manager.dart';

class ApiProvider extends GetxService {
  late final DioClient _dioClient = DioClient(dio.Dio());

  late final _prefManager = PreferenceManager();

  Future<Map<String, dynamic>> _getHeaders() async {
    String token = await _prefManager.getString(PrefConstants.authToken);
    return {"Authorization": token};
  }

  Future<dynamic> registerUser({
    required String name,
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    try {
      dio.Response response = await _dioClient.post(
        ApiConstants.register,
        data: {
          "name": name,
          "email": email,
          "password": password,
          "fcmToken": fcmToken,
        },
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> loginUser({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    try {
      dio.Response response = await _dioClient.post(
        ApiConstants.login,
        data: {"email": email, "password": password, "fcmToken": fcmToken},
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> getUserList() async {
    try {
      dio.Response response = await _dioClient.get(
        ApiConstants.userList,
        options: dio.Options(headers: await _getHeaders()),
      );
      return response.data;
    } catch (e) {
      rethrow;
    }
  }
}
