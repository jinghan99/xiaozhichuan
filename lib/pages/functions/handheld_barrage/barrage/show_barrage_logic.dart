import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barrage/flutter_barrage.dart';
import 'package:get/get.dart';

import 'show_barrage_state.dart';

class ShowBarrageLogic extends GetxController {
  final ShowBarrageState state = ShowBarrageState();

  @override
  void onReady() {
    super.onReady();
    if(!state.isPortrait){
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    }
// 页面加载时自动发送弹幕
    _startAutoBarrage();
  }

// 开始自动发送弹幕
  void _startAutoBarrage() {
    // 定时发送弹幕
    Future.doWhile(() async {
      state.barrageWallController.send([new Bullet(child: Text(state.text,style: TextStyle(color: state.textColor,fontSize: state.wordSize),))]);
      await Future.delayed(Duration(seconds: 3)); // 每 3 秒发送一次
      return true; // 继续循环
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}
