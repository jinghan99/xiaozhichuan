import 'package:flutter_scaffold/entity/video/tou_tiao_rank_entity.dart';
import 'package:flutter_scaffold/pages/hot/play/play_logic.dart';
import 'package:flutter_scaffold/pages/hot/play/play_state.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PlayPage extends StatelessWidget {
  const PlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayLogic logic = Get.put(PlayLogic());
    final PlayState state = Get.find<PlayLogic>().state;
    return Scaffold(
      appBar: buildAppBar(state),
      body: Column(
        children: [

        ],
      ),
    );
  }

  AppBar buildAppBar(PlayState state) {
    return AppBar(
      backgroundColor: cEAF5EF,
      title: Container(
        width: 1.sw,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${state.item.title}",
              style: gr16b,
            ).paddingOnly(bottom: 8),
          ],
        ),
      ),
      actions: [
        Container(
          padding: EdgeInsets.only(right: 10),
          child: IconButton(
            icon: Icon(Icons.search),
            color: Colors.black,
            onPressed: () {},
          ),
        ),
      ],
    );
  }

}
