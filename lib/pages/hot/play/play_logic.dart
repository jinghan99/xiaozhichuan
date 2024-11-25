import 'dart:async';
import 'dart:convert';
import 'package:flutter_scaffold/entity/video/select_episode.dart';
import 'package:flutter_scaffold/entity/video/vodVideo.dart';
import 'package:flutter_scaffold/http/request.dart';
import 'package:flutter_scaffold/pages/hot/play/play_state.dart';
import 'package:flutter_scaffold/tools/my_constant.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';
import 'package:video_player/video_player.dart';

class PlayLogic extends GetxController with GetTickerProviderStateMixin {
  final PlayState state = PlayState();

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
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
            playMedia(url);
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

  void playMedia(String videoUrl) async {
    state.isPlaying.value = false;
    state.selectedEpisodeUrl.value = videoUrl;
    // 1. 停止当前视频播放并释放资源
    await state.videoPlayerController.value?.pause();
    await state.videoPlayerController.value?.dispose();
    // 2. 设置新的播放地址
    state.videoPlayerController.value = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    state.progress.value = 0.0;
    // 3. 初始化并准备播放
    await state.videoPlayerController.value?.initialize();
    await state.videoPlayerController.value?.play();
    state.isPlaying.value = true;
    // 如果已经有一个定时器在运行，取消它
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateProgress();
    });
  }

  /// 播放/暂停切换
  void togglePlayPause() {
    final controller = state.videoPlayerController.value;
    // 检查控制器是否为 null 或未初始化
    if (controller == null || !controller.value.isInitialized) {
      print("视频尚未初始化");
      return;
    }
    // 切换播放状态
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
    // 使用 Rx 自动更新播放状态
    state.isPlaying.value = controller.value.isPlaying;
  }

  /// 跳转到指定进度
  Future<void> seekTo(double progress) async {
    final position = Duration(seconds: progress.toInt());
    state.videoPlayerController.value?.seekTo(position);
  }

  /// 全屏切换
  void toggleFullScreen() {
    if (state.isFullScreen.value) {
      AppUtils.getExitFullScreen();
    } else {
      AppUtils.getFullScreen();
    }
    state.isFullScreen.value = !state.isFullScreen.value;
  }

  /// 更新进度条
  void _updateProgress() async {
    // 获取当前播放位置
    Duration position = await state.videoPlayerController.value!.value.position;
    Duration duration = await state.videoPlayerController.value!.value.duration;
    // 计算进度条的百分比
    if (duration.inSeconds > 0) {
      // 更新进度条的值
      state.progress.value = position.inSeconds.toDouble();
    }
  }
  // 改变
  void toggleShowTime(){
    state.isShowTime.value = !state.isShowTime.value;
  }

  @override
  void onClose() async {
    if (_timer != null && _timer!.isActive) {
      _timer?.cancel();
    }
    if (state.isFullScreen.value) {
      AppUtils.getExitFullScreen();
    }
    if (state.videoPlayerController.value != null) {
      await state.videoPlayerController.value?.pause(); // 停止播放
      await state.videoPlayerController.value?.dispose(); // 释放资源
    }
    super.onClose();
  }
}
