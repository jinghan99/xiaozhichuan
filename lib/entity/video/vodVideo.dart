class VodVideoList {
  int? code;
  String? msg;
  String? page;
  int? pagecount;
  String? limit;
  int? total;
  List<Video>? list;

  VodVideoList(
      {this.code,
      this.msg,
      this.page,
      this.pagecount,
      this.limit,
      this.total,
      this.list});

  VodVideoList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    page = json['page'];
    pagecount = json['pagecount'];
    limit = json['limit'];
    total = json['total'];
    if (json['list'] != null) {
      list = <Video>[];
      json['list'].forEach((v) {
        list!.add(Video.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['msg'] = msg;
    data['page'] = page;
    data['pagecount'] = pagecount;
    data['limit'] = limit;
    data['total'] = total;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Video {
  int? vodId; // 视频ID
  int? typeId; // 类型ID
  int? typeId1; // 副类型ID
  int? groupId; // 分组ID
  String? vodName; // 视频名称
  String? vodSub; // 视频副标题
  String? vodEn; // 视频英文名
  int? vodStatus; // 视频状态
  String? vodLetter; // 视频首字母
  String? vodColor; // 视频标题颜色
  String? vodTag; // 视频标签
  String? vodClass; // 视频分类
  String? vodPic; // 视频主图
  String? vodPicThumb; // 视频缩略图
  String? vodPicSlide; // 视频幻灯片图
  String? vodPicScreenshot; // 视频截图
  String? vodActor; // 视频演员
  String? vodDirector; // 视频导演
  String? vodWriter; // 视频编剧
  String? vodBehind; // 视频幕后
  String? vodBlurb; // 视频简介
  String? vodRemarks; // 视频备注
  String? vodPubdate; // 视频发布日期
  int? vodTotal; // 视频总集数
  String? vodSerial; // 视频连载信息
  String? vodTv; // 电视台
  String? vodWeekday; // 更新周期/星期几更新
  String? vodArea; // 视频地区
  String? vodLang; // 视频语言
  String? vodYear; // 视频年份
  String? vodVersion; // 视频版本
  String? vodState; // 视频状态
  String? vodAuthor; // 视频作者
  String? vodJumpurl; // 视频跳转地址
  String? vodTpl; // 视频模板
  String? vodTplPlay; // 播放模板
  String? vodTplDown; // 下载模板
  int? vodIsend; // 是否完结
  int? vodLock; // 是否锁定
  int? vodLevel; // 视频级别
  int? vodCopyright; // 版权信息
  int? vodPoints; // 积分
  int? vodPointsPlay; // 播放所需积分
  int? vodPointsDown; // 下载所需积分
  int? vodHits; // 总点击量
  int? vodHitsDay; // 日点击量
  int? vodHitsWeek; // 周点击量
  int? vodHitsMonth; // 月点击量
  String? vodDuration; // 视频时长
  int? vodUp; // 顶的次数
  int? vodDown; // 踩的次数
  String? vodScore; // 视频评分
  int? vodScoreAll; // 总评分
  int? vodScoreNum; // 评分人数
  String? vodTime; // 更新时间
  int? vodTimeAdd; // 添加时间
  int? vodTimeHits; // 点击时间
  int? vodTimeMake; // 制作时间
  int? vodTrysee; // 试看时长
  int? vodDoubanId; // 豆瓣ID
  String? vodDoubanScore; // 豆瓣评分
  String? vodReurl; // 关联URL
  String? vodRelVod; // 关联视频
  String? vodRelArt; // 关联文章
  String? vodPwd; // 密码
  String? vodPwdUrl; // 密码URL
  String? vodPwdPlay; // 播放密码
  String? vodPwdPlayUrl; // 播放密码URL
  String? vodPwdDown; // 下载密码
  String? vodPwdDownUrl; // 下载密码URL
  String? vodContent; // 视频内容
  String? vodPlayFrom; // 播放来源
  String? vodPlayServer; // 播放服务器
  String? vodPlayNote; // 播放说明
  String? vodPlayUrl; // 播放地址
  String? vodDownFrom; // 下载来源
  String? vodDownServer; // 下载服务器
  String? vodDownNote; // 下载说明
  String? vodDownUrl; // 下载地址
  int? vodPlot; // 是否有剧情
  String? vodPlotName; // 剧情名称
  String? vodPlotDetail; // 剧情详情
  String? typeName; // 类型名称

  Video(
      {this.vodId,
      this.typeId,
      this.typeId1,
      this.groupId,
      this.vodName,
      this.vodSub,
      this.vodEn,
      this.vodStatus,
      this.vodLetter,
      this.vodColor,
      this.vodTag,
      this.vodClass,
      this.vodPic,
      this.vodPicThumb,
      this.vodPicSlide,
      this.vodPicScreenshot,
      this.vodActor,
      this.vodDirector,
      this.vodWriter,
      this.vodBehind,
      this.vodBlurb,
      this.vodRemarks,
      this.vodPubdate,
      this.vodTotal,
      this.vodSerial,
      this.vodTv,
      this.vodWeekday,
      this.vodArea,
      this.vodLang,
      this.vodYear,
      this.vodVersion,
      this.vodState,
      this.vodAuthor,
      this.vodJumpurl,
      this.vodTpl,
      this.vodTplPlay,
      this.vodTplDown,
      this.vodIsend,
      this.vodLock,
      this.vodLevel,
      this.vodCopyright,
      this.vodPoints,
      this.vodPointsPlay,
      this.vodPointsDown,
      this.vodHits,
      this.vodHitsDay,
      this.vodHitsWeek,
      this.vodHitsMonth,
      this.vodDuration,
      this.vodUp,
      this.vodDown,
      this.vodScore,
      this.vodScoreAll,
      this.vodScoreNum,
      this.vodTime,
      this.vodTimeAdd,
      this.vodTimeHits,
      this.vodTimeMake,
      this.vodTrysee,
      this.vodDoubanId,
      this.vodDoubanScore,
      this.vodReurl,
      this.vodRelVod,
      this.vodRelArt,
      this.vodPwd,
      this.vodPwdUrl,
      this.vodPwdPlay,
      this.vodPwdPlayUrl,
      this.vodPwdDown,
      this.vodPwdDownUrl,
      this.vodContent,
      this.vodPlayFrom,
      this.vodPlayServer,
      this.vodPlayNote,
      this.vodPlayUrl,
      this.vodDownFrom,
      this.vodDownServer,
      this.vodDownNote,
      this.vodDownUrl,
      this.vodPlot,
      this.vodPlotName,
      this.vodPlotDetail,
      this.typeName});

  Video.fromJson(Map<String, dynamic> json) {
    vodId = json['vod_id'];
    typeId = json['type_id'];
    typeId1 = json['type_id_1'];
    groupId = json['group_id'];
    vodName = json['vod_name'];
    vodSub = json['vod_sub'];
    vodEn = json['vod_en'];
    vodStatus = json['vod_status'];
    vodLetter = json['vod_letter'];
    vodColor = json['vod_color'];
    vodTag = json['vod_tag'];
    vodClass = json['vod_class'];
    vodPic = json['vod_pic'];
    vodPicThumb = json['vod_pic_thumb'];
    vodPicSlide = json['vod_pic_slide'];
    vodPicScreenshot = json['vod_pic_screenshot'];
    vodActor = json['vod_actor'];
    vodDirector = json['vod_director'];
    vodWriter = json['vod_writer'];
    vodBehind = json['vod_behind'];
    vodBlurb = json['vod_blurb'];
    vodRemarks = json['vod_remarks'];
    vodPubdate = json['vod_pubdate'];
    vodTotal = json['vod_total'];
    vodSerial = json['vod_serial'];
    vodTv = json['vod_tv'];
    vodWeekday = json['vod_weekday'];
    vodArea = json['vod_area'];
    vodLang = json['vod_lang'];
    vodYear = json['vod_year'];
    vodVersion = json['vod_version'];
    vodState = json['vod_state'];
    vodAuthor = json['vod_author'];
    vodJumpurl = json['vod_jumpurl'];
    vodTpl = json['vod_tpl'];
    vodTplPlay = json['vod_tpl_play'];
    vodTplDown = json['vod_tpl_down'];
    vodIsend = json['vod_isend'];
    vodLock = json['vod_lock'];
    vodLevel = json['vod_level'];
    vodCopyright = json['vod_copyright'];
    vodPoints = json['vod_points'];
    vodPointsPlay = json['vod_points_play'];
    vodPointsDown = json['vod_points_down'];
    vodHits = json['vod_hits'];
    vodHitsDay = json['vod_hits_day'];
    vodHitsWeek = json['vod_hits_week'];
    vodHitsMonth = json['vod_hits_month'];
    vodDuration = json['vod_duration'];
    vodUp = json['vod_up'];
    vodDown = json['vod_down'];
    vodScore = json['vod_score'];
    vodScoreAll = json['vod_score_all'];
    vodScoreNum = json['vod_score_num'];
    vodTime = json['vod_time'];
    vodTimeAdd = json['vod_time_add'];
    vodTimeHits = json['vod_time_hits'];
    vodTimeMake = json['vod_time_make'];
    vodTrysee = json['vod_trysee'];
    vodDoubanId = json['vod_douban_id'];
    vodDoubanScore = json['vod_douban_score'];
    vodReurl = json['vod_reurl'];
    vodRelVod = json['vod_rel_vod'];
    vodRelArt = json['vod_rel_art'];
    vodPwd = json['vod_pwd'];
    vodPwdUrl = json['vod_pwd_url'];
    vodPwdPlay = json['vod_pwd_play'];
    vodPwdPlayUrl = json['vod_pwd_play_url'];
    vodPwdDown = json['vod_pwd_down'];
    vodPwdDownUrl = json['vod_pwd_down_url'];
    vodContent = json['vod_content'];
    vodPlayFrom = json['vod_play_from'];
    vodPlayServer = json['vod_play_server'];
    vodPlayNote = json['vod_play_note'];
    vodPlayUrl = json['vod_play_url'];
    vodDownFrom = json['vod_down_from'];
    vodDownServer = json['vod_down_server'];
    vodDownNote = json['vod_down_note'];
    vodDownUrl = json['vod_down_url'];
    vodPlot = json['vod_plot'];
    vodPlotName = json['vod_plot_name'];
    vodPlotDetail = json['vod_plot_detail'];
    typeName = json['type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vod_id'] = vodId;
    data['type_id'] = typeId;
    data['type_id_1'] = typeId1;
    data['group_id'] = groupId;
    data['vod_name'] = vodName;
    data['vod_sub'] = vodSub;
    data['vod_en'] = vodEn;
    data['vod_status'] = vodStatus;
    data['vod_letter'] = vodLetter;
    data['vod_color'] = vodColor;
    data['vod_tag'] = vodTag;
    data['vod_class'] = vodClass;
    data['vod_pic'] = vodPic;
    data['vod_pic_thumb'] = vodPicThumb;
    data['vod_pic_slide'] = vodPicSlide;
    data['vod_pic_screenshot'] = vodPicScreenshot;
    data['vod_actor'] = vodActor;
    data['vod_director'] = vodDirector;
    data['vod_writer'] = vodWriter;
    data['vod_behind'] = vodBehind;
    data['vod_blurb'] = vodBlurb;
    data['vod_remarks'] = vodRemarks;
    data['vod_pubdate'] = vodPubdate;
    data['vod_total'] = vodTotal;
    data['vod_serial'] = vodSerial;
    data['vod_tv'] = vodTv;
    data['vod_weekday'] = vodWeekday;
    data['vod_area'] = vodArea;
    data['vod_lang'] = vodLang;
    data['vod_year'] = vodYear;
    data['vod_version'] = vodVersion;
    data['vod_state'] = vodState;
    data['vod_author'] = vodAuthor;
    data['vod_jumpurl'] = vodJumpurl;
    data['vod_tpl'] = vodTpl;
    data['vod_tpl_play'] = vodTplPlay;
    data['vod_tpl_down'] = vodTplDown;
    data['vod_isend'] = vodIsend;
    data['vod_lock'] = vodLock;
    data['vod_level'] = vodLevel;
    data['vod_copyright'] = vodCopyright;
    data['vod_points'] = vodPoints;
    data['vod_points_play'] = vodPointsPlay;
    data['vod_points_down'] = vodPointsDown;
    data['vod_hits'] = vodHits;
    data['vod_hits_day'] = vodHitsDay;
    data['vod_hits_week'] = vodHitsWeek;
    data['vod_hits_month'] = vodHitsMonth;
    data['vod_duration'] = vodDuration;
    data['vod_up'] = vodUp;
    data['vod_down'] = vodDown;
    data['vod_score'] = vodScore;
    data['vod_score_all'] = vodScoreAll;
    data['vod_score_num'] = vodScoreNum;
    data['vod_time'] = vodTime;
    data['vod_time_add'] = vodTimeAdd;
    data['vod_time_hits'] = vodTimeHits;
    data['vod_time_make'] = vodTimeMake;
    data['vod_trysee'] = vodTrysee;
    data['vod_douban_id'] = vodDoubanId;
    data['vod_douban_score'] = vodDoubanScore;
    data['vod_reurl'] = vodReurl;
    data['vod_rel_vod'] = vodRelVod;
    data['vod_rel_art'] = vodRelArt;
    data['vod_pwd'] = vodPwd;
    data['vod_pwd_url'] = vodPwdUrl;
    data['vod_pwd_play'] = vodPwdPlay;
    data['vod_pwd_play_url'] = vodPwdPlayUrl;
    data['vod_pwd_down'] = vodPwdDown;
    data['vod_pwd_down_url'] = vodPwdDownUrl;
    data['vod_content'] = vodContent;
    data['vod_play_from'] = vodPlayFrom;
    data['vod_play_server'] = vodPlayServer;
    data['vod_play_note'] = vodPlayNote;
    data['vod_play_url'] = vodPlayUrl;
    data['vod_down_from'] = vodDownFrom;
    data['vod_down_server'] = vodDownServer;
    data['vod_down_note'] = vodDownNote;
    data['vod_down_url'] = vodDownUrl;
    data['vod_plot'] = vodPlot;
    data['vod_plot_name'] = vodPlotName;
    data['vod_plot_detail'] = vodPlotDetail;
    data['type_name'] = typeName;
    return data;
  }
}
