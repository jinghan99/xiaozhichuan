import 'package:get/get.dart';

import 'count_down_logic.dart';

class CountDownBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CountDownLogic());
  }
}
