

import 'package:flutter/material.dart';
import 'package:flutter_barrage/flutter_barrage.dart';
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
