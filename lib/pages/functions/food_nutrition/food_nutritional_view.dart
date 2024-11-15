import 'package:flutter/cupertino.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'food_nutritional_logic.dart';
import 'food_nutritional_state.dart';

class FoodNutritionalPage extends StatelessWidget {
  const FoodNutritionalPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FoodNutritionalLogic logic = Get.put(FoodNutritionalLogic());
    final FoodNutritionalState state = Get.find<FoodNutritionalLogic>().state;
    return Scaffold(
      backgroundColor: cF5,
      appBar: buildAppBar(state),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              itemBuilder: (c, index) {
                return Container(
                  margin: EdgeInsets.only(top: 5.h),
                  padding: EdgeInsets.all(15.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(children: [
                    Row(
                      children: [
                        Text(
                          "面条" + " 100g",
                          style: gr14,
                        ),
                      ],
                    ).marginOnly(bottom: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "蛋白质(g)",
                          style: gr14,
                        ),
                        Text(
                          "10.4",
                          style: gr14,
                        ),
                      ],
                    ).marginOnly(bottom: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "热量(kj)",
                          style: gr14,
                        ),
                        Text(
                          "10.4",
                          style: gr14,
                        ),
                      ],
                    ).marginOnly(bottom: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "碳水化合物(CHO)(g)",
                          style: gr14,
                        ),
                        Text(
                          "10.4",
                          style: gr14,
                        ),
                      ],
                    ).marginOnly(bottom: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "脂肪(Fat)(g)",
                          style: gr14,
                        ),
                        Text(
                          "10.4",
                          style: gr14,
                        ),
                      ],
                    ).marginOnly(bottom: 5.h),
                  ]),
                ).onTap(() {
                  hideKeyboard();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(FoodNutritionalState state) {
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
            search(state),
          ],
        ),
      ),
    );
  }

  Container search(FoodNutritionalState state) {
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
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '搜索食物',
                hintStyle: g14,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              style: TextStyle(color: c9C, fontSize: 12.sp),
            ).marginSymmetric(horizontal: 5.w),
          ),
          Container(height: 20.w, width: 0.5, color: c9C, margin: EdgeInsets.symmetric(horizontal: 6.w)),
          TextButton(
            onPressed: () {
              hideKeyboard();
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
