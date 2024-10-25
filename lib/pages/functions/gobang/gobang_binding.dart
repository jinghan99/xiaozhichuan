import 'package:flutter_scaffold/pages/functions/time_screen/time_screen_logic.dart';
import 'package:get/get.dart';

import 'gobang_logic.dart';

class GoBangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GoBangLogic());
  }
}
