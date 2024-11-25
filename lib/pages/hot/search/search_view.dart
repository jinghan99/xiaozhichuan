import 'package:flutter_scaffold/entity/video/vodVideo.dart';
import 'package:flutter_scaffold/pages/hot/search/search_logic.dart';
import 'package:flutter_scaffold/pages/hot/search/search_state.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchLogic logic = Get.put(SearchLogic());
    final SearchState state = Get.find<SearchLogic>().state;
    return Scaffold(
      appBar: buildAppBar(state, logic),
      body: Container(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Obx(() {
          return ListView.builder(
            itemCount: state.searchResultList.value.length,
            itemBuilder: (context, index) {
              Video video = state.searchResultList.value[index];
              return _buildItem(video, logic);
            },
          );
        }),
      ),
    );
  }

  Widget _buildItem(Video item, SearchLogic logic) {
    return Container(
      padding: const EdgeInsets.all(5),
      height: 140,
      child: Row(
        children: [
          SizedBox(
            width: 95,
            child: ImgUtils.buildImg(item.vodPic!, null),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        StringUtils.truncateText(item.vodName!, 10),
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromRGBO(25, 35, 56, 1.000)),
                        maxLines: 1, // 限制为单行
                      ),
                    ],
                  ),
                  Text(
                    "${item.vodYear!.split(' ')[0]} / ${item.vodArea!} / ${item.vodTag!}",
                    style: const TextStyle(color: Color.fromRGBO(92, 102, 120, 1), fontSize: 14),
                  ).marginSymmetric(vertical: 8),
                  const SizedBox(height: 7),
                  Text(
                    item.vodActor!,
                    style: const TextStyle(color: Color.fromRGBO(45, 56, 78, 1), fontSize: 12),
                    overflow: TextOverflow.ellipsis, // 当文本溢出时显示省略号
                    maxLines: 1, // 限制为单行
                  ),
                ],
              ),
            ).onTap(() {
              logic.toPlay(item);
            }),
          ),
        ],
      ),
    ).onTap(() {
      logic.toPlay(item);
    });
  }

  Widget searchHistory(SearchState state, SearchLogic logic) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.history),
              const SizedBox(width: 8),
              const Text("搜索历史", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              const Spacer(),
              TextButton(
                onPressed: () {
                  if (state.isEditingSearch.value) {
                    state.isEditingSearch.value = false;
                  } else {
                    state.isEditingSearch.value = true;
                  }
                },
                style: ButtonStyle(
                  minimumSize: WidgetStateProperty.all<Size>(const Size(10, 10)), // 设置最小尺寸
                ),
                child: Text(
                  state.isEditingSearch.value ? "完成编辑" : "编辑",
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              Visibility(
                visible: !state.isEditingSearch.value,
                child: TextButton(
                  onPressed: () {
                    logic.removeSearch();
                  },
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all<Size>(const Size(10, 10)), // 设置最小尺寸
                  ),
                  child: const Text(
                    "清空",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: SizedBox(
              width: 1.sw,
              child: Wrap(
                alignment: WrapAlignment.start,
                // 子组件在主轴上靠左排列
                runAlignment: WrapAlignment.start,
                // 子组件在交叉轴上靠上排列
                spacing: 5,
                runSpacing: 8,
                children: state.searchList.map((item) {
                  return GestureDetector(
                    onTap: () {
                      // 传递参数到路由
                      Get.toNamed('/search', arguments: {'searchText': item});
                    },
                    child: Chip(
                      label: Text(
                        item,
                        style: const TextStyle(fontSize: 12),
                      ),
                      backgroundColor: Colors.white, // 设置 Chip 的背景颜色
                      side: BorderSide(
                        color: Colors.red.withOpacity(0.2), // 淡化边框颜色
                        width: 1.0, // 边框宽度
                      ),
                      onDeleted: state.isEditingSearch.value
                          ? () {
                              logic.removeSearchByItem(item);
                            }
                          : null, // 当不在编辑模式时，删除按钮不可用,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(SearchState state, SearchLogic logic) {
    return AppBar(
      leading: Container(
        padding: const EdgeInsets.only(left: 10),
        child: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: c7BBD9C,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: cEAF5EF,
      title: SizedBox(
        width: 1.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            search(state, logic),
          ],
        ),
      ),
    );
  }

  Container search(SearchState state, SearchLogic logic) {
    return Container(
      height: 35.h,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // 阴影颜色和透明度
            spreadRadius: 2, // 阴影扩散半径
            blurRadius: 5, // 模糊半径
            offset: Offset(0, 3), // 阴影偏移量 (水平位移, 垂直位移)
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: state.searchController,
              cursorColor: Colors.grey,
              textInputAction: TextInputAction.search,
              // 设置为搜索动作
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '搜索视频',
                hintStyle: g14,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              style: TextStyle(color: c9C, fontSize: 12.sp),
              onSubmitted: (value) {
                hideKeyboard();
                logic.searchName();
              },
            ).marginSymmetric(horizontal: 5.w),
          ),
          Container(height: 20.w, width: 0.5, color: c9C, margin: EdgeInsets.symmetric(horizontal: 6.w)),
          TextButton(
            onPressed: () {
              hideKeyboard();
              logic.searchName();
            },
            child: const Text(
              '搜索',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
