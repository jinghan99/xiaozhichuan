

import 'package:flutter/material.dart';
import 'package:flutter_barrage/flutter_barrage.dart';
import 'package:get/get.dart';

class HandheldBarrageState {

  RxDouble wordSize = 30.0.obs;
  RxInt scrollSpeed = 5.obs;
  Rx<Color> textColor = Colors.black.obs; // 字体颜色
  Rx<Color> backgroundColor = Colors.white.obs; // 背景色
  var isPortrait = false.obs; // 默认选择横屏
  TextEditingController textController = TextEditingController(); //弹幕文字

  final BarrageWallController barrageWallController = BarrageWallController();
  HandheldBarrageState() {
    ///Initialize variables
  }
}
