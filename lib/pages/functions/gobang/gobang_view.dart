import 'package:flutter_scaffold/pages/functions/time_screen/time_screen_logic.dart';
import 'package:flutter_scaffold/pages/functions/time_screen/time_screen_state.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';

class GoBangPage extends StatelessWidget {
  const GoBangPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TimeScreenLogic logic = Get.put(TimeScreenLogic());
    final TimeScreenState state = Get.find<TimeScreenLogic>().state;
    return Scaffold(backgroundColor: Colors.black,
        body: Container(child: Text("12")));
  }
}
