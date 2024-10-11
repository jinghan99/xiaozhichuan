

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../route.dart';

class RootState {

  List navigation = [
    {'name': '首页', 'icon': ['assets/stf/root/首页未选中.svg','assets/stf/root/首页选中.svg'], 'route': home},
    {'name': '分类', 'icon': ['assets/stf/root/消息未选中.svg','assets/stf/root/消息选中.svg'], 'route': category},
    {'name': '在线', 'icon': ['assets/stf/root/我的未选中.svg','assets/stf/root/我的选中.svg'], 'route': line}
  ];
  RxInt index = 0.obs;
  PageController controller = PageController(initialPage: 0);

  RootState() {
    ///Initialize variables
  }
}
