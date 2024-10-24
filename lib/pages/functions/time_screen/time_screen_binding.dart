import 'package:flutter_scaffold/pages/functions/time_screen/time_screen_logic.dart';
import 'package:get/get.dart';

class TimeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TimeScreenLogic());
  }
}
