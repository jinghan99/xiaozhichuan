import 'my_dio.dart';

const String yingshiRankingU = 'https://biz.quark.cn/api/trending/ranking/getYingshiRanking'; // 影视排行榜 夸克热搜


//影视排行榜
Future yingshiRanking(data, SCallBack sCallBack) async {
  await MyDio().requestDio('get', yingshiRankingU, data, sCallBack, (error) {});
}
//api vod 接口
Future apiVod(String url,data, SCallBack sCallBack) async {
  await MyDio().requestDio('get', url, data, sCallBack, (error) {});
}

