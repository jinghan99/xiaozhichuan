import 'package:flutter_scaffold/pages/root/root_logic.dart';
import 'package:get/get.dart';


class RootBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RootLogic());
  }
}
