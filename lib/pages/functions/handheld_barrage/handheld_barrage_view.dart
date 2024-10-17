import 'package:flutter_scaffold/tools/extensions_exp.dart';

import 'handheld_barrage_logic.dart';
import 'handheld_barrage_state.dart';

class HandheldBarragePage extends StatelessWidget {
  const HandheldBarragePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HandheldBarrageLogic logic = Get.put(HandheldBarrageLogic());
    final HandheldBarrageState state = Get.find<HandheldBarrageLogic>().state;
    return Scaffold(
      appBar: buildAppBar(),
      body: const Center(
        child: Text('handheldBarrage'),
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
              "手持弹幕",
              style: grb16,
            ).paddingOnly(bottom: 5),
          ],
        ),
      ),
    );
  }
}
