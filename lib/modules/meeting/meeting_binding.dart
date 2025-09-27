import 'package:get/get.dart';
import 'package:hipster_prac/modules/meeting/meeting_controller.dart';

class MeetingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeetingController>(() => MeetingController());
  }
}
