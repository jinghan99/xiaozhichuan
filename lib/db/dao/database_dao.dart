import 'package:flutter/services.dart';
import 'package:flutter_scaffold/http/my_dio.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseDao {
  static final DatabaseDao _instance = DatabaseDao._internal();
  static Database? _database;

  factory DatabaseDao() => _instance;

  DatabaseDao._internal();

  // 获取数据库实例
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // 初始化数据库
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'food_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // 创建表
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS food_nutrition (
      id INTEGER PRIMARY KEY AUTOINCREMENT, -- 主键自增
      name TEXT NOT NULL DEFAULT '', -- 名称
      edible TEXT DEFAULT NULL, -- 食部(Edible)
      water_g TEXT DEFAULT NULL, -- 水分(Water)g
      energy_kj TEXT DEFAULT NULL, -- 能量（千焦）KJ
      energy_kcal TEXT DEFAULT NULL, -- 能量（千卡）Ka
      protein_g REAL DEFAULT NULL, -- 蛋白质(Protein) g
      phe REAL DEFAULT NULL, -- 苯丙氨酸 mg
      fat_g TEXT DEFAULT NULL, -- 脂肪(Fat) g
      cholesterol_mg TEXT DEFAULT NULL, -- 胆固醇(Cholesterol) mg
      ash_g TEXT DEFAULT NULL, -- 灰分(Ash) g
      cho_g TEXT DEFAULT NULL, -- 碳水化合物(CHO) g
      dietary_fiber_g TEXT DEFAULT NULL, -- 总膳食纤维(Dietary fiber) g
      carotene_μg TEXT DEFAULT NULL, -- 胡萝卜素(Carotene) μg
      alpha_te_ TEXT DEFAULT NULL, -- α-TE
      thiamin_mg TEXT DEFAULT NULL, -- 硫胺素(Thiamin) mg
      riboflavin_mg TEXT DEFAULT NULL, -- 核黄素(Riboflavin) mg
      niacin_mg TEXT DEFAULT NULL, -- 烟酸(Niacin) mg
      vitamin_a TEXT DEFAULT NULL, -- 维生素A(Vitamin A)_μg
      vitamin_c TEXT DEFAULT NULL, -- 维生素C(Vitamin C)_mg
      vitamin_e1 TEXT DEFAULT NULL, -- 维生素E1
      vitamin_e2 TEXT DEFAULT NULL, -- 维生素E2
      vitamin_e3 TEXT DEFAULT NULL, -- 维生素E3
      vitamin_e_total TEXT DEFAULT NULL, -- 维生素E总量
      ca_mg TEXT DEFAULT NULL, -- 钙(Ca) mg
      p_mg TEXT DEFAULT NULL, -- 磷(P) mg
      k_mg TEXT DEFAULT NULL, -- 钾(K) mg
      na_mg TEXT DEFAULT NULL, -- 钠(Na) mg
      mg_mg TEXT DEFAULT NULL, -- 镁(Mg) mg
      fe_mg TEXT DEFAULT NULL, -- 铁(Fe) mg
      zn_mg TEXT DEFAULT NULL, -- 锌(Zn) mg
      se_μg TEXT DEFAULT NULL, -- 硒(Se) μg
      cu_mg TEXT DEFAULT NULL, -- 铜(Cu) mg
      mn_mg TEXT DEFAULT NULL, -- 锰(Mn) mg
      i TEXT DEFAULT NULL, -- 碘(I)
      sfa TEXT DEFAULT NULL, -- 饱和脂肪酸(SFA)
      mufa TEXT DEFAULT NULL, -- 单不饱和脂肪酸(MUFA)
      pufa TEXT DEFAULT NULL, -- 多不饱和脂肪酸(PUFA)
      total TEXT DEFAULT NULL, -- 合计(Total)
      retinol TEXT DEFAULT NULL, -- 视黄醇(Retinol)
      food_code TEXT DEFAULT NULL, -- 食物代码
      remark TEXT DEFAULT NULL -- 备注
    )
  ''');
    // 从 assets 中读取 SQL 文件并执行
    await _importSQLData(db);
  }

  // 从 SQL 文件导入数据
  Future<void> _importSQLData(Database db) async {
    // 从 assets 目录读取 SQL 文件内容
    String sql = await rootBundle.loadString('assets/sql/food_nutrition.sql');
    // 使用事务执行多个 SQL 语句
    await db.transaction((txn) async {
      // 通过分号 (;) 分割多条 SQL 语句
      List<String> sqlStatements = sql.split(';');
      for (var statement in sqlStatements) {
        if (statement.trim().isNotEmpty) {
          // 执行 SQL 语句
          await txn.execute(statement.trim());
          logger.i("执行sql ${statement.trim()}");
        }
      }
    });
  }
}
