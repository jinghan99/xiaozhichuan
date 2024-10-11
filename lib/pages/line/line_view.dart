import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'line_logic.dart';
import 'line_state.dart';




class LinePage extends StatelessWidget {
  const LinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final LineLogic logic = Get.put(LineLogic());
    final LineState state = Get.find<LineLogic>().state;
    return const Center(
      child: Text('linePage'),
    );
  }
}
