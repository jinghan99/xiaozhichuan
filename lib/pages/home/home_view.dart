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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: c7BBD9C,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text("${appList.length}个应用", style: w8),
                    )
                  ],
                ),
                children: appList.map((app) {
                  final appName = app["name"];
                  final appRoute = app["route"];
                  return ListTile(
                    title: Text(appName, style: b14),
                    onTap: () => Get.toNamed(appRoute),
                  );
                }).toList(),
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
      backgroundColor: cEAF5EF,
      title: Container(
        width: 1.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "一个小纸船",
              style: grb16,
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
