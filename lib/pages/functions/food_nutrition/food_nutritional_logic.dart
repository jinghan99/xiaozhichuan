import 'package:get/get.dart';

import 'food_nutritional_state.dart';

class FoodNutritionalLogic extends GetxController with GetTickerProviderStateMixin {
  final FoodNutritionalState state = FoodNutritionalState();

  @override
  void onInit() {
    super.onInit();

  }
  void onLoading() {
    state.page++;
    getData();
  }

  void onRefresh() {
    state.page = 1;
    getData();
  }

  void getData() {
    state.controller
      ..refreshCompleted()
      ..loadComplete();
  }

  @override
  void onClose() {

    super.onClose();
  }
}
