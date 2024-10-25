import 'dart:math';

import 'package:flutter_scaffold/pages/functions/time_screen/time_screen_logic.dart';
import 'package:flutter_scaffold/pages/functions/time_screen/time_screen_state.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';

class TimeScreenPage extends StatelessWidget {
  const TimeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TimeScreenLogic logic = Get.put(TimeScreenLogic());
    final TimeScreenState state = Get.find<TimeScreenLogic>().state;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        Color _color = Colors.white;
        state.currentSecond.value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildHour(logic, state, _color),
            buildPoint(),
            buildMinute(logic, state, _color),
            buildPoint(),
            buildSeconds(logic, state, _color),
          ],
        );
      }),
    );
  }

  // 校园对啊
  Text buildPoint() {
    return Text(
      ':',
      style: TextStyle(
        color: Colors.white,
        fontSize: 60.w,
        fontWeight: FontWeight.w700,
      ),
    );
  }
  Container buildSeconds(TimeScreenLogic logic, TimeScreenState state, Color _color) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: <Widget>[
              ClipRectText(logic.nextNumStr(state.currentSecond.value), Alignment.topCenter, _color),
              ///动画正向执行翻转的组件
              Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(state.isSecondReversePhase.value ? pi / 2 : state.animationSecond.value),
                  alignment: Alignment.bottomCenter,
                  child: ClipRectText(state.currentSecond.value, Alignment.topCenter, _color)),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 2.0),
          ),
          Stack(
            children: <Widget>[
              ClipRectText(state.currentSecond.value, Alignment.bottomCenter, _color),
              //动画反向执行翻转的组件
              Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(state.isSecondReversePhase.value ? -state.animationSecond.value : pi / 2),
                  alignment: Alignment.topCenter,
                  child: ClipRectText(logic.nextNumStr(state.currentSecond.value), Alignment.bottomCenter, _color)),
            ],
          )
        ],
      ),
    );
  }

  Container buildMinute(TimeScreenLogic logic, TimeScreenState state, Color _color) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: <Widget>[
              ClipRectText(logic.nextNumStr(state.currentMinute.value), Alignment.topCenter, _color),
              ///动画正向执行翻转的组件
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(state.isMinuteReversePhase.value ? pi / 2 : state.animationMinute.value),
                alignment: Alignment.bottomCenter,
                child: ClipRectText(state.currentMinute.value, Alignment.topCenter, _color),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 2.0),
          ),
          Stack(
            children: <Widget>[
              ClipRectText(state.currentMinute.value, Alignment.bottomCenter, _color),
              //动画反向执行翻转的组件
              Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateX(state.isMinuteReversePhase.value ? -state.animationMinute.value : pi / 2),
                alignment: Alignment.topCenter,
                child: ClipRectText(logic.nextNumStr(state.currentMinute.value), Alignment.bottomCenter, _color),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container buildHour(TimeScreenLogic logic, TimeScreenState state, Color _color) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: <Widget>[
              ClipRectText(logic.nextHour(state.currentHour.value), Alignment.topCenter, _color),

              ///动画正向执行翻转的组件
              Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(state.isHourReversePhase.value ? pi / 2 : state.animationHour.value),
                  alignment: Alignment.bottomCenter,
                  child: ClipRectText(state.currentHour.value, Alignment.topCenter, _color)),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 2.0),
          ),
          Stack(
            children: <Widget>[
              ClipRectText(state.currentHour.value, Alignment.bottomCenter, _color),
              //动画反向执行翻转的组件
              Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(state.isHourReversePhase.value ? -state.animationHour.value : pi / 2),
                  alignment: Alignment.topCenter,
                  child: ClipRectText(logic.nextHour(state.currentHour.value), Alignment.bottomCenter, _color)),
            ],
          )
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: Container(
        padding: EdgeInsets.only(left: 10),
        child: IconButton(
          icon: Icon(Icons.arrow_back),
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
              "时间屏幕",
              style: gr16b,
            ).paddingOnly(bottom: 5),
          ],
        ),
      ),
    );
  }
}

class ClipRectText extends StatelessWidget {
  final int _value;
  final Alignment _alignment;
  final Color _color;

  const ClipRectText(this._value, this._alignment, this._color);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width / 5 + 10;
    return ClipRect(
      child: Align(
        alignment: _alignment,
        heightFactor: 0.5,
        child: Container(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          alignment: Alignment.center,
          width: width,
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Text(
            (_value).toString().padLeft(2, '0'),
            style: TextStyle(
              fontFamily: "Din",
              fontSize: width - 30,
              color: _color,
              fontWeight: FontWeight.w700,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }


}
