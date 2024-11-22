import 'package:flutter_aliplayer/flutter_aliplayer.dart';
import 'package:flutter_scaffold/pages/hot/play/play_logic.dart';
import 'package:flutter_scaffold/pages/hot/play/play_state.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayLogic logic = Get.put(PlayLogic());
    final PlayState state = Get.find<PlayLogic>().state;
    return Scaffold(
      appBar: buildAppBar(state),
      body: Obx(() {
        state.selectedEpisodeUrl.value;
        return Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Obx(() {
                state.selectedEpisodeUrl.value;
                return AliPlayerView(
                  onCreated: (viewId) {
                    ///将 渲染 View 设置给播放器
                    state.fAliplayer.setPlayerView(viewId);
                    state.fAliplayer.setUrl(state.selectedEpisodeUrl.value);
                  },
                );
              }),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, top: 15),
              width: context.width,
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
  }

  AppBar buildAppBar(PlayState state) {
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
                        child: CircularProgressIndicator(
                          strokeWidth: 1.5, // 设置进度条的粗细
                        ),
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
      if (state.tabController.value == null) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.orange), // 设置指示器的颜色
          ),
        );
      }

      return Expanded(
        // 使用 Expanded 包裹整个 tabbarController 确保其占据剩余空间
        child: Column(
          children: [
            tabbar(state, logic),
            Expanded(
              // 使用 Expanded 包裹 TabBarView 以占据剩余空间
              child: TabBarView(
                controller: state.tabController.value,
                children: state.tabContents.map((itemList) {
                  if (itemList == null) {
                    // 加载时显示加载提示
                    return const Center(child: CircularProgressIndicator());
                  }
                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, childAspectRatio: 2.2),
                    itemCount: itemList.length,
                    itemBuilder: (context, index) {
                      var item = itemList[index];
                      return GestureDetector(
                        child: Chip(
                          label: Obx(() {
                            return Text(
                              item.name,
                              style: TextStyle(
                                fontSize: 10, // 设置文字大小
                                color: item.url == state.selectedEpisodeUrl.value ? Colors.red : Colors.black, // 文字颜色
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

  Widget tabbar(PlayState state, PlayLogic logic) {
    return SizedBox(
      width: 1.sw,
      child: TabBar(
        controller: state.tabController.value,
        dividerHeight: 0,
        tabAlignment: TabAlignment.start,
        isScrollable: true,
        // 使 TabBar 可滚动
        labelColor: Colors.red,
        // 选中标签的文字颜色
        // unselectedLabelColor: Colors.black, // 未选中标签的文字颜色
        indicatorColor: Colors.red,
        // 设置底部滑动条颜色为红色
        labelStyle: const TextStyle(
          color: Colors.red, // 选中标签文字颜色
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
