import 'package:flutter_scaffold/tools/extensions_exp.dart';
import 'package:flutter_scaffold/tools/my_constant.dart';
import 'home_logic.dart';
import 'home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeLogic logic = Get.put(HomeLogic());
    final HomeState state = Get.find<HomeLogic>().state;
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (c, index) {
            return SizedBox(
              height: 5.w,
            );
          },
          itemCount: AppCategories.categories.length,
          itemBuilder: (context, index) {
            final category = AppCategories.categories.entries.elementAt(index);
            final categoryName = category.key;
            final appList = category.value;
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ExpansionTile(
                initiallyExpanded: index == 0,//第一个保持展开
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                ),
                collapsedShape: const Border(
                  top: BorderSide.none,
                  bottom: BorderSide.none,
                ),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                title: Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      width: 4,
                      height: 25,
                      decoration: BoxDecoration(
                        color: c7BBD9C,
                      ),
                    ),
                    Text(categoryName, style: b16b),
                    const SizedBox(width: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: c7BBD9C,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("${appList.length}个应用", style: w8),
                    )
                  ],
                ),
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 19, right: 5, bottom: 15, top: 10),
                    child: Wrap(
                      spacing: 10, // 子元素之间的水平间距
                      runSpacing: 20, // 子元素之间的垂直间距
                      children: appList.map<Widget>((app) {
                        final appName = app["name"];
                        final appRoute = app["route"];
                        return GestureDetector(
                          onTap: () => Get.toNamed(appRoute), // 点击事件处理
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: cF5, // 背景颜色
                              borderRadius: BorderRadius.circular(8), // 圆角
                            ),
                            child: Text(appName, style: b14, textAlign: TextAlign.center), // 应用名称,
                          ),
                        );
                      }).toList(),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: Container(
        padding: EdgeInsets.only(left: 10),
        child: IconButton(
          icon: Icon(Icons.dehaze),
          color: c7BBD9C,
          onPressed: () {},
        ),
      ),
      backgroundColor: cE5F2EB,
      title: Container(
        width: 1.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "一个小纸船",
              style: gr16b,
            ).paddingOnly(bottom: 5),
            Text(
              "兰溪三日桃花雨，半夜鲤鱼来上滩。",
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
}
