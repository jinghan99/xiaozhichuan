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
      body: Container(
        color: state.backgroundColor, // 设置背景色为蓝灰色
        width: 1.sw, // 设置宽度为全屏
        height: 1.sh, // 设置高度为全屏
        child: Center(
          // 使用 Center 将滚动的内容居中显示
          child: SingleChildScrollView(
            controller: logic.scrollController,
            scrollDirection: Axis.horizontal, // 设置滚动方向为水平
            child: Row(
              children: [
                SizedBox(width: 1.sw), // 文字从屏幕右侧进入
                Text(
                  state.text,
                  style: TextStyle(fontSize: state.wordSize, color: state.textColor), // 设置文字大小和颜色
                ),
                SizedBox(width: 1.sw), // 文字滚动到屏幕左侧后重新进入
              ],
            ),
          ),
        ),
      ),
    );
  }
}
