import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/http/my_dio.dart';

import '../gobang_state.dart';

// paint 方法：主要绘制内容的入口，通过 drawChessboard 方法绘制棋盘。
// drawChessboard 方法：
// 棋盘的背景使用了浅棕色填充 (Color(0xFFDCC48C))。
// 棋盘网格线的颜色为灰色 (Colors.black38)，线条宽度为 1 像素。
// 通过循环绘制横线和竖线，将棋盘划分为 15 x 15 的格子结构，符合五子棋的棋盘要求。
class MyChessBg extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    logger.i('chess bg');
    var rect = Offset.zero & size; //这种写法等价于 Rect.fromLTWH(0, 0, size.width, size.height)。
    print('paint bg ${rect.left} ${rect.right}');
    // 画棋盘
    drawChessboard(canvas, rect);
  }

  // 返回false，表示在此示例中不需要重新绘制
  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;

  void drawChessboard(Canvas canvas, Rect rect) {
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFDCC48C); // 棋盘颜色
    canvas.drawRect(rect, paint); // 画一个矩形

    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black38
      ..strokeWidth = 1;

    //依据格子大小 计算列数和行数
    int widthCount = rect.width ~/ GoBangs.GO_BANG_GRID_SIZE;  // 计算可以容纳的列数
    int heightCount = rect.height ~/ GoBangs.GO_BANG_GRID_SIZE; // 计算可以容纳的行数

    // 画棋盘的横线
    for (int i = 0; i <= heightCount; ++i) {
      double dy = rect.top + (GoBangs.GO_BANG_GRID_SIZE * i); // 确保每条横线的 y 坐标是整格
      // 从左到右绘制一条水平线
      canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);
      drawText(canvas, Offset(rect.left - 20, dy - 5), '$i'); // 绘制索引
    }

    // 画棋盘的竖线
    for (int i = 0; i <= widthCount; ++i) {
      double dx = rect.left + (GoBangs.GO_BANG_GRID_SIZE * i); // 确保每条竖线的 x 坐标是整格
      // 从上到下绘制一条竖线
      canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
      drawText(canvas, Offset(dx - 5, rect.bottom + 5), '$i'); // 绘制索引
    }
  }

  // 绘制文本的方法
  void drawText(Canvas canvas, Offset offset, String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Colors.black,
          fontSize: 10,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, offset);
  }
}
