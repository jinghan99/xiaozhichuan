import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/http/my_dio.dart';

// paint 方法：主要绘制内容的入口，通过 drawChessboard 方法绘制棋盘。
// drawChessboard 方法：
// 棋盘的背景使用了浅棕色填充 (Color(0xFFDCC48C))。
// 棋盘网格线的颜色为灰色 (Colors.black38)，线条宽度为 1 像素。
// 通过循环绘制横线和竖线，将棋盘划分为 15 x 15 的格子结构，符合五子棋的棋盘要求。
class MyChessBg extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    logger.i('chess bg');
    var rect = Offset.zero & size;
    print('paint bg ${rect.left} ${rect.right}');
    // 画棋盘
    drawChessboard(canvas, rect);
  }

  // 返回false，表示在此示例中不需要重新绘制
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  void drawChessboard(Canvas canvas, Rect rect) {
    var paint = Paint()
      ..isAntiAlias = true // 抗锯齿
      ..style = PaintingStyle.fill // 填充
      ..color = const Color(0xFFDcc48C); // 棋盘颜色
    canvas.drawRect(rect, paint); // 画一个矩形

    paint..style = PaintingStyle.stroke// 画笔为线模式
    ..color = Colors.black38// 线条颜色
    ..strokeWidth = 1;// 线宽

    for(int i=0;i<=15;++i){
      double dy = rect.top + rect.height / 15 * i;//计算每条横线的 y 坐标
      // 从左到右绘制一条水平线
      canvas.drawLine(Offset(rect.left,dy),Offset(rect.right,dy),paint);
    }

    for(int i=0;i<=15; ++i){
      double dx = rect.left + rect.width / 15 * i;//计算每条竖线的 x 坐标
      // 从上到下绘制一条竖线
      canvas.drawLine(Offset(dx,rect.top),Offset(dx,rect.bottom),paint);
    }
  }
}
