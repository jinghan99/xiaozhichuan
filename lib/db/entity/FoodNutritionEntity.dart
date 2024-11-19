class FoodNutritionEntity {
  int? id;
  String name;
  String? edible;
  String? waterG;
  String? energyKj;
  String? energyKcal;
  double? proteinG;
  double? phe;
  String? fatG;
  String? cholesterolMg;
  String? ashG;
  String? choG;
  String? dietaryFiberG;
  String? caroteneUg;
  String? alphaTe;
  String? thiaminMg;
  String? riboflavinMg;
  String? niacinMg;
  String? vitaminA;
  String? vitaminC;
  String? vitaminE1;
  String? vitaminE2;
  String? vitaminE3;
  String? vitaminETotal;
  String? caMg;
  String? pMg;
  String? kMg;
  String? naMg;
  String? mgMg;
  String? feMg;
  String? znMg;
  String? seUg;
  String? cuMg;
  String? mnMg;
  String? iodine;
  String? sfa;
  String? mufa;
  String? pufa;
  String? total;
  String? retinol;
  String? foodCode;
  String? remark;

  FoodNutritionEntity({
    this.id,
    required this.name,
    this.edible,
    this.waterG,
    this.energyKj,
    this.energyKcal,
    this.proteinG,
    this.phe,
    this.fatG,
    this.cholesterolMg,
    this.ashG,
    this.choG,
    this.dietaryFiberG,
    this.caroteneUg,
    this.alphaTe,
    this.thiaminMg,
    this.riboflavinMg,
    this.niacinMg,
    this.vitaminA,
    this.vitaminC,
    this.vitaminE1,
    this.vitaminE2,
    this.vitaminE3,
    this.vitaminETotal,
    this.caMg,
    this.pMg,
    this.kMg,
    this.naMg,
    this.mgMg,
    this.feMg,
    this.znMg,
    this.seUg,
    this.cuMg,
    this.mnMg,
    this.iodine,
    this.sfa,
    this.mufa,
    this.pufa,
    this.total,
    this.retinol,
    this.foodCode,
    this.remark,
  });

  // 将 JSON 转为对象
  factory FoodNutritionEntity.fromJson(Map<String, dynamic> json) {
    return FoodNutritionEntity(
      id: json['id'] as int?,
      name: json['name'] as String,
      edible: json['edible'] as String?,
      waterG: json['water_g'] as String?,
      energyKj: json['energy_kj'] as String?,
      energyKcal: json['energy_kcal'] as String?,
      proteinG: (json['protein_g'] as num?)?.toDouble(),
      phe: (json['phe'] as num?)?.toDouble(),
      fatG: json['fat_g'] as String?,
      cholesterolMg: json['cholesterol_mg'] as String?,
      ashG: json['ash_g'] as String?,
      choG: json['cho_g'] as String?,
      dietaryFiberG: json['dietary_fiber_g'] as String?,
      caroteneUg: json['carotene_μg'] as String?,
      alphaTe: json['alpha_te_'] as String?,
      thiaminMg: json['thiamin_mg'] as String?,
      riboflavinMg: json['riboflavin_mg'] as String?,
      niacinMg: json['niacin_mg'] as String?,
      vitaminA: json['vitamin_a'] as String?,
      vitaminC: json['vitamin_c'] as String?,
      vitaminE1: json['vitamin_e1'] as String?,
      vitaminE2: json['vitamin_e2'] as String?,
      vitaminE3: json['vitamin_e3'] as String?,
      vitaminETotal: json['vitamin_e_total'] as String?,
      caMg: json['ca_mg'] as String?,
      pMg: json['p_mg'] as String?,
      kMg: json['k_mg'] as String?,
      naMg: json['na_mg'] as String?,
      mgMg: json['mg_mg'] as String?,
      feMg: json['fe_mg'] as String?,
      znMg: json['zn_mg'] as String?,
      seUg: json['se_μg'] as String?,
      cuMg: json['cu_mg'] as String?,
      mnMg: json['mn_mg'] as String?,
      iodine: json['i'] as String?,
      sfa: json['sfa'] as String?,
      mufa: json['mufa'] as String?,
      pufa: json['pufa'] as String?,
      total: json['total'] as String?,
      retinol: json['retinol'] as String?,
      foodCode: json['food_code'] as String?,
      remark: json['remark'] as String?,
    );
  }

  // 转为 JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'edible': edible,
      'water_g': waterG,
      'energy_kj': energyKj,
      'energy_kcal': energyKcal,
      'protein_g': proteinG,
      'phe': phe,
      'fat_g': fatG,
      'cholesterol_mg': cholesterolMg,
      'ash_g': ashG,
      'cho_g': choG,
      'dietary_fiber_g': dietaryFiberG,
      'carotene_μg': caroteneUg,
      'alpha_te_': alphaTe,
      'thiamin_mg': thiaminMg,
      'riboflavin_mg': riboflavinMg,
      'niacin_mg': niacinMg,
      'vitamin_a': vitaminA,
      'vitamin_c': vitaminC,
      'vitamin_e1': vitaminE1,
      'vitamin_e2': vitaminE2,
      'vitamin_e3': vitaminE3,
      'vitamin_e_total': vitaminETotal,
      'ca_mg': caMg,
      'p_mg': pMg,
      'k_mg': kMg,
      'na_mg': naMg,
      'mg_mg': mgMg,
      'fe_mg': feMg,
      'zn_mg': znMg,
      'se_μg': seUg,
      'cu_mg': cuMg,
      'mn_mg': mnMg,
      'i': iodine,
      'sfa': sfa,
      'mufa': mufa,
      'pufa': pufa,
      'total': total,
      'retinol': retinol,
      'food_code': foodCode,
      'remark': remark,
    };
  }

  // 将对象转换为 Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      '名称': name,
      '食部': edible,
      '水分(g)': waterG,
      '能量(KJ)': energyKj,
      '能量(Kcal)': energyKcal,
      '蛋白质(g)': proteinG,
      '苯丙氨酸(mg)': phe,
      '脂肪(g)': fatG,
      '胆固醇(mg)': cholesterolMg,
      '灰分(g)': ashG,
      '碳水化合物(g)': choG,
      '膳食纤维(g)': dietaryFiberG,
      '胡萝卜素(μg)': caroteneUg,
      'α-TE': alphaTe,
      '硫胺素(mg)': thiaminMg,
      '核黄素(mg)': riboflavinMg,
      '烟酸(mg)': niacinMg,
      '维生素A(μg)': vitaminA,
      '维生素C(mg)': vitaminC,
      '维生素E1': vitaminE1,
      '维生素E2': vitaminE2,
      '维生素E3': vitaminE3,
      '维生素E总量': vitaminETotal,
      '钙(mg)': caMg,
      '磷(mg)': pMg,
      '钾(mg)': kMg,
      '钠(mg)': naMg,
      '镁(mg)': mgMg,
      '铁(mg)': feMg,
      '锌(mg)': znMg,
      '硒(μg)': seUg,
      '铜(mg)': cuMg,
      '锰(mg)': mnMg,
      '碘(I)': iodine,
      '饱和脂肪酸(SFA)': sfa,
      '单不饱和脂肪酸(MUFA)': mufa,
      '多不饱和脂肪酸(PUFA)': pufa,
      '合计': total,
      '视黄醇': retinol,
      '食物代码': foodCode,
      '备注': remark,
    };
  }
}
