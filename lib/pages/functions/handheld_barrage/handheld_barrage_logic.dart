import 'package:get/get.dart';
import 'barrage/show_barrage_view.dart';
import 'handheld_barrage_state.dart';

class HandheldBarrageLogic extends GetxController {
  final HandheldBarrageState state = HandheldBarrageState();

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  // 显示弹幕
  void showBarrage() {
    Get.to(() => const ShowBarragePage(), arguments: [
      state.wordSize.value,
      state.scrollSpeed.value,
      state.textColor.value,
      state.backgroundColor.value,
      state.isPortrait.value,
      state.textController.value.text,
    ]);
  }
}
