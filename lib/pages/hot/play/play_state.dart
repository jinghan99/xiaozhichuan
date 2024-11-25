import 'package:flutter_scaffold/entity/video/select_episode.dart';
import 'package:flutter_scaffold/entity/video/tou_tiao_rank_entity.dart';
import 'package:flutter_scaffold/entity/video/vodVideo.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';
import 'package:video_player/video_player.dart';

class PlayState {
  late Item item;
  var isLoading = true.obs;
  var selectedEpisodeUrl = "".obs; //选择的集数url
  Rx<TabController?> tabController = Rx<TabController?>(null); // 使用 Rx<TabController?>

  var tabs = <String>[].obs; // 存储Tab的标题
  var tabContents = <List<SelectEpisodeEntity>?>[].obs; // 用于存储Tab内容，初始时内容为null表示尚未加载

  var selectedIndex = 0.obs; // 当前选中的Tab索引

  var infoVideo = Video().obs;

  // VideoPlayer 播放器
   Rx<VideoPlayerController?> videoPlayerController = Rx<VideoPlayerController?>(null);

  final RxBool isPlaying = false.obs;
  final RxBool isFullScreen = false.obs;
  final RxDouble progress = 0.0.obs;

  PlayState() {
    // 获取传递的参数 food
    item = Get.arguments as Item;
    logger.d(item);
  }
}
