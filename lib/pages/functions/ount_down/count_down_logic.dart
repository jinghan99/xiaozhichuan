import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import 'count_down_state.dart';

class CountDownLogic extends GetxController with GetSingleTickerProviderStateMixin {
  final CountDownState state = CountDownState();
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void onInit() {
    super.onInit();

    // 初始化 AnimationController
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10), // 或者传递自定义的 duration
    );

    // 设置动画曲线并监听动画进度
    animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      // 更新状态中的动画进度
      state.animationValue.value = animation.value;
    });

    // 开始倒计时
    controller.forward();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
