

import 'package:flutter/material.dart';
import 'package:flutter_barrage/flutter_barrage.dart';
import 'package:flutter_scaffold/db/entity/FoodNutritionEntity.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FoodNutritionalState {

  TextEditingController searchController = TextEditingController();
  RefreshController controller = RefreshController();
  RxList<FoodNutritionEntity> data = <FoodNutritionEntity>[].obs;
  int page = 1;
  RxInt totalCount = 0.obs;

  RxBool isLoading = true.obs;
  FoodNutritionalState() {
    ///Initialize variables
  }
}
