import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_scaffold/db/entity/FoodNutritionEntity.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';

class FoodInfoPage extends StatelessWidget {
  const FoodInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 获取传递的参数 food
    final FoodNutritionEntity food = Get.arguments;
    return Scaffold(
      backgroundColor: cF5,
      appBar: buildAppBar(food),
      body: Container(
        width: 0.9.sw,
        height: 0.9.sh,
        child: DataTable2(
          columns: const [
            DataColumn(label: Text('项目')),
            DataColumn(label: Text('含量')),
          ],
          rows: _buildRows(food),
        ),
      ),
    );
  }

  AppBar buildAppBar(FoodNutritionEntity food) {
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
            Text(
              "${food.name}  100g",
              style: gr16b,
            ),
          ],
        ),
      ),
    );
  }

  List<DataRow> _buildRows(FoodNutritionEntity food) {
    final mapData = food.toMap(); // 将对象转换为 Map
    return mapData.entries.map((entry) {
      return DataRow(cells: [
        DataCell(Text(entry.key)), // 显示键（中文字段名）
        DataCell(Text(entry.value?.toString() ?? '-')), // 若为 null，则显示为 "null"
      ]);
    }).toList();
  }
}
