import 'package:flutter_scaffold/pages/functions/gobang/chess/MyChessCh.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';

import 'chess/MyChessBg.dart';
import 'gobang_logic.dart';
import 'gobang_state.dart';

// https://juejin.cn/post/7070395620325851172
class GoBangPage extends StatelessWidget {
  const GoBangPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GoBangLogic logic = Get.put(GoBangLogic());
    final GoBangState state = Get.find<GoBangLogic>().state;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar("五子棋", color: const Color(0xFFDCC48C ), textStyle: b16b, backColor: Colors.black),
      body: Container(
        decoration: const BoxDecoration(color: Color(0xFFDCC48C)),
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: RepaintBoundary(
                    child: CustomPaint(
                      size: buildSize(), // 指定画布大小
                      painter: MyChessBg(), // 调用 MyChessBg 类来绘制棋盘背景
                    ),
                  ),
                ),
                Center(
                  child: Obx(() {
                    state.offs.value;
                    return Listener(
                      child: CustomPaint(
                        size: buildSize(), // 指定画布大小
                        painter: MyChessCh(offset: state.offs), // 调用 MyChessCh 类来绘制棋子
                      ),
                      onPointerUp: (PointerUpEvent event) {
                        //   点击事件
                        logger.d("打印点击坐标 ${event.localPosition}");
                        var ll = transOffset(event.localPosition); // 调用 transOffset 方法将点击位置转换成最近的有效的棋盘点位置
                        if (state.offs.contains(ll)) {
                          EasyLoading.showToast('该位置已经下过子了，不能重复下',duration:  Duration(milliseconds: 400));
                          return;
                        }
                        state.offs.add(ll);
                        if (state.offs.length % 2 == 1) {
                          state.boffs.add(ll); //黑棋
                          if (win(ll, true, state.boffs)) {
                            // 判断黑棋是否获胜
                            _dialog(state,'黑棋获胜');
                          }
                        } else {
                          state.woffs.add(ll); //白棋
                          if (win(ll, false, state.woffs)) {
                            // 判断黑棋是否获胜
                            _dialog(state, "白棋获胜");
                          }
                        }
                      },
                    );
                  }),
                )
              ],
            ).marginSymmetric(vertical: 20.h, horizontal: 10.w),
            Text("规则：先连成5子者获胜, 黑棋执先", style: b12),
            Container(
              width: 100.w,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color:  const Color(0xFFff9867),
              ),
              child: Text("悔一步", style: w16b),
            ).onTap(() {
              logic.withdrawChessPiece();
            })
          ],
        ),
      ),
    );
  }

  // 画布大小
  Size buildSize() => Size(0.85.sw, 0.7.sh);

  void _dialog(GoBangState state, String msg) {
    Get.defaultDialog(
      title: "提醒！", // 对话框标题
      middleText: msg,
      middleTextStyle: TextStyle(color: Colors.black, fontSize: 20.sp,fontWeight: FontWeight.bold),// 对话框内容
      barrierDismissible: false, // 不允许点击空白处关闭
      confirm: TextButton(
        onPressed: () {
          state.offs.clear(); // 清空所有棋子
          state.boffs.clear(); // 清空黑棋
          state.woffs.clear(); // 清空白棋
          Get.back(); // 关闭对话框
        },
        child: Text("确定",style: b16,),
      ),
    );
  }

  /// 将点击位置转换成最近的有效的棋盘点位置
  Offset transOffset(Offset offset) {
    double ddx = 0; // 最终位置的 x 坐标
    double ddy = 0; // 最终位置的 y 坐标
    double level = GoBangs.GO_BANG_GRID_SIZE; // 一格的宽度
    double half = GoBangs.GO_BANG_GRID_SIZE / 2; // 一格的宽度
    int modx = offset.dx ~/ level; // 点击位置左侧的格子数 ~/ 符号表示取整除法
    // 判断 x 坐标是否超过半格
    ddx = offset.dx - level * modx <= half ? level * modx : level * (modx + 1);
    int mody = offset.dy ~/ level;
    // 判断 y 坐标是否超过半格
    ddy = offset.dy - level * mody <= half ? level * mody : level * (mody + 1);
    print("ddx= ${ddx} + ddy = ${ddy}");
    return Offset(ddx, ddy); // 返回棋盘上的有效位置
  }

  /// 判断获胜的方法
  /// offset：当前落子的位置，black：当前是否为黑棋，offs：对应颜色棋子的集合
  bool win(Offset offset, bool black, List<Offset> offs) {
    // 每个方向的棋子坐标列表
    List<Offset> l = <Offset>[], r = <Offset>[], t = <Offset>[], b = <Offset>[];
    List<Offset> lt = <Offset>[], rt = <Offset>[], lb = <Offset>[], rb = <Offset>[];

    // 每个方向的计数器
    int l_count = 1, r_count = 1, t_count = 1, b_count = 1;
    int lt_count = 1, rt_count = 1, lb_count = 1, rb_count = 1;

    // 各方向遍历，判断是否形成 5 子
    // 获取画布的宽度和高度
    double canvasWidth = buildSize().width;
    double canvasHeight = buildSize().height;

    // 向左
    for (double x = offset.dx - GoBangs.GO_BANG_GRID_SIZE; x > 0; x -= GoBangs.GO_BANG_GRID_SIZE) {
      var item = Offset(x, offset.dy);
      if (offs.contains(item)) {
        l_count++;
        l.add(item);
        if (l_count >= 5) return true;
      } else
        break;
    }

    // 向右
    for (double x = offset.dx + GoBangs.GO_BANG_GRID_SIZE; x <= canvasWidth; x += GoBangs.GO_BANG_GRID_SIZE) {
      var item = Offset(x, offset.dy);
      if (offs.contains(item)) {
        r_count++;
        r.add(item);
        if (r_count >= 5) return true;
      } else
        break;
    }

    // 向上
    for (double y = offset.dy - GoBangs.GO_BANG_GRID_SIZE; y > 0; y -= GoBangs.GO_BANG_GRID_SIZE) {
      var item = Offset(offset.dx, y);
      if (offs.contains(item)) {
        t_count++;
        t.add(item);
        if (t_count >= 5) return true;
      } else
        break;
    }

    // 向下
    for (double y = offset.dy + GoBangs.GO_BANG_GRID_SIZE; y <= canvasHeight; y += GoBangs.GO_BANG_GRID_SIZE) {
      var item = Offset(offset.dx, y);
      if (offs.contains(item)) {
        b_count++;
        b.add(item);
        if (b_count >= 5) return true;
      } else
        break;
    }

    // 左上
    for (double x = offset.dx - GoBangs.GO_BANG_GRID_SIZE, y = offset.dy - GoBangs.GO_BANG_GRID_SIZE;
        x > 0 && y > 0;
        x -= GoBangs.GO_BANG_GRID_SIZE, y -= GoBangs.GO_BANG_GRID_SIZE) {
      var item = Offset(x, y);
      if (offs.contains(item)) {
        lt_count++;
        lt.add(item);
        if (lt_count >= 5) return true;
      } else
        break;
    }

    // 右上
    for (double x = offset.dx + GoBangs.GO_BANG_GRID_SIZE, y = offset.dy - GoBangs.GO_BANG_GRID_SIZE;
        x <= canvasWidth && y > 0;
        x += GoBangs.GO_BANG_GRID_SIZE, y -= GoBangs.GO_BANG_GRID_SIZE) {
      var item = Offset(x, y);
      if (offs.contains(item)) {
        rt_count++;
        rt.add(item);
        if (rt_count >= 5) return true;
      } else
        break;
    }

    // 左下
    for (double x = offset.dx - GoBangs.GO_BANG_GRID_SIZE, y = offset.dy + GoBangs.GO_BANG_GRID_SIZE;
        x > 0 && y <= canvasHeight;
        x -= GoBangs.GO_BANG_GRID_SIZE, y += GoBangs.GO_BANG_GRID_SIZE) {
      var item = Offset(x, y);
      if (offs.contains(item)) {
        lb_count++;
        lb.add(item);
        if (lb_count >= 5) return true;
      } else
        break;
    }

    // 右下
    for (double x = offset.dx + GoBangs.GO_BANG_GRID_SIZE, y = offset.dy + GoBangs.GO_BANG_GRID_SIZE;
        x <= canvasWidth && y <= canvasHeight;
        x += GoBangs.GO_BANG_GRID_SIZE, y += GoBangs.GO_BANG_GRID_SIZE) {
      var item = Offset(x, y);
      if (offs.contains(item)) {
        rb_count++;
        rb.add(item);
        if (rb_count >= 5) return true;
      } else
        break;
    }

    return false; // 没有形成 5 子，返回 false
  }
}
