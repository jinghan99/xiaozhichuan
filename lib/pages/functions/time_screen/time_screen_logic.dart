import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'time_screen_state.dart';

class TimeScreenLogic extends GetxController with GetTickerProviderStateMixin {
  final TimeScreenState state = TimeScreenState();
  late AnimationController secondAnimationController;
  late AnimationController minuteAnimationController;
  late AnimationController hourAnimationController;
  late Animation<double> secondAnimation;
  late Animation<double> minuteAnimation;
  late Animation<double> hourAnimation;
  Timer? _secondTimer; // 定义一个 Timer
  @override
  void onInit() {
    super.onInit();
    // 设置为全屏模式，隐藏状态栏
    initMode();
    _initializeCurrentTime();
    _initializeAnimations();

    // 启用屏幕常亮
    WakelockPlus.enable();
  }

  void initMode() {
    // 设置为全屏模式，隐藏状态栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // 横屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  // 初始化当前时间
  void _initializeCurrentTime() async {
    DateTime now = DateTime.now();
    // 赋值
    state.currentSecond.value = now.second;
    state.currentMinute.value = now.minute;
    state.currentHour.value = now.hour;
    while (true) {
      now = DateTime.now();
      if (now.millisecond == 0) {
        // 赋值
        state.currentSecond.value = now.second;
        state.currentMinute.value = now.minute;
        state.currentHour.value = now.hour;
        // 启动定时器，每秒更新一次时间
        _startSecondUpdater();
        break; // 退出循环
      }
      // 暂停一段时间以减少 CPU 占用
      await Future.delayed(Duration(milliseconds: 1));
    }
  }

  // 初始化动画
  void _initializeAnimations() {
    // 秒动画
    secondAnimationController = AnimationController(duration: _duration(), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          secondAnimationController.reverse();
          state.isSecondReversePhase.value = true;
        } else if (status == AnimationStatus.dismissed) {
          state.isSecondReversePhase.value = false;
          _updateSecond();
        }
      });
    secondAnimation = Tween(begin: state.zeroAngle.value, end: pi / 2).animate(secondAnimationController)
      ..addListener(() {
        state.animationSecond.value = secondAnimation.value;
      });

    // 分钟动画
    minuteAnimationController = AnimationController(duration: _duration(), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          minuteAnimationController.reverse();
          state.isMinuteReversePhase.value = true;
        } else if (status == AnimationStatus.dismissed) {
          state.isMinuteReversePhase.value = false;
          _updateMinute();
        }
      });
    minuteAnimation = Tween(begin: state.zeroAngle.value, end: pi / 2).animate(minuteAnimationController)
      ..addListener(() {
        state.animationMinute.value = minuteAnimation.value;
      });

    // 小时动画
    hourAnimationController = AnimationController(duration: _duration(), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          hourAnimationController.reverse();
          state.isMinuteReversePhase.value = true;
        } else if (status == AnimationStatus.dismissed) {
          state.isMinuteReversePhase.value = false;
          _updateHour();
        }
      });
    hourAnimation = Tween(begin: state.zeroAngle.value, end: pi / 2).animate(hourAnimationController)
      ..addListener(() {
        state.animationHour.value = hourAnimation.value;
      });
  }

  Duration _duration() => Duration(milliseconds: 300);

  // 每秒更新器，用于启动秒动画
  void _startSecondUpdater() {
    _secondTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      secondAnimationController.forward();
      if (state.currentSecond.value == 59) {
        minuteAnimationController.forward(); // 启动分钟动画
        if (state.currentHour.value == 23) {
          hourAnimationController.forward(); //启动小时动画
        }
      }
    });
  }

  // 更新秒数
  void _updateSecond() {
    if (state.currentSecond.value == 59) {
      state.currentSecond.value = 0;
    } else {
      state.currentSecond.value += 1;
    }
  }

  // 更新分钟
  void _updateMinute() {
    if (state.currentMinute.value == 59) {
      state.currentMinute.value = 0;
      //每分钟 校准当前时间
      _calibrateTime();
    } else {
      state.currentMinute.value += 1;
    }
  }

  // 更新小时
  void _updateHour() {
    if (state.currentHour.value == 23) {
      state.currentHour.value = 0;
    } else {
      state.currentHour.value += 1;
    }
  }

  // 校准当前时间
  void _calibrateTime() async{
    DateTime now = DateTime.now();
    // 赋值
    state.currentSecond.value = now.second;
    state.currentMinute.value = now.minute;
    state.currentHour.value = now.hour;
    while (true) {
      now = DateTime.now();
      if (now.millisecond == 0) {
        // 赋值
        state.currentSecond.value = now.second;
        state.currentMinute.value = now.minute;
        state.currentHour.value = now.hour;
        break; // 退出循环
      }
      // 暂停一段时间以减少 CPU 占用
      await Future.delayed(Duration(milliseconds: 1));
    }
  }

  // 获取下一个显示的数字
  int nextNumStr(int num) {
    return (num + 1) % 60;
  }

  int nextHour(int num) {
    return (num + 1) % 24;
  }

  @override
  void onClose() {
    // 禁用屏幕常亮
    _secondTimer?.cancel(); // 取消计时器
    WakelockPlus.disable();
    secondAnimationController.dispose();
    minuteAnimationController.dispose();
    hourAnimationController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // 在 onClose 时恢复状态栏和导航栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.onClose();
  }
}
