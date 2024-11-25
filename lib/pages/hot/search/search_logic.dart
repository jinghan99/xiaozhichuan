import 'dart:convert';

import 'package:flutter_scaffold/entity/video/tou_tiao_rank_entity.dart';
import 'package:flutter_scaffold/entity/video/vodVideo.dart';
import 'package:flutter_scaffold/http/my_dio.dart';
import 'package:flutter_scaffold/http/request.dart';
import 'package:flutter_scaffold/pages/hot/search/search_state.dart';
import 'package:flutter_scaffold/pages/route.dart';
import 'package:flutter_scaffold/tools/my_constant.dart';
import 'package:flutter_scaffold/tools/sp_utils.dart';
import 'package:get/get.dart';

class SearchLogic extends GetxController {
  final SearchState state = SearchState();
  final spUtils = SPUtil();

  @override
  void onInit() {
    super.onInit();
    initSearchList();
  }

  // 初始化搜索历史
  void initSearchList() async {
    if (await spUtils.hasKey("searchList")) {
      spUtils.getStorage('searchList').then((dynamic data) {
        logger.i("searchList $data");
        // 确保 data 是 List<dynamic>
        List dynamicList = data as List<dynamic>;
        // 将 List<dynamic> 转换为 List<ConfigSourcesUrl>
        state.searchList.value = dynamicList.cast<String>().toList();
        logger.i("configList ${state.searchList.length}");
      });
    }
  }

  void addSearch(String item) async {
    // 添加到搜索记录
    state.searchList.add(item);
    // 去重
    state.searchList.value = state.searchList.toSet().toList();
    // 更新搜索记录
    spUtils.setStorage("searchList", state.searchList);
  }

  void removeSearch() async {
    // 移除搜索记录
    state.searchList.value = [];
    // 更新搜索记录
    spUtils.removeStorage("searchList");
  }

  void removeSearchByItem(String item) async {
    state.searchList.remove(item);
    // 更新搜索记录
    spUtils.setStorage("searchList", state.searchList);
  }

  void onLoading() {
    searchName(state.searchController.value.text);
  }

  void onRefresh() {
    searchName(state.searchController.value.text);
  }

  void searchName(String? vodName) async {
    if (vodName == null || vodName.isEmpty) {
      return;
    }
    state.isLoading.value = true;
    state.searchController.text = vodName;
    addSearch(vodName);
    state.searchResultList.value.clear();
    try {
      for (int i = 0; i < AppConstants.apiVodUrl.length; i++) {
        String url = AppConstants.apiVodUrl[i];
        apiVod(
          url,
          {
            'wd': vodName,
            'ac': 'detail',
            'pg': 1,
          },
          (response, hasError) {
            try {
              logger.i('${url} ${response}');
              var jsonData;
              if (response.data is String) {
                jsonData = jsonDecode(response.data); // 将字符串解析为 JSON 对象
              } else {
                // 如果 response.data 已经是 JSON 对象，则直接赋值
                jsonData = response.data;
              }
              var vodList = VodVideoList.fromJson(jsonData);
              addSearchList(vodList.list);
            } catch (e) {
              logger.e("三方接口异常 ${e}");
            }
          },
        );
      }
    } catch (e) {
      logger.e('Error: $e');
    }
  }

  void addSearchList(List<Video>? items) {
    logger.i("添加搜索记录 $items");
    if (items == null || items.isEmpty) {
      logger.i("搜索记录为空");
      return;
    }
    for (int i = 0; i < items.length; i++) {
      var item = items[i];
      if (state.searchResultMap.value.containsKey(item.vodName!)) {
        logger.i("搜索记录中已经存在 ${item.vodName}");
        break;
      }
      // 添加新记录
      state.searchResultMap.value[item.vodName!] = item;
    }
    final entries = state.searchResultMap.value.entries.toList();
    state.searchResultList.value = entries.map((entry) => entry.value).toList();
    state.isLoading.value = false;
    logger.i("搜索记录 ${state.searchResultList.value.length}");
  }

  void toPlay(Video video) {
    logger.i("toPlay $video");
    Item item = Item(
      title: video.vodName,
      actors: video.vodActor,
      channel: video.vodClass,
      area: video.vodArea,
      year: video.vodYear,
      pubDate: video.vodPubdate,
      src: video.vodPic,
    );
    // 组装视频页参数
    Get.toNamed(play, arguments: item);
  }

  @override
  void onClose() {
    state.searchController.dispose();
    super.onClose();
  }
}
