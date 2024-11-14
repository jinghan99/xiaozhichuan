import 'package:flutter/cupertino.dart';
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
          return state.isStart.value ? buildProgressIndicator(logic, state) : startButton(logic, state);
        }));
  }

  Widget startButton(CountDownLogic logic, CountDownState state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 180.h,
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
              },
            ),
          ),
          Obx(() {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: cE5F2EB,
                border: Border.all(color: state.totalSecond.value > 0 ? c7BBD9C : cE5F2EB, width: 1),
              ),
              width: 200.w,
              margin: EdgeInsets.only(top: 30.h),
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
              child: (Text(
                "开始计时",
                style: state.totalSecond.value > 0 ? gr16 : g16,
              )),
            ).onTap(() {
              if (state.totalSecond.value > 0) {
                logic.startCountDown();
              }
            });
          })
        ],
      ),
    );
  }

  // 计时器
  Widget buildProgressIndicator(CountDownLogic logic, CountDownState state) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 1.sw,
          width: 1.sw,
          child: LiquidCircularProgressIndicator(
            value: state.animationValue.value,
            valueColor: AlwaysStoppedAnimation(c7BBD9C),
            backgroundColor: cE5F2EB,
            borderColor: c7BBD9C,
            borderWidth: 2.0,
            direction: Axis.vertical,
            center:  _buildTimeText(state),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20.h),
          child: Icon(
            Icons.stop_circle,
            size: 60,
            color: c7BBD9C,
          ),
        ).onTap(() {
          logic.stopCountDown();
        })
      ],
    );
  }

  Widget _buildTimeText(CountDownState state) {
    double fixedWidth = 50.w;
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.white,
          fontSize: 70.w,
          fontWeight: FontWeight.bold,
        ),
        children: [
          _buildDigitSpan(state.currentHour.value ~/ 10, fixedWidth),
          _buildDigitSpan(state.currentHour.value % 10, fixedWidth),
          TextSpan(text: ':', style: TextStyle(fontSize: 70.w)),
          _buildDigitSpan(state.currentMinute.value ~/ 10, fixedWidth),
          _buildDigitSpan(state.currentMinute.value % 10, fixedWidth),
          TextSpan(text: ':', style: TextStyle(fontSize: 70.w)),
          _buildDigitSpan(state.currentSecond.value ~/ 10, fixedWidth),
          _buildDigitSpan(state.currentSecond.value % 10, fixedWidth),
        ],
      ),
    );
  }

  TextSpan _buildDigitSpan(int digit, double width) {
    return TextSpan(
      children: [
        WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: SizedBox(
            width: width,
            child: Text(
              digit.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 70.w,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
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
      title: SizedBox(
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
