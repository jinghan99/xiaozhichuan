
import 'package:flutter_scaffold/tools/extensions_exp.dart';

import '../../../entity/video/tou_tiao_rank_entity.dart';

class PlayState {
  late Item item;

  PlayState() {
       // 获取传递的参数 food
     item = Get.arguments as Item;
  }
}
