import 'package:get/get.dart';
import 'package:hipster_prac/core/errors/dio_exception.dart';
import 'package:hipster_prac/core/helpers/response_status.dart';
import 'package:hipster_prac/data/data_provider/api_provider.dart';
import 'package:hipster_prac/data/database_manager/databaes_manager_service.dart';
import 'package:hipster_prac/data/models/user_list_model.dart';

class DashboardController extends GetxController {
  late final ApiProvider _apiProvider = Get.find<ApiProvider>();
  late final DatabaseManager _dbManager = Get.find<DatabaseManager>();

  final Rx<ResponseStatus> _userListResponseStatus =
      ResponseStatus.loading().obs;
  final RxList<User> _userList = <User>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserList();
  }

  Future<void> getUserList() async {
    _userListResponseStatus(ResponseStatus.loading());
    try {
      var response = await _apiProvider.getUserList();
      UserListModel userListModel = UserListModel.fromJson(response);
      _userList.clear();
      _userList.assignAll(userListModel.users ?? []);
      //save into local db
      await _dbManager.clearAllData();
      await _dbManager.saveAllEntries(
        List<Map<String, dynamic>>.from(_userList.map((x) => x.toJson())),
      );
      //save into local db
      _userListResponseStatus(ResponseStatus.success());
    } on NetworkException catch (_) {
      //load all data from local db again
      var data = await _dbManager.getAllSavedData();
      _userList.clear();
      _userList.assignAll(
        List<User>.from(
          data!.map(
            (x) => User(
              email: x[DatabaseManager.userEmailColumn],
              name: x[DatabaseManager.userNameColoum],
              profileImageUrl: x[DatabaseManager.userProfilePicColumn],
              id: x[DatabaseManager.databaseID],
            ),
          ),
        ),
      );
      //load all data from local db again
      _userListResponseStatus(ResponseStatus.success());
    } catch (e) {
      _userListResponseStatus(
        ResponseStatus.error(error: e, errormsg: e.toString()),
      );
    }
  }

  ResponseStatus get userListResponseStatus => _userListResponseStatus.value;
  List<User> get userList => _userList;
}
