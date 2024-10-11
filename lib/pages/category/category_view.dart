import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'category_logic.dart';
import 'category_state.dart';



class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryLogic logic = Get.put(CategoryLogic());
    final CategoryState state = Get.find<CategoryLogic>().state;
    return const Center(
      child: Text('CategoryPage'),
    );
  }
}
