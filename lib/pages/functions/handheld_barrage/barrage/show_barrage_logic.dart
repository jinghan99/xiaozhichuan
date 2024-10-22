import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'show_barrage_state.dart';

class ShowBarrageLogic extends GetxController with GetSingleTickerProviderStateMixin {
  final ShowBarrageState state = ShowBarrageState();
  late ScrollController scrollController;
  late AnimationController animationController;


  @override
  void onInit() {
    super.onInit();
    if(!state.isPortrait){
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
    init();
  }

  void init() {
    // 初始化 ScrollController，用于控制 SingleChildScrollView 的滚动
    scrollController = ScrollController();

    // 获取速度因子，假设 state.scrollSpeed 的值范围是 1 到 10
    int speedFactor = state.scrollSpeed;

    // 根据速度因子设置动画持续时间
    // 这里设置的持续时间为 (11 - speedFactor)，确保最小为 1 秒
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: (11 - speedFactor).clamp(1, 10)), // 确保持续时间至少为1秒
    );

    // 无限循环播放动画
    // animationController.repeat() - 让动画循环播放
    animationController.repeat();

    // 监听动画控制器的进度变化
    // 当动画的值发生变化时，会执行以下逻辑：
    animationController.addListener(() {
      // 使用 scrollController 控制滚动视图的滚动位置
      // animationController.value 会在 0 到 1 之间变化，表示动画进度
      // scrollController.position.maxScrollExtent - 获取可滚动视图的最大滚动范围
      // 根据动画的进度，滚动视图到相应的位置，从而实现平滑滚动效果
      scrollController.jumpTo(animationController.value * scrollController.position.maxScrollExtent);
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
    super.onClose();
  }
}
