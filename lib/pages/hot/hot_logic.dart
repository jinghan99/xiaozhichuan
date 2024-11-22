import 'package:flutter_scaffold/entity/video/tou_tiao_rank_entity.dart';
import 'package:flutter_scaffold/http/request.dart';
import 'package:get/get.dart';

import '../../tools/extensions_exp.dart';
import '../route.dart';
import 'hot_state.dart';

class HotLogic extends GetxController with GetSingleTickerProviderStateMixin {
  final HotState state = HotState();

  late TabController? tabController;

  @override
  void onInit() {
    super.onReady();
    initTab();
    initLoading(state.selectedIndex.value);
  }

  void initTab() {
    // 初始化 TabController
    tabController = TabController(vsync: this, length: state.tabs.length);
    tabController?.addListener(() {
      ///避免addListener调用2次
      if (tabController?.index == tabController?.animation?.value) {
        onTabChanged(tabController!.index);
      }
    });
  }

  void onTabChanged(int index) {
    state.selectedIndex.value = index;
    if (state.tabContents[state.selectedIndex.value] != null && state.tabContents[state.selectedIndex.value]!.isNotEmpty) {
      return;
    }
    initLoading(index); // 切换Tab时加载内容
  }

  void onRefresh() {
    initLoading(state.selectedIndex.value);
  }

  void onLoading() {
    if (state.tabContents[state.selectedIndex.value]!.isNotEmpty) {
      state.controller
        ..refreshCompleted()
        ..loadComplete();
      return;
    }
    initLoading(state.selectedIndex.value);
  }

  void toPlay(Item item) {
    // 组装视频页参数
    Get.toNamed(play,arguments: item);
  }

  initLoading(int index) {
    EasyLoading.show();
    String channel = state.tabs[index];
    yingshiRanking({
      'area': '全部',
      'year': '全部',
      'channel': channel,
      'rank_type': '最热',
      'from': 'hot_page',
      'cate': '全部',
    }, (response, hasError) {
      if (!hasError) {
        ToutiaoRankeEntity data = ToutiaoRankeEntity.fromJson(response.data);
        if (data.data?.hits?.hit?.item != null) {
          state.tabContents[index] = data.data?.hits?.hit?.item;
        }
      }
      state.controller
        ..refreshCompleted()
        ..loadComplete();
      EasyLoading.dismiss();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
