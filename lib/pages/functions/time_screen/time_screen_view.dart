import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_scaffold/pages/functions/time_screen/time_screen_logic.dart';
import 'package:flutter_scaffold/pages/functions/time_screen/time_screen_state.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';

class TimeScreenPage extends StatelessWidget {
  const TimeScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TimeScreenLogic logic = Get.put(TimeScreenLogic());
    final TimeScreenState state = Get.find<TimeScreenLogic>().state;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: PageView.builder(
        controller: logic.pageController,
        itemCount: 60, // 秒数为60
        itemBuilder: (context, index) {
          return Center(
            child: Text(
              (index).toString(),
              style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
            ),
          );
        },
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
              "时间屏幕",
              style: gr16b,
            ).paddingOnly(bottom: 5),
          ],
        ),
      ),
    );
  }

}
