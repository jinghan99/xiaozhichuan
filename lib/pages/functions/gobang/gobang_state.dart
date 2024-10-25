

import 'package:flutter/material.dart';
import 'package:flutter_barrage/flutter_barrage.dart';
import 'package:get/get.dart';

class GoBangState {

  RxInt currentSecond = 0.obs;
  RxInt currentMinute = 0.obs;
  RxInt currentHour = 0.obs;

  RxDouble animationSecond = 0.0001.obs;
  RxDouble animationMinute = 0.0001.obs;
  RxDouble animationHour = 0.0001.obs;

  RxBool isSecondReversePhase = false.obs;
  RxBool isMinuteReversePhase = false.obs;
  RxBool isHourReversePhase = false.obs;

  RxDouble zeroAngle = 0.0001.obs;


  GoBangState() {
    ///Initialize variables
  }
}
