import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
    // TODO: implement onClose
    super.onClose();
  }

  // 显示弹幕
  void showBarrage() {
    if(state.textController.value.text.trim().isEmpty){
      EasyLoading.showToast('请填写弹幕文字');
      return;
    }
    if(!state.isPortrait.value){
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
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
