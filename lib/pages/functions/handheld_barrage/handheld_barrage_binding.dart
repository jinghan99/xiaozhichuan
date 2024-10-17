import 'package:get/get.dart';

import 'handheld_barrage_logic.dart';





class HandheldBarrageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HandheldBarrageLogic());
  }
}
