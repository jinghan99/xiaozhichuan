import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'show_barrage_state.dart';

class ShowBarrageLogic extends GetxController
    with GetSingleTickerProviderStateMixin {
  final ShowBarrageState state = ShowBarrageState();
  late ScrollController scrollController;
  late AnimationController animationController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    // 设置为全屏模式，隐藏状态栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    init();
  }

  void init() {
    // 获取速度因子，假设 state.scrollSpeed 的值范围是 1 到 10
    int speedFactor = state.scrollSpeed;

    // 根据速度因子设置动画持续时间
    // 这里设置的持续时间为 (11 - speedFactor)，确保最小为 1 秒
    animationController = AnimationController(
      vsync: this,
      duration:
          Duration(seconds: (11 - speedFactor).clamp(1, 10)), // 确保持续时间至少为1秒
    );

    // 无限循环播放动画
    // animationController.repeat() - 让动画循环播放
    animationController.repeat();

    // 监听动画控制器的进度变化
    // 当动画的值发生变化时，会执行以下逻辑：
    animationController.addListener(() {
      // animationController.value 会在 0 到 1 之间变化，表示动画进度
      // scrollController.position.maxScrollExtent - 获取可滚动视图的最大滚动范围
      // 根据动画的进度，滚动视图到相应的位置，从而实现平滑滚动效果
      print(animationController.value );
      print(scrollController.position.maxScrollExtent );
      scrollController.jumpTo(animationController.value *
          scrollController.position.maxScrollExtent);
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    scrollController.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // 在 onClose 时恢复状态栏和导航栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.onClose();
  }
}
