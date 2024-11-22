import 'package:flutter_scaffold/pages/hot/play/play_logic.dart';
import 'package:get/get.dart';





class PlayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PlayLogic());
  }
}
