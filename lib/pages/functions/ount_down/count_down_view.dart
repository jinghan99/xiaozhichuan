import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_scaffold/pages/functions/time_screen/time_screen_logic.dart';
import 'package:flutter_scaffold/pages/functions/time_screen/time_screen_state.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';
import 'package:liquid_progress_indicator_v2/liquid_progress_indicator.dart';

import 'count_down_logic.dart';
import 'count_down_state.dart';

class CountDownPage extends StatelessWidget {
  const CountDownPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CountDownLogic logic = Get.put(CountDownLogic());
    final CountDownState state = Get.find<CountDownLogic>().state;
    return Scaffold(
        backgroundColor: cF5,
        appBar: buildAppBar(),
        body: Obx(() {
          return state.isStart.value ? buildProgressIndicator(logic,state) : startButton(logic, state);
        }));
  }

  Widget startButton(CountDownLogic logic, CountDownState state) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [c7BBD9C, cE5F2EB],
      )),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 100.h,
              child: CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hms,
                initialTimerDuration: const Duration(hours: 0, minutes: 0, seconds: 0),
                minuteInterval: 1,
                secondInterval: 1,
                onTimerDurationChanged: (Duration newDuration) {
                  // 总秒数
                  state.totalSecond.value = newDuration.inSeconds;
                // 获取总小时、剩余分钟、剩余秒数
                  state.currentSecond.value = newDuration.inSeconds % 60;
                  state.currentMinute.value = newDuration.inMinutes % 60;
                  state.currentHour.value = newDuration.inHours;
                  logger.d(state.currentMinute.value);
                },
              ),
            ),
            Obx(() {
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: state.totalSecond.value > 0 ? Colors.white : cB9B9B9, width: 1),
                ),
                width: 180.w,
                margin: EdgeInsets.only(top: 30.h),
                padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                child: (Text(
                  "开始计时",
                  style: state.totalSecond.value > 0 ? w14 : g14,
                )),
              ).onTap(() {
                if (state.totalSecond.value > 0) {
                  logic.startCountDown();
                }
              });
            })
          ],
        ),
      ),
    );
  }

  // 计时器
  Widget buildProgressIndicator(CountDownLogic logic,CountDownState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1.sw,
          width: 1.sw,
          child: LiquidCircularProgressIndicator(
            value: state.animationValue.value,
            // Defaults to 0.5.
            valueColor: AlwaysStoppedAnimation(c7BBD9C),
            // Defaults to the current Theme's accentColor.
            backgroundColor: cE5F2EB,
            // Defaults to the current Theme's backgroundColor.
            borderColor: c7BBD9C,
            borderWidth: 5.0,
            direction: Axis.vertical,
            // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
            center: Text("${state.currentHour.value}:${state.currentMinute.value}:${state.currentSecond.value}",style: w14,),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.h),
          child: Icon(Icons.stop_circle,size: 60,color: c7BBD9C,),
        ).onTap((){
          logic.stopCountDown();
        })
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: Container(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: c7BBD9C,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: cEAF5EF,
      title: Container(
        width: 1.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "倒计时",
              style: gr16b,
            ).paddingOnly(bottom: 5),
          ],
        ),
      ),
    );
  }
}
