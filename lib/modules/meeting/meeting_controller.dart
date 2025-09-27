import 'package:get/get.dart';
import 'package:hipster_prac/core/constants/string_constants.dart';
import 'package:hipster_prac/core/helpers/toast_utils.dart';
import 'package:hipster_prac/data/data_provider/api_provider.dart';
import 'package:hipster_prac/data/models/meeting_creation_model.dart';

class MeetingController extends GetxController {
  late final ApiProvider _apiProvider = Get.find<ApiProvider>();

  MeetingDetails? _meetingDetails;
  bool _isCaller = false;

  @override
  void onInit() {
    super.onInit();
    Map<String, dynamic>? args = Get.arguments;
    if (args != null) {
      _meetingDetails = args[ArgConstants.meetingDetailArg];
      _isCaller = args[ArgConstants.isCallerArg];
    }
  }

  endMeeting() async {
    try {
      await _apiProvider.endMeeting(
        meetingId: _meetingDetails!.meetingId ?? "",
      );
      Get.back();
    } catch (e) {
      makeToast(toastData: e.toString());
    }
  }

  MeetingDetails? get meetingDetails => _meetingDetails;
  bool get isParticipant => _isCaller;
}
