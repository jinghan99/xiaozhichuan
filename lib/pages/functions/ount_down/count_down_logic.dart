import 'package:flutter/material.dart';
import 'package:flutter_scaffold/http/my_dio.dart';
import 'package:get/get.dart';
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
      int remainingSeconds = (controller.duration!.inSeconds * animation.value).toInt();
      int hours = remainingSeconds ~/ 3600;
      int minutes = (remainingSeconds % 3600) ~/ 60;
      int seconds = remainingSeconds % 60;
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
  }

  void stopCountDown() {
    controller.stop();
    controller.reset(); // 重置动画状态
    state.isStart.value = false;
    state.currentHour.value = 0;
    state.currentMinute.value = 0;
    state.currentSecond.value = 0;
  }

  @override
  void onClose() {
    controller.dispose(); // 确保在页面销毁时释放资源
    super.onClose();
  }
}
