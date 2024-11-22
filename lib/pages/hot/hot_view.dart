import 'package:flutter_scaffold/entity/video/tou_tiao_rank_entity.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'hot_logic.dart';
import 'hot_state.dart';

class HotPage extends StatelessWidget {
  const HotPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HotLogic logic = Get.put(HotLogic());
    final HotState state = Get.find<HotLogic>().state;
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          tabBar(state, logic),
          Expanded(
            // 使用 Expanded 包裹 TabBarView 以占据剩余空间
            child: Obx(() {
              state.tabContents;
              return SmartRefresher(
                controller: state.controller,
                onLoading: logic.onLoading,
                onRefresh: logic.onRefresh,
                enablePullDown: true,
                enablePullUp: false,
                child: TabBarView(
                  controller: logic.tabController,
                  children: state.tabContents.map((itemList) {
                    if (itemList == null) {
                      return Container();
                    }
                    return ListView.builder(
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        var item = itemList[index];
                        return _buildItem(item);
                      },
                    );
                  }).toList(),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: cEAF5EF,
      title: Container(
        width: 1.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "热榜",
              style: gr16b,
            ).paddingOnly(bottom: 8),
            Text(
              "大家都在搜的热点视频",
              style: b12,
            ),
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

  Widget tabBar(HotState state, HotLogic logic) {
    return TabBar(
      controller: logic.tabController,
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
        fontWeight: FontWeight.normal, // 选中标签文字加粗
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
    );
  }

  Widget _buildItem(Item item) {
    return Container(
       padding: const EdgeInsets.all(5),
        height: 140,
        child: Row(
          children: [
            Container(
              width: 95,
              child: ImgUtils.buildImg(item.src!, item.ranking!),
            ),
            Expanded(
                flex: 8,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 14),
                  margin: const EdgeInsets.only(left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _truncateText(item.title!, 10),
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromRGBO(25, 35, 56, 1.000)),
                            maxLines: 1, // 限制为单行
                          ),
                          Text(
                            item.hotScore!,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color.fromRGBO(247, 37, 23, 1.000),
                            ),
                            maxLines: 1, // 限制为单行
                          ),
                        ],
                      ),
                      Text(
                        "${item.pubDate!.split(' ')[0]} / ${item.area!} / ${item.category!}",
                        style: const TextStyle(color: Color.fromRGBO(92, 102, 120, 1), fontSize: 14),
                      ).marginSymmetric(vertical: 8),
                      const SizedBox(height: 7),
                      Text(
                        item.actors!,
                        style: const TextStyle(color: Color.fromRGBO(45, 56, 78, 1), fontSize: 12),
                        overflow: TextOverflow.ellipsis, // 当文本溢出时显示省略号
                        maxLines: 1, // 限制为单行
                      ),
                    ],
                  ),
                )),
          ],
        ),
      );
  }

  String _truncateText(String text, int maxLength) {
    // 截取文本并添加省略号
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }
}
