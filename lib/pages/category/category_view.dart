import 'package:flutter_scaffold/tools/extensions_exp.dart';
import 'category_logic.dart';
import 'category_state.dart';



class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryLogic logic = Get.put(CategoryLogic());
    final CategoryState state = Get.find<CategoryLogic>().state;
    return Scaffold(
      appBar: buildAppBar(),
      body: const Center(
        child: Text('CategoryPage'),
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
          onPressed: () {

          },
        ),
      ),
      backgroundColor: cEAF5EF,
      title: Container(
        width: 1.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("一个小纸船",style: grb16,).paddingOnly(bottom: 5),
            Text("兰溪三日桃花雨，半夜鲤鱼来上滩。",style: b12,),
          ],
        ),
      ),
      actions: [
        Container(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {

            },
          ),
        ),
      ],
    );
  }
}
