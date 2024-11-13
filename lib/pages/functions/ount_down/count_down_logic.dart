import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'count_down_state.dart';

class CountDownLogic extends GetxController with GetSingleTickerProviderStateMixin {
  final CountDownState state = CountDownState();
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void onInit() {
    super.onInit();
  }

  void startCountDown() {
    // 初始化 AnimationController
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: state.totalSecond.value,), // 或者传递自定义的 duration
    );

    // 设置动画曲线并监听动画进度
    animation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.linear,
      ),
    )..addListener(() {
      // 每次动画进度更新时，更新剩余时间
      int remainingSeconds = (controller.duration!.inSeconds * controller.value).toInt();

      // 计算剩余小时、分钟、秒
      int hours = remainingSeconds ~/ 3600;
      int minutes = (remainingSeconds % 3600) ~/ 60;
      int seconds = remainingSeconds % 60;

      // 更新状态中的秒、分、时
      if(state.currentHour.value != hours){
        state.currentHour.value = hours;
      }
      if(state.currentMinute.value != minutes){
        state.currentMinute.value = minutes;
      }
      if(state.currentSecond.value != seconds){
        state.currentSecond.value = seconds;
      }
      // 更新动画进度
      state.animationValue.value = animation.value;
    });

    controller.forward();
    state.isStart.value = true;
  }

  void stopCountDown() {
    controller.stop();
    controller.dispose(); // 确保在页面销毁时释放资源
    state.isStart.value = false;
    // 可以选择重置剩余时间为初始值
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
