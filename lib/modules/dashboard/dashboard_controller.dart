import 'package:get/get.dart';
import 'package:hipster_prac/core/constants/string_constants.dart';
import 'package:hipster_prac/core/errors/dio_exception.dart';
import 'package:hipster_prac/core/helpers/loader_utils.dart';
import 'package:hipster_prac/core/helpers/permission_helper.dart';
import 'package:hipster_prac/core/helpers/response_status.dart';
import 'package:hipster_prac/core/helpers/toast_utils.dart';
import 'package:hipster_prac/data/data_provider/api_provider.dart';
import 'package:hipster_prac/data/service/databaes_manager_service.dart';
import 'package:hipster_prac/data/models/meeting_creation_model.dart';
import 'package:hipster_prac/data/models/user_list_model.dart';
import 'package:hipster_prac/modules/meeting/meeting_screen.dart';

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

  //to start call
  Future<void> startMeeting(User user) async {
    if (await PermissionHelper.checkCameraAndMicrophonePermission()) {
      //start call api
      LoaderUtils.showLoader();
      try {
        var response = await _apiProvider.createMeeting(userId: user.id ?? "");
        MeetingCreationModel meetingCreationModel =
            MeetingCreationModel.fromJson(response);
        LoaderUtils.hideLoader();
        //navigate to call details screen
        Get.toNamed(
          MeetingScreen.routeName,
          arguments: {
            ArgConstants.meetingDetailArg: meetingCreationModel.meetingDetails,
            ArgConstants.isCallerArg: true,
          },
        );
      } catch (e) {
        LoaderUtils.hideLoader();
        makeToast(toastData: e.toString());
      }
    }
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
