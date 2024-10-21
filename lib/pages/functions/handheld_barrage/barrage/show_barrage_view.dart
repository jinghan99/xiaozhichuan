import 'package:flutter_barrage/flutter_barrage.dart';
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
      body: Stack(
        children: [
          // 全屏的弹幕墙
          BarrageWall(
            speed: state.scrollSpeed,
            controller: state.barrageWallController,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            maxBulletHeight: 1,
            child: Container(
              color: state.backgroundColor,
            )
          ),
        ],
      ),
    );
  }


}
