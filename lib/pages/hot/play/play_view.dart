import 'package:flutter/cupertino.dart';
import 'package:flutter_scaffold/pages/hot/play/play_logic.dart';
import 'package:flutter_scaffold/pages/hot/play/play_state.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';
import 'package:video_player/video_player.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayLogic logic = Get.find<PlayLogic>();
    final PlayState state = Get.find<PlayLogic>().state;
    return Obx(() {
      return Scaffold(
        appBar: buildAppBar(state),
        body: Obx(() {
          state.isFullScreen.value;
          state.progress.value;
          if (state.isFullScreen.value) {//全屏
            return LayoutBuilder(builder: (context, constraints) {
              final width = constraints.maxWidth; // 动态获取屏幕宽度
              final height = constraints.maxHeight; // 动态获取屏幕高度
              return Container(
                color: Colors.black,
                width: width,
                height: height,
                child: buildAspectRatio(state, logic),
              );
            });
          }
          return Column(
            children: [
              Container(
                color: Colors.black,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: buildAspectRatio(state, logic),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, top: 15),
                width: 1.sw,
                child: title(state),
              ),
              anthologyPlay(state, logic),
              selectEpisode(state, logic),
              const SizedBox(
                height: 10,
              )
            ],
          );
        }),
      );
    });
  }

  // 构建播放画面
  Widget buildAspectRatio(PlayState state, PlayLogic logic) {
    return Obx(() {
      if (state.videoPlayerController.value == null && !state.isLoading.value) {
        return Container(
          color: Colors.black,
        );
      }
      if (state.videoPlayerController.value == null && state.isLoading.value) {
        return Container(
          color: Colors.black,
          child: const Center(
              child: CupertinoActivityIndicator(
            color: Colors.white,
          )),
        );
      }
      return Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: Colors.black,
            child: Obx(
              () {
                if (state.videoPlayerController.value != null && state.videoPlayerController.value!.value.isInitialized) {
                  return AspectRatio(
                    // 保持视频的宽高比
                    aspectRatio: state.videoPlayerController.value!.value.aspectRatio,
                    child: VideoPlayer(state.videoPlayerController.value!),
                  );
                }
                return const Center(
                    child: CupertinoActivityIndicator(
                  color: Colors.white,
                ));
              },
            ),
          ),
          Visibility(
              visible: state.isFullScreen.value,
              child: Positioned(
                top: 20, // 距离顶部一定距离
                left: 10, // 右侧距离
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    logic.toggleFullScreen();
                  },
                ),
              )),
          Visibility(
              visible: !state.isFullScreen.value,
              child: Positioned(
                top: 20, // 距离顶部一定距离
                right: 10, // 右侧距离
                child: IconButton(
                  icon: Icon(
                    Icons.fullscreen,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    logic.toggleFullScreen();
                  },
                ),
              )),
          Positioned(
            bottom: 0, // 距离顶部一定距离
            left: 15, // 左侧距离
            right: 15, // 右侧距离
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // 暂停/播放按钮
                Obx(() {
                  return IconButton(
                    icon: Icon(
                      state.isPlaying.value ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      logic.togglePlayPause();
                    },
                  );
                }),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 视频进度条
                        Obx(() {
                          state.progress.value;
                          return Slider(
                            activeColor: Colors.white,
                            inactiveColor: Colors.grey,
                            thumbColor: Colors.white,
                            min: 0,
                            value: state.progress.value,
                            max: state.videoPlayerController.value!.value.duration.inSeconds.toDouble(),
                            onChanged: (value) {
                              // 不再在拖动过程中调用 seekTo，只更新进度条
                              state.progress.value = value;
                            },
                            onChangeEnd: (value) {
                              // 滑动完成后才调用 seekTo
                              logic.seekTo(value);
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),
                // 显示时长
                Obx(() {
                  state.progress.value;
                  final currentDuration = state.videoPlayerController.value!.value.position;
                  final totalDuration = state.videoPlayerController.value!.value.duration;
                  final currentFormatted = StringUtils.formatDuration(currentDuration);
                  final totalFormatted = StringUtils.formatDuration(totalDuration);
                  return Text(
                    '$currentFormatted / $totalFormatted',
                    style: w14,
                  );
                }),
              ],
            ),
          ),
        ],
      );
    });
  }

  AppBar buildAppBar(PlayState state) {
    if (state.isFullScreen.value) {
      return AppBar(
        backgroundColor: cEAF5EF,
        toolbarHeight: 0,
      );
    }
    return AppBar(
      backgroundColor: cEAF5EF,
      title: Container(
        width: 1.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${state.item.title}",
              style: gr16b,
            ).paddingOnly(bottom: 8),
          ],
        ),
      ),
      actions: [
        Container(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {},
          ),
        ),
      ],
    );
  }

  Widget title(PlayState state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              state.item.title ?? "",
              style: b16b,
              maxLines: 1,
              overflow: TextOverflow.ellipsis, // 这里设置文本溢出的处理方式
            )
          ],
        ),
        SizedBox(
          width: 1.sw,
          child: Wrap(
            spacing: 5,
            runSpacing: 5,
            children: [
              if ((state.item.year ?? "").isNotEmpty)
                Chip(
                  label: Text(
                    state.item.year ?? "",
                    style: const TextStyle(
                      fontSize: 12, // 设置文字大小
                    ),
                  ),
                  side: const BorderSide(
                    color: Colors.grey, // 边框颜色
                    width: 0.1, // 边框宽度
                  ),
                ),
              if ((state.item.area ?? "").isNotEmpty)
                Chip(
                  label: Text(
                    state.item.area ?? "",
                    style: b12,
                  ),
                  side: const BorderSide(
                    color: Colors.grey, // 边框颜色
                    width: 0.1, // 边框宽度
                  ),
                ),
              if ((state.item.channel ?? "").isNotEmpty)
                Chip(
                  label: Text(
                    state.item.channel ?? "",
                    style: b12,
                  ),
                  side: const BorderSide(
                    color: Colors.grey, // 边框颜色
                    width: 0.1, // 边框宽度
                  ),
                ),
              if ((state.item.category ?? "").isNotEmpty)
                Chip(
                  label: Text(
                    state.item.category ?? "",
                    style: b12,
                  ),
                  side: const BorderSide(
                    color: Colors.grey, // 边框颜色
                    width: 0.1, // 边框宽度
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          width: 1.sw,
          child:Text(
            "${ state.item.desc ?? ""}",
            style: b12,
            maxLines: 5,
            overflow: TextOverflow.ellipsis, // 这里设置文本溢出的处理方式
          ).paddingOnly(top: 8),
        )

      ],
    );
  }

// 选集播放
  Widget anthologyPlay(PlayState state, PlayLogic logic) {
    return Obx(() {
      state.isLoading.value;
      return Container(
        padding: const EdgeInsets.all(10.0), // 设置内边距，相当于外边距
        width: 1.sw,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "选集播放",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 6,
            ),
            const Spacer(),
            Visibility(
                visible: state.isLoading.value,
                child: const Row(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 12.0, // 设置宽度
                        height: 12.0, // 设置高度
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "线路加载中...",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    )
                  ],
                )),
            IconButton(
              icon: const Icon(Icons.low_priority),
              onPressed: () {
                logic.reversedEpisode();
              },
            ),
          ],
        ),
      );
    });
  }

  Widget selectEpisode(PlayState state, PlayLogic logic) {
    return Obx(() {
      if (state.isLoading.value) {
        return const Center();
      }
      if (state.tabController.value == null) {
        return const Center(
          child: Text("资源数据为空"),
        );
      }
      return Expanded(
        // 使用 Expanded 包裹整个 tabbarController 确保其占据剩余空间
        child: Column(
          children: [
            tabBar(state, logic),
            Expanded(
              // 使用 Expanded 包裹 TabBarView 以占据剩余空间
              child: TabBarView(
                controller: state.tabController.value,
                children: state.tabContents.map((itemList) {
                  if (itemList == null) {
                    // 加载时显示加载提示
                    return const Center(child: CupertinoActivityIndicator());
                  }
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 2.2),
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      var item = itemList[index];
                      return GestureDetector(
                        child: Chip(
                          label: Obx(() {
                            state.selectedEpisodeUrl.value;
                            return Text(
                              item.name,
                              style: TextStyle(
                                fontSize: 10, // 设置文字大小
                                color: item.url == state.selectedEpisodeUrl.value ?  Colors.green : Colors.black, // 文字颜色
                              ),
                            );
                          }),
                          side: const BorderSide(
                            color: Colors.grey, // 边框颜色
                            width: 0.5, // 边框宽度
                          ),
                        ),
                        onTap: () {
                          // 选择集数
                          state.selectedEpisodeUrl.value = item.url;
                          logger.i("选择集数 ${item.name}  ${item.url} ${item.toString()}");
                          logic.playMedia(item.url);
                        },
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget tabBar(PlayState state, PlayLogic logic) {
    return SizedBox(
      width: 1.sw,
      child: TabBar(
        controller: state.tabController.value,
        dividerHeight: 0,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        // 使 TabBar 可滚动
        labelColor: c7BBD9C,
        // 选中标签的文字颜色
        // unselectedLabelColor: Colors.black, // 未选中标签的文字颜色
        indicatorColor: c7BBD9C,
        // 设置底部滑动条颜色为红色
        labelStyle: TextStyle(
          color: c7BBD9C, // 选中标签文字颜色
          fontWeight: FontWeight.w900, // 选中标签文字加粗
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.black, // 未选中标签文字颜色
          fontWeight: FontWeight.normal, // 未选中标签文字正常
        ),
        tabs: state.tabs.map((tab) => Tab(text: tab)).toList(),
        // 根据 tabs 列表生成 Tab 项
        onTap: (index) {
          // 更新当前选中的标签索引
          logic.onTabChanged(index);
        },
      ),
    );
  }
}
