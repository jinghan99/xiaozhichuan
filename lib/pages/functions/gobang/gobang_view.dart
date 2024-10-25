import 'package:flutter_scaffold/tools/extensions_exp.dart';

import 'gobang_logic.dart';
import 'gobang_state.dart';

class GoBangPage extends StatelessWidget {
  const GoBangPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GoBangLogic logic = Get.put(GoBangLogic());
    final GoBangState state = Get.find<GoBangLogic>().state;
    return Scaffold(backgroundColor: Colors.white, body: Center(child: Text("12")));
  }
}
