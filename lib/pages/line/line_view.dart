import 'package:flutter_scaffold/tools/extensions_exp.dart';
import 'line_logic.dart';
import 'line_state.dart';

class LinePage extends StatelessWidget {
  const LinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LineLogic logic = Get.put(LineLogic());
    final LineState state = Get.find<LineLogic>().state;
    return Scaffold(
      appBar: buildAppBar(),
      body: const Center(
        child: Text('line'),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: Container(
        padding: EdgeInsets.only(left: 10),
        child: IconButton(
          icon: Icon(Icons.dehaze),
          color: c7BBD9C,
          onPressed: () {},
        ),
      ),
      backgroundColor: cEAF5EF,
      title: Container(
        width: 1.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "一个小纸船",
              style: grb16,
            ).paddingOnly(bottom: 5),
            Text(
              "兰溪三日桃花雨，半夜鲤鱼来上滩。",
              style: b12,
            ),
          ],
        ),
      ),
      actions: [
        Container(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
