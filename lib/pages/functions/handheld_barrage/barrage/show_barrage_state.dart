

import 'package:flutter/material.dart';
import 'package:flutter_barrage/flutter_barrage.dart';
import 'package:get/get.dart';

class ShowBarrageState {

  double wordSize = 16.0;
  int scrollSpeed = 5;
  Color textColor = Colors.black; // 字体颜色
  Color backgroundColor = Colors.white; // 背景色
  bool isPortrait = false; // 默认选择横屏
  String text = ""; //弹幕文字

  final BarrageWallController barrageWallController = BarrageWallController();
  ShowBarrageState() {
    wordSize =  Get.arguments[0];
    scrollSpeed =  Get.arguments[1];
    textColor = Get.arguments[2];
    backgroundColor = Get.arguments[3];
    isPortrait = Get.arguments[4];
    text = Get.arguments[5];
  }
}
