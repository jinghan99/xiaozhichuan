import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'time_screen_state.dart';

class TimeScreenLogic extends GetxController {
  final TimeScreenState state = TimeScreenState();
  late PageController pageController;
  late Timer _timer;
  int _seconds = 0;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      state.currentSecond.value = pageController.page!.round();
      // 每秒翻一页
      if (pageController.hasClients) {
        if (state.currentSecond.value >= 59) {
          pageController.jumpToPage(0);
          state.currentSecond.value = 0;
        } else {
          pageController.nextPage(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
