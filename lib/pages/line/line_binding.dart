import 'package:get/get.dart';

import 'line_logic.dart';




class LineBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LineLogic());
  }
}
