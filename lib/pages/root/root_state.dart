

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../route.dart';

class RootState {

  List navigation = [
    {'name': '首页', 'type':'svg','icon': ['assets/stf/root/首页未选中.svg','assets/stf/root/首页选中.svg']},
    {'name': '热榜', 'type':'icon','icon': Icons.graphic_eq, },
    {'name': '在线', 'type':'svg','icon': ['assets/stf/root/我的未选中.svg','assets/stf/root/我的选中.svg']}
  ];

  RxInt index = 0.obs;
  PageController controller = PageController(initialPage: 0);

  RootState() {
    ///Initialize variables
  }
}
