import 'package:sqflite/sqflite.dart';

import '../entity/FoodNutritionEntity.dart';

class FoodNutritionService {
  final Database db;

  FoodNutritionService(this.db);

  // 插入
  Future<int> insert(FoodNutritionEntity food) async {
    return await db.insert('food_nutrition', food.toJson());
  }

  // 查询所有
  Future<List<FoodNutritionEntity>> getAll() async {
    final List<Map<String, dynamic>> maps = await db.query('food_nutrition');
    return List.generate(maps.length, (i) => FoodNutritionEntity.fromJson(maps[i]));
  }

  // 模糊查询
  Future<List<FoodNutritionEntity>> searchByName(String name) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'food_nutrition',
      where: 'name LIKE ?',
      whereArgs: ['%$name%'], // 使用通配符进行模糊匹配
    );
    return List.generate(maps.length, (i) => FoodNutritionEntity.fromJson(maps[i]));
  }

  // 查询所有（分页）
  Future<List<FoodNutritionEntity>> getAllPage({int page = 1, int pageSize = 20}) async {
    final offset = (page - 1) * pageSize; // 计算偏移量
    final List<Map<String, dynamic>> maps = await db.query(
      'food_nutrition',
      limit: pageSize,
      offset: offset,
    );
    return List.generate(maps.length, (i) => FoodNutritionEntity.fromJson(maps[i]));
  }

  // 模糊查询（分页）
  Future<List<FoodNutritionEntity>> searchByNamePage(String? name, {int page = 1, int pageSize = 20}) async {
    final offset = (page - 1) * pageSize; // 计算偏移量

    // 动态构建查询条件
    String? where;
    List<dynamic>? whereArgs;
    if (name != null && name.isNotEmpty) {
      where = 'name LIKE ?';
      whereArgs = ['%$name%'];
    }

    final List<Map<String, dynamic>> maps = await db.query(
      'food_nutrition',
      where: where,
      whereArgs: whereArgs,
      limit: pageSize,
      offset: offset,
    );

    return List.generate(maps.length, (i) => FoodNutritionEntity.fromJson(maps[i]));
  }

  // 更新
  Future<int> update(FoodNutritionEntity food) async {
    return await db.update(
      'food_nutrition',
      food.toJson(),
      where: 'id = ?',
      whereArgs: [food.id],
    );
  }

  // 删除
  Future<int> delete(int id) async {
    return await db.delete(
      'food_nutrition',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 查询总数量
  Future<int> getCount() async {
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM food_nutrition');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
