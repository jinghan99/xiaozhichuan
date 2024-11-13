

import 'package:flutter/material.dart';
import 'package:flutter_barrage/flutter_barrage.dart';
import 'package:get/get.dart';

class CountDownState {


  var animationValue = 1.0.obs; // 用于绑定动画进度

  // 当前倒计时的 秒、分、时
  RxInt currentSecond = 0.obs;
  RxInt currentMinute = 0.obs;
  RxInt currentHour = 0.obs;

  RxInt totalSecond = 0.obs;

  RxBool isStart = false.obs;

  CountDownState() {
    ///Initialize variables
  }
}
