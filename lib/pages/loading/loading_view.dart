import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading_logic.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.lazyPut(() => LoadingLogic());
    final state = Get.find<LoadingLogic>().state;

    return Image.asset('assets/stf/login/login_bg.jpg',fit: BoxFit.fitHeight,);
  }
}
