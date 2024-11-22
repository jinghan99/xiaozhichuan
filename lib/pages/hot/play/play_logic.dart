import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scaffold/entity/video/select_episode.dart';
import 'package:flutter_scaffold/entity/video/vodVideo.dart';
import 'package:flutter_scaffold/http/my_dio.dart';
import 'package:flutter_scaffold/http/request.dart';
import 'package:flutter_scaffold/pages/hot/play/play_state.dart';
import 'package:flutter_scaffold/tools/my_constant.dart';
import 'package:get/get.dart';

class PlayLogic extends GetxController with GetTickerProviderStateMixin {
  final PlayState state = PlayState();

  @override
  void onReady() {
    super.onReady();
    initApi();
  }

  // 初始化接口
  void initApi() {
    logger.i("初始化api接口");
    String vodName = state.item.title ?? "";
    if (vodName.isEmpty) {
      logger.e("vodName为空");
    }
    try {
      for (int i = 1; i < AppConstants.apiVodUrl.length; i++) {
        String url = AppConstants.apiVodUrl[i];
        apiVod(url,
          {
            'wd': vodName,
            'ac': 'detail',
            'pg': 1,
          },
          (response, hasError) {
            try {
              logger.i(response);
              // 如果 response.data 是字符串，则需要进行 JSON 解析
              // 检测 response.data 是否为字符串类型
              var jsonData;
              if (response.data is String) {
                // 如果 response.data 是字符串，则需要进行 JSON 解析
                jsonData = jsonDecode(response.data); // 将字符串解析为 JSON 对象
              } else {
                // 如果 response.data 已经是 JSON 对象，则直接赋值
                jsonData = response.data;
              }
              var vodList = VodVideoList.fromJson(jsonData);
              if (vodList.list != null && vodList.list!.isNotEmpty) {
                for (int j = 0; j < vodList.list!.length; j++) {
                  Video info = vodList.list![j];
                  logger.i("找到的视频 ${info.vodName}");
                  if (info.vodName == vodName) {
                    logger.i("找到相同的视频 $vodName");
                    initEpisode(info);
                  }
                }
              }
              if (i == AppConstants.apiVodUrl.length - 1) {
                state.isLoading.value = false;
              }
            } catch (e) {
              logger.e("三方接口异常 ${e}");
              state.isLoading.value = false;
            }
          },
        );
      }
    } catch (e) {
      logger.e('Error: $e');
    }
  }


// 初始化集数
  void initEpisode(Video info) {
    List<String> froms = info.vodPlayFrom?.split("\$\$\$") as List<String>;
    List<String> urlfroms = info.vodPlayUrl?.split("\$\$\$") as List<String>;
    if (urlfroms.length != froms.length) {
      logger.e("集数和集数url数量不一致");
      return;
    }
    // 筛选m3u
    for (int i = 0; i < froms.length; i++) {
      String fromName = froms[i];
      String urlFromName = urlfroms[i];
      if (urlFromName.contains(".m3u") || urlFromName.contains(".m3u8")) {
        logger.i("$fromName : ${urlfroms[i]}");
        var plays = urlFromName.split("#");
        List<SelectEpisodeEntity> list = [];
        for (int j = 0; j < plays.length; j++) {
          var play = plays[j].split("\$");
          var url = play[1];
          if (state.selectedEpisodeUrl.value == "") {
            state.selectedEpisodeUrl.value = url;
          }
          list.add(SelectEpisodeEntity(name: play[0], url: url));
        }
        addTab(fromName, list);
      }
    }
  }


  // 添加 tab
  void addTab(String tabName, List<SelectEpisodeEntity> contents) {
    logger.i("添加 tab");
    if (tabName.isEmpty || contents.isEmpty) {
      logger.w("tab 数量不对");
      return;
    }
    List<String> tabTmp = state.tabs.value;
    tabTmp.add(tabName);
    List<List<SelectEpisodeEntity>?> contentTmp = state.tabContents.value;
    contentTmp.add(contents);
    state.tabs.value = tabTmp;
    state.tabContents.value = contentTmp;
    logger.i("添加 tab完毕");
    initTab();
  }

  // 初始化 tab
  void initTab() {
    state.tabController.value?.dispose(); // 销毁旧的 TabController
    state.tabController.value = TabController(vsync: this, length: state.tabs.length);
    state.tabController.value?.addListener(() {
      ///避免addListener调用2次
      if (state.tabController.value?.index == state.tabController.value?.animation?.value) {
        logger.i("点击了下标为${state.tabController.value?.index}的tab");
        onTabChanged(state.tabController.value!.index);
      }
    });
  }
  void onTabChanged(int index) {
    state.selectedIndex.value = index;
  }

// 逆转集数
  void reversedEpisode() {
    var list = state.tabContents[state.selectedIndex.value];
    list = list?.reversed.toList();
    state.tabContents[state.selectedIndex.value] = list;
  }

  void playMedia(String videoUrl) {
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
