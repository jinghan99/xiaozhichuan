import 'package:flutter/cupertino.dart';
import 'package:flutter_scaffold/pages/hot/play/play_logic.dart';
import 'package:flutter_scaffold/pages/hot/play/play_state.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';

class FullScreenPage extends StatelessWidget {
  const FullScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayLogic logic = Get.find<PlayLogic>();
    final PlayState state = logic.state;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0, //不显示
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth; // 动态获取屏幕宽度
        final height = constraints.maxHeight; // 动态获取屏幕高度
        return Container(
          width: width,
          height: height,
          child: Obx(() {
            state.progress.value;
            return AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                children: [
                  Container(
                    width: width,
                    height: height,
                    color: Colors.black,
                    child: Obx(() {
                      return VlcPlayer(
                        controller: state.videoPlayerController.value,
                        aspectRatio: 16 / 9,
                        placeholder: const Center(child: CupertinoActivityIndicator()),
                      );
                    }),
                  ),
                  Positioned(
                    bottom: 50, // 距离底部一定距离
                    left: 10, // 左侧距离
                    right: 20, // 右侧距离
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
                                    max: state.videoPlayerController.value.value.duration.inSeconds.toDouble(),
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
                          final currentDuration = state.videoPlayerController.value.value.position;
                          final totalDuration = state.videoPlayerController.value.value.duration;
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
              ),
            );
          }),
        );
      }),
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
                    width: 0.5, // 边框宽度
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
                    width: 0.5, // 边框宽度
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
                    width: 0.5, // 边框宽度
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
                    width: 0.5, // 边框宽度
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
