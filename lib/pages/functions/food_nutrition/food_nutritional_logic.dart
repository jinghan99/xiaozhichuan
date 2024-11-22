import 'package:flutter_scaffold/db/dao/database_dao.dart';
import 'package:flutter_scaffold/db/entity/FoodNutritionEntity.dart';
import 'package:flutter_scaffold/db/service/food_nutrition_service.dart';
import 'package:flutter_scaffold/http/my_dio.dart';
import 'package:get/get.dart';
import 'food_nutritional_state.dart';
import 'info/food_info_view.dart';

class FoodNutritionalLogic extends GetxController with GetTickerProviderStateMixin {
  final FoodNutritionalState state = FoodNutritionalState();

  late final FoodNutritionService foodNutritionService;

  @override
  void onInit() async {
    super.onInit();
    // 等待数据库实例的初始化
    final db = await DatabaseDao().database;
    // 初始化 FoodNutritionService
    foodNutritionService = FoodNutritionService(db);
    state.totalCount.value = await foodNutritionService.getCount();
    state.isLoading.value = false;
    EasyLoading.show();
    getData(1);
  }

  void onLoading() {
    state.page++;
    getData(state.page);
  }

  void onRefresh() {
    state.page = 1;
    getData(state.page);
  }

  void getData(int page) {
    if(page == 1){
      state.data.clear();
    }
    foodNutritionService.searchByNamePage(state.searchController.text,page: state.page, pageSize: 20).then((List<FoodNutritionEntity> foodList) {
      state.data.addAll(foodList);
      state.controller
        ..refreshCompleted()
        ..loadComplete();
      state.page = page;
      EasyLoading.dismiss();
    }).catchError((error) {
      logger.e('Error: $error');
    });
  }

  // 跳转详情页
  void toInfo(FoodNutritionEntity food) {
    Get.to(FoodInfoPage(), arguments: food);
  }

  @override
  void onClose() {
    super.onClose();
  }
}
