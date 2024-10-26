import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaffold/http/my_dio.dart';

class MyChessCh extends CustomPainter {
  // 通过构造函数传入棋子的偏移位置列表，指定棋子的摆放位置
  MyChessCh({Key? key, required this.offset}) : super();

  late final List<Offset> offset; // offset 列表用于指定每颗棋子的具体位置

  // 实现画布绘制方法
  @override
  void paint(Canvas canvas, Size size) {
    logger.i('chess ch');
    drawPieces(canvas, offset); // 绘制棋子，使用传入的偏移位置
  }

  // 设定是否需要重绘，每次调用都重新绘制棋子
  @override
  bool shouldRepaint(covariant MyChessCh oldDelegate) {
    // 只有当 offset 列表变化时才需要重绘
    return oldDelegate.offset != offset;
  }

  //画棋子的函数，传入一个偏移位置列表 offsets 来确定棋子的位置
  void drawPieces(Canvas canvas, List<Offset> offset) {
    var paint = Paint()
      ..style = PaintingStyle.fill // 填充
      ..color = Colors.black; // 棋子颜色 黑棋
    for (var i = 0; i < offset.length; i++) {
      //  偶数索引绘制黑子，奇数索引绘制白子
      if (i % 2 == 0) {
        paint.color = Colors.black;
      } else {
        paint.color = Colors.white;
      }
      // 绘制一个圆形棋子，半径为 8
      canvas.drawCircle(offset[i], 8, paint);
    }
  }
}
