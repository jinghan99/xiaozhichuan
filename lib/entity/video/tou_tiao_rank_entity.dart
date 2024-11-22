class ToutiaoRankeEntity {
  int? status;
  String? code;
  String? msg;
  Data? data;

  ToutiaoRankeEntity({this.status, this.code, this.msg, this.data});

  ToutiaoRankeEntity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Hits? hits;

  Data({this.hits});

  Data.fromJson(Map<String, dynamic> json) {
    hits = json['hits'] != null ? Hits.fromJson(json['hits']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hits != null) {
      data['hits'] = hits!.toJson();
    }
    return data;
  }
}

class Hits {
  Hit? hit;
  String? numhits;
  String? totalhits;

  Hits({this.hit, this.numhits, this.totalhits});

  Hits.fromJson(Map<String, dynamic> json) {
    hit = json['hit'] != null ? Hit.fromJson(json['hit']) : null;
    numhits = json['numhits'];
    totalhits = json['totalhits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (hit != null) {
      data['hit'] = hit!.toJson();
    }
    data['numhits'] = numhits;
    data['totalhits'] = totalhits;
    return data;
  }
}

class Hit {
  WisdomExtInfo? wisdomExtInfo;
  List<Item>? item;
  String? scLayout;
  String? wisdomHy;
  String? wisdomSc;
  String? makeUpPriority;
  String? scStype;
  Filter? filter;
  String? bucket;
  String? pOSITION;
  String? wisdomModule;
  String? makeUpPos;
  String? templateId;
  String? diluPath;
  String? status;

  Hit(
      {this.wisdomExtInfo,
      this.item,
      this.scLayout,
      this.wisdomHy,
      this.wisdomSc,
      this.makeUpPriority,
      this.scStype,
      this.filter,
      this.bucket,
      this.pOSITION,
      this.wisdomModule,
      this.makeUpPos,
      this.templateId,
      this.diluPath,
      this.status});

  Hit.fromJson(Map<String, dynamic> json) {
    wisdomExtInfo = json['wisdom_ext_info'] != null
        ? WisdomExtInfo.fromJson(json['wisdom_ext_info'])
        : null;
    if (json['item'] != null) {
      item = <Item>[];
      json['item'].forEach((v) {
        item!.add(Item.fromJson(v));
      });
    }
    scLayout = json['sc_layout'];
    wisdomHy = json['wisdom_hy'];
    wisdomSc = json['wisdom_sc'];
    makeUpPriority = json['MakeUpPriority'];
    scStype = json['sc_stype'];
    filter =
        json['filter'] != null ? Filter.fromJson(json['filter']) : null;
    bucket = json['bucket'];
    pOSITION = json['POSITION'];
    wisdomModule = json['wisdom_module'];
    makeUpPos = json['MakeUpPos'];
    templateId = json['template_id'];
    diluPath = json['dilu_path'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (wisdomExtInfo != null) {
      data['wisdom_ext_info'] = wisdomExtInfo!.toJson();
    }
    if (item != null) {
      data['item'] = item!.map((v) => v.toJson()).toList();
    }
    data['sc_layout'] = scLayout;
    data['wisdom_hy'] = wisdomHy;
    data['wisdom_sc'] = wisdomSc;
    data['MakeUpPriority'] = makeUpPriority;
    data['sc_stype'] = scStype;
    if (filter != null) {
      data['filter'] = filter!.toJson();
    }
    data['bucket'] = bucket;
    data['POSITION'] = pOSITION;
    data['wisdom_module'] = wisdomModule;
    data['MakeUpPos'] = makeUpPos;
    data['template_id'] = templateId;
    data['dilu_path'] = diluPath;
    data['status'] = status;
    return data;
  }
}

class WisdomExtInfo {
  String? triggerType;
  TriggerDetail? triggerDetail;

  WisdomExtInfo({this.triggerType, this.triggerDetail});

  WisdomExtInfo.fromJson(Map<String, dynamic> json) {
    triggerType = json['trigger_type'];
    triggerDetail = json['trigger_detail'] != null
        ? TriggerDetail.fromJson(json['trigger_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trigger_type'] = triggerType;
    if (triggerDetail != null) {
      data['trigger_detail'] = triggerDetail!.toJson();
    }
    return data;
  }
}

class TriggerDetail {
  String? triggerDict;
  String? triggerEntity;
  String? triggerModuleId;

  TriggerDetail({this.triggerDict, this.triggerEntity, this.triggerModuleId});

  TriggerDetail.fromJson(Map<String, dynamic> json) {
    triggerDict = json['trigger_dict'];
    triggerEntity = json['trigger_entity'];
    triggerModuleId = json['trigger_module_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trigger_dict'] = triggerDict;
    data['trigger_entity'] = triggerEntity;
    data['trigger_module_id'] = triggerModuleId;
    return data;
  }
}

class Item {
  String? area;
  String? hotScore;
  String? color;
  String? src;
  String? year;
  String? channel;
  String? title;
  String? scoreAvg;
  String? lastHotScore;
  String? pubDate;
  String? actors;
  String? ranking;
  String? text;
  String? category;
  String? hotTrend;
  String? desc;

  Item(
      {this.area,
      this.hotScore,
      this.color,
      this.src,
      this.year,
      this.channel,
      this.title,
      this.scoreAvg,
      this.lastHotScore,
      this.pubDate,
      this.actors,
      this.ranking,
      this.text,
      this.category,
      this.hotTrend,
      this.desc});

  Item.fromJson(Map<String, dynamic> json) {
    area = json['area'];
    hotScore = json['hot_score'];
    color = json['color'];
    src = json['src'];
    year = json['year'];
    channel = json['channel'];
    title = json['title'];
    scoreAvg = json['score_avg'];
    lastHotScore = json['last_hot_score'];
    pubDate = json['pub_date'];
    actors = json['actors'];
    ranking = json['ranking'];
    text = json['text'];
    category = json['category'];
    hotTrend = json['hot_trend'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area'] = area;
    data['hot_score'] = hotScore;
    data['color'] = color;
    data['src'] = src;
    data['year'] = year;
    data['channel'] = channel;
    data['title'] = title;
    data['score_avg'] = scoreAvg;
    data['last_hot_score'] = lastHotScore;
    data['pub_date'] = pubDate;
    data['actors'] = actors;
    data['ranking'] = ranking;
    data['text'] = text;
    data['category'] = category;
    data['hot_trend'] = hotTrend;
    data['desc'] = desc;
    return data;
  }
}

class Filter {
  Categorys? categorys;
  Ranks? ranks;
  Areas? areas;

  Filter({this.categorys, this.ranks, this.areas});

  Filter.fromJson(Map<String, dynamic> json) {
    categorys = json['categorys'] != null
        ? Categorys.fromJson(json['categorys'])
        : null;
    ranks = json['ranks'] != null ? Ranks.fromJson(json['ranks']) : null;
    areas = json['areas'] != null ? Areas.fromJson(json['areas']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categorys != null) {
      data['categorys'] = categorys!.toJson();
    }
    if (ranks != null) {
      data['ranks'] = ranks!.toJson();
    }
    if (areas != null) {
      data['areas'] = areas!.toJson();
    }
    return data;
  }
}

class Categorys {
  List<Category>? category;

  Categorys({this.category});

  Categorys.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != null) {
      data['category'] = category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? name;
  String? active;

  Category({this.name, this.active});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['active'] = active;
    return data;
  }
}

class Rank {
  String? name;
  String? active;

  Rank({this.name, this.active});

  Rank.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['active'] = active;
    return data;
  }
}

class Area {
  String? name;
  String? active;

  Area({this.name, this.active});

  Area.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['active'] = active;
    return data;
  }
}

class Ranks {
  List<Rank>? rank;

  Ranks({this.rank});

  Ranks.fromJson(Map<String, dynamic> json) {
    if (json['rank'] != null) {
      rank = <Rank>[];
      json['rank'].forEach((v) {
        rank!.add(Rank.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (rank != null) {
      data['rank'] = rank!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Areas {
  List<Area>? area;

  Areas({this.area});

  Areas.fromJson(Map<String, dynamic> json) {
    if (json['area'] != null) {
      area = <Area>[];
      json['area'].forEach((v) {
        area!.add(Area.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (area != null) {
      data['area'] = area!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
