

import 'package:flutter/material.dart';
import 'package:flutter_barrage/flutter_barrage.dart';
import 'package:get/get.dart';

class TimeScreenState {
  RxInt currentSecond = 0.obs;
  RxInt currentMinute = 0.obs;
  RxInt currentHour = 0.obs;
  RxInt currentDay = 0.obs;
  RxInt currentMonth = 0.obs;
  RxInt currentYear = 0.obs;
  RxInt currentWeek = 0.obs;
  RxInt currentWeekDay = 0.obs;
  TimeScreenState() {
    ///Initialize variables
  }
}
