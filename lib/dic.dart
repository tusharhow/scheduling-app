import 'package:get/get.dart';
import 'package:scheduling_app/backend/controllers/schedule_controller.dart';


abstract class Dic {
  static final find = Get.find;

  static Future<void> setUp() async {
    Get.lazyPut(
      () => ScheduleController().getAllAppointments(),
    );
  }
}
