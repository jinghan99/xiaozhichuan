import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'count_down_state.dart';

class CountDownLogic extends GetxController with GetTickerProviderStateMixin {
  final CountDownState state = CountDownState();
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void onInit() {
    super.onInit();
    // 初始化 AnimationController
    init();
  }

  void init() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: state.totalSecond.value,), // 或者传递自定义的 duration
    );

    animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.linear),
    )..addListener(() {
      // controller.value 记录已经动画过的时间
      // animation.value 记录当前动画值
      int totalSeconds = (controller.duration!.inSeconds * animation.value).toInt();
      int hours = totalSeconds ~/ 3600;
      int minutes = (totalSeconds % 3600) ~/ 60; //  ~/整数除法运算符，它表示除法操作后只保留整数部分（即向下取整
      int seconds = totalSeconds % 60; // % 是 取余运算符，用于计算除法后的余数
      if (state.currentHour.value != hours) state.currentHour.value = hours;
      if (state.currentMinute.value != minutes) state.currentMinute.value = minutes;
      if (state.currentSecond.value != seconds) state.currentSecond.value = seconds;
      state.animationValue.value = animation.value;
    });
  }

  void startCountDown() {
    controller.stop();
    controller.duration = Duration(seconds: state.totalSecond.value);
    controller.reset();  // 重置动画到初始状态
    controller.forward();  // 开始动画
    state.isStart.value = true;
    // 启用屏幕常亮
    WakelockPlus.enable();
  }

  void stopCountDown() {
    controller.stop();
    controller.reset(); // 重置动画状态
    state.isStart.value = false;
    state.currentHour.value = 0;
    state.currentMinute.value = 0;
    state.currentSecond.value = 0;
    // 禁用屏幕常亮
    WakelockPlus.disable();
  }

  @override
  void onClose() {
    controller.dispose(); // 确保在页面销毁时释放资源
    // 禁用屏幕常亮
    WakelockPlus.disable();
    super.onClose();
  }
}
