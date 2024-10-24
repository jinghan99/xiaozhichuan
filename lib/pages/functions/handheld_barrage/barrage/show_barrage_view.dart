import 'package:flutter_scaffold/tools/extensions_exp.dart';
import 'show_barrage_logic.dart';
import 'show_barrage_state.dart';

class ShowBarragePage extends StatelessWidget {
  const ShowBarragePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ShowBarrageLogic logic = Get.put(ShowBarrageLogic());
    final ShowBarrageState state = logic.state;
    return Scaffold(
      body: LayoutBuilder(builder: (context,constraints){
        final width = constraints.maxWidth;  // 动态获取屏幕宽度
        final height = constraints.maxHeight; // 动态获取屏幕高度
        return Container(
          color: state.backgroundColor, // 设置背景色为蓝灰色
          width: width, // 适配横竖屏的宽度
          height: height, // 适配横竖屏的高度
          child: Center(
            // 使用 Center 将滚动的内容居中显示
            child: SingleChildScrollView(
              controller: logic.scrollController,
              scrollDirection: Axis.horizontal, // 设置滚动方向为水平
              child: Row(
                children: [
                  SizedBox(width: width, height: height), // 空间让文字从屏幕右侧进入
                  Text(
                    state.text,
                    style: TextStyle(fontSize: state.wordSize, color: state.textColor), // 设置文字大小和颜色
                  ),
                  SizedBox(width: width, height: height), // 空间让文字滚动到屏幕左侧后重新进入
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
