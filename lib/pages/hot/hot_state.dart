import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../entity/video/tou_tiao_rank_entity.dart';

class HotState {
  var rankingData = ToutiaoRankeEntity().obs;
  var tabContents = <List<Item>?>[].obs; // 用于存储Tab内容，初始时内容为null表示尚未加载
  var selectedIndex = 0.obs; // 当前选中的Tab索引

  RefreshController controller = RefreshController();

  List<String> tabs = [
    '电影',
    '电视剧',
    '综艺',
    '动漫',
  ];

  HotState() {
    tabContents.value = List.filled(tabs.length, null); // 初始化内容为null
  }
}
