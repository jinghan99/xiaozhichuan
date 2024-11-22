import 'package:get/get.dart';

import 'food_nutritional_logic.dart';


class FoodNutritionalBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FoodNutritionalLogic());
  }
}
