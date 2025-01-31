import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GoBangState {

  Offset off = Offset.zero;
  RxList<Offset> offs = <Offset>[].obs;//所有棋子的集合
  RxList<Offset> boffs = <Offset>[].obs;//黑棋集合
  RxList<Offset> woffs = <Offset>[].obs;//白棋集合

  GoBangState() {
    ///Initialize variables
  }
}

// 自定义五子棋常量
abstract final class GoBangs {

  static const double GO_BANG_GRID_SIZE =30.0;

}

