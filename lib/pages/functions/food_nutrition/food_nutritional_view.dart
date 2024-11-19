import 'package:flutter/cupertino.dart';
import 'package:flutter_scaffold/db/entity/FoodNutritionEntity.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      appBar: buildAppBar(state, logic),
      body: Obx(() {
        if (state.isLoading.value) {
          return const Center(child: CupertinoActivityIndicator());
        }
        return Column(
          children: [
            Expanded(
              child: Obx(() {
                state.data;
                return SmartRefresher(
                  controller: state.controller,
                  onLoading: logic.onLoading,
                  onRefresh: logic.onRefresh,
                  enablePullUp: true,
                  child: MasonryGridView.count(
                    padding: EdgeInsets.all(10.w),
                    crossAxisCount: 2,
                    // 两列
                    mainAxisSpacing: 8,
                    // 主轴方向间距
                    crossAxisSpacing: 8,
                    // 交叉轴方向间距
                    itemCount: state.data.length,
                    itemBuilder: (c, index) {
                      FoodNutritionEntity data = state.data[index];
                      return Container(
                        decoration: BoxDecoration(
                          gradient: matchGradient(data.phe),
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                        padding: EdgeInsets.all(1.w),
                        child: Column(children: [
                          Container(
                            padding: EdgeInsets.all(5.w),
                            margin: EdgeInsets.only(top: 5.h),
                            alignment: Alignment.centerLeft,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${data.name}",
                                    style: b14b, // 修改为 14
                                  ),
                                  TextSpan(
                                    text: " 100g",
                                    style: b12b, // 修改为 12
                                  ),
                                ],
                              ),
                              overflow: TextOverflow.clip,
                              maxLines: 2,
                            ),
                          ).marginOnly(bottom: 2.h),
                          Container(
                            padding: EdgeInsets.all(5.w),
                            child: Column(
                              children: [

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "热量(kj)",
                                      style: b14,
                                    ),
                                    Text(
                                      "${data.energyKj}",
                                      style: b14,
                                    ),
                                  ],
                                ).marginOnly(bottom: 5.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "碳水(g)",
                                      style: b14,
                                    ),
                                    Text(
                                      "${data.choG}",
                                      style: b14,
                                    ),
                                  ],
                                ).marginOnly(bottom: 5.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "蛋白质(g)",
                                      style: b14,
                                    ),
                                    Text(
                                      "${data.proteinG}",
                                      style: b14,
                                    ),
                                  ],
                                ).marginOnly(bottom: 5.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "phe(mg)",
                                      style: b14,
                                    ),
                                    Text(
                                      "${data.phe}",
                                      style: b14,
                                    ),
                                  ],
                                ).marginOnly(bottom: 5.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "脂肪(Fat)(g)",
                                      style: b14,
                                    ),
                                    Text(
                                      "${data.fatG}",
                                      style: b14,
                                    ),
                                  ],
                                ).marginOnly(bottom: 5.h),
                              ],
                            ),
                          ),
                        ]),
                      ).onTap(() {
                        hideKeyboard();
                      });
                    },
                  ),
                );
              }),
            ),
          ],
        );
      }),
    );
  }

  AppBar buildAppBar(FoodNutritionalState state, FoodNutritionalLogic logic) {
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

  Container search(FoodNutritionalState state, FoodNutritionalLogic logic) {
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
                hintText: '搜索食物',
                hintStyle: g14,
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              style: TextStyle(color: c9C, fontSize: 12.sp),
              onSubmitted: (value) {
                hideKeyboard();
                state.controller.requestRefresh();
              },
            ).marginSymmetric(horizontal: 5.w),
          ),
          Container(height: 20.w, width: 0.5, color: c9C, margin: EdgeInsets.symmetric(horizontal: 6.w)),
          TextButton(
            onPressed: () {
              hideKeyboard();
              state.controller.requestRefresh();
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

  // 匹配背景颜色
  LinearGradient matchGradient(double? value) {
    if (value == null) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Color(0xFFaccbee), // #accbee
        ],
      );
    }

    if (value < 100) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Color(0xFF7CA884), // #dad4ec
        ],
        stops: [
          0.2, // 白色开始
          0.99, // 粉色从 80% 的位置开始
        ],
      );
    }
    if (value > 100 && value < 249) {
      return const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Color(0xFFF0CC89), // #dad4ec
        ],
        stops: [
          0.2, // 白色开始
          0.99, // 粉色从 80% 的位置开始
        ],
      );
    }
    return const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Colors.white,
        Color(0xFFF5BBCA), // #bfd9fe
      ],
      stops: [
        0.2, // 白色开始
        0.99, // 粉色从 80% 的位置开始
      ],
    );
  }
}
