import 'dart:math';

import 'package:flutter_scaffold/pages/functions/time_screen/time_screen_logic.dart';
import 'package:flutter_scaffold/pages/functions/time_screen/time_screen_state.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';

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
        body: Center(
          child: Obx(() {
            return CustomPaint(
              painter: WaterFillPainter(state.animationValue.value),
              child: SizedBox(
                width: 200,
                height: 200,
                child: Center(
                  child: Text(
                    '${(state.animationValue.value * 10).ceil()}', // 倒计时文字显示
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                ),
              ),
            );
          }),
        ));
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


class WaterFillPainter extends CustomPainter {

  final double fillPercent; // 填充百分比，用于表示水位的高度

  WaterFillPainter(this.fillPercent);

  @override
  void paint(Canvas canvas, Size size) {
    // 1. 绘制圆形背景（作为水的容器）
    Paint circlePaint = Paint()..color = c7BBD9C.withOpacity(0.4); // 设置圆形背景颜色
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, circlePaint); // 在画布中心绘制一个圆形

    // 2. 定义圆形裁剪路径，确保水波效果只绘制在圆形内
    Path circlePath = Path()
      ..addOval(Rect.fromCircle(center: size.center(Offset.zero), radius: size.width / 2)); // 创建一个圆形路径

    // 3. 应用裁剪路径，使后续绘制的内容（包括水和主食）只能在圆形区域内显示
    canvas.clipPath(circlePath); // 使用圆形路径进行裁剪，保证所有绘制的内容都在圆内

    // 4. 绘制水的填充效果
    double waterHeight = size.height * fillPercent; // 计算水的高度，依据填充百分比

    // 增大波动幅度和调整波动频率，使水波更明显
    double waveAmplitude = 15; // 增大波动幅度
    double waveFrequency = 3* pi; // 调整波浪的频率，使其更加动态

    // 绘制水波效果
    Path waterPath = Path()
      ..moveTo(0, size.height) // 从圆底部开始绘制
      ..lineTo(0, size.height - waterHeight) // 从左侧绘制到水位高度
      ..quadraticBezierTo(
        size.width / 2,
        size.height - waterHeight - waveAmplitude * sin(waveFrequency * fillPercent), // 改进波动效果
        size.width,
        size.height - waterHeight, // 右侧水位
      )
      ..lineTo(size.width, size.height) // 水的右侧
      ..close(); // 关闭路径，完成水面路径的闭合

    // 绘制水面
    Paint waterPaint = Paint()..color = c7BBD9C; // 设置水的颜色
    canvas.drawPath(waterPath, waterPaint); // 在画布上绘制水面

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // 每次需要重新绘制时都返回 true
  }
}