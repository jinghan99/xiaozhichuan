

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HandheldBarrageState {

  RxDouble wordSize = 16.0.obs;
  RxDouble scrollSpeed = 5.0.obs;
  Rx<Color> textColor = Colors.black.obs; // 字体颜色
  Rx<Color> backgroundColor = Colors.white.obs; // 背景色
  var isPortrait = false.obs; // 默认选择横屏

  HandheldBarrageState() {
    ///Initialize variables
  }
}
