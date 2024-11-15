

import 'package:flutter/material.dart';
import 'package:flutter_barrage/flutter_barrage.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FoodNutritionalState {

  TextEditingController searchController = TextEditingController();
  RefreshController controller = RefreshController();
  RxList data = [].obs;
  int page = 1;

  FoodNutritionalState() {
    ///Initialize variables
  }
}
