import 'package:flutter_scaffold/entity/video/tou_tiao_rank_entity.dart';
import 'package:flutter_scaffold/http/request.dart';
import 'package:get/get.dart';

import '../../tools/extensions_exp.dart';
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
        logger.i("点击了下标为${tabController?.index}的tab");
        onTabChanged(tabController!.index);
      }
    });

  }

  void onTabChanged(int index) {
    state.selectedIndex.value = index;
     if (state.tabContents[state.selectedIndex.value]!.isNotEmpty) {
      return;
    }
    initLoading(index); // 切换Tab时加载内容
  }

  void onRefresh() async {
    initLoading(state.selectedIndex.value);
  }

  void onLoading() async {
    if (state.tabContents[state.selectedIndex.value]!.isNotEmpty) {
      state.controller
        ..refreshCompleted()
        ..loadComplete();
      return;
    }
    initLoading(state.selectedIndex.value);
  }

  initLoading(int index) {
    EasyLoading.show();
    logger.i("加载下标为${tabController?.index}的tab");
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
