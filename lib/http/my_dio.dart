
import 'package:dio/dio.dart' as d;
export 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import '../tools/extensions_exp.dart';


//http请求成功回调
typedef SCallBack<T> = void Function(d.Response response, bool hasError);

//失败回调
typedef FCallBack = void Function(d.DioException error);

final logger = Logger(
    printer: PrettyPrinter(
      printEmojis: false,
    ),
    level: Level.debug);

class MyDio {
  MyDio._internal();

  static final MyDio _singleton = MyDio._internal();

  factory MyDio() => _singleton;

  d.Dio? dio;

  initDio() {
    var headers = {
      'user-agent': 'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Mobile Safari/537.36'
    };
    d.BaseOptions options = d.BaseOptions(
      headers: headers,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 60),
    );
    dio = d.Dio(options);
    // dio!.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
    //   final client = HttpClient();
    //   client.findProxy = (uri) {
    //     return 'PROXY 192.168.1.239:8118';
    //   };
    //   return client;
    // });
  }

  requestDio(String way, String url, data, SCallBack sCallBack, FCallBack fCallBack,
      {bool needToken = true, bool showLog = false, d.CancelToken? cancelToken}) async {
    await ask(way, url, data, sCallBack, fCallBack, needToken: needToken, showLog: showLog, cancelToken: cancelToken);

  }

  post(String url, data, SCallBack sCallBack, FCallBack fCallBack,
      {bool needToken = true, bool showLog = false, d.CancelToken? cancelToken}) async {
    // DateTime ntpNow = DateTime.now();
    // Map<String, dynamic> dd = {'client_id': getRandomString(2) + ntpNow.millisecondsSinceEpoch.toString()};
    // if (data.values.isNotEmpty) {
    //   dd.addAll(data);
    // }
    // String s = amapMM(data);
    // String rs = '';
    // Map<String, dynamic> queryParameters = {};
    // if (needToken) {
    //   queryParameters['token'] = MyCookie().token.value;
    // }
    try {
      if (showLog) {
        logger.d('POST\n${ url}\n$data');
      }

      d.Response re = await dio!.post(url, data: data, cancelToken: cancelToken);
      if (re.data is String) {


      }
      if (showLog) {
        logger.d('POST\n${ url}\n$data');
        logger.d(re.data);
      }
      {}
    } on d.DioException catch (e) {
      showDioE(e, fCallBack, url: url);
    }
  }

  put(String url, data, SCallBack sCallBack, FCallBack fCallBack, {bool needToken = true, bool showLog = false}) async {

    try {
      if (showLog) {
        logger.d('POST\n${ url}\n$data');
      }
      d.Response re;

      re = await dio!.put(url, data: data);

      if (showLog) {
        logger.d('POST\n${ url}\n$data');
        logger.d(re.data);
      }
      {}
    } on d.DioException catch (e) {
      showDioE(e, fCallBack);
    }
  }

  get(String url, data, SCallBack sCallBack, FCallBack fCallBack,
      {bool needToken = true, bool showLog = false, d.CancelToken? cancelToken}) async {
    // DateTime ntpNow = DateTime.now();
    String rs = '';
    if (showLog) {
      logger.d('GET\n${  url}\n$data');
    }
    try {
      d.Response re;
      // String s = amapMM({'sKey': aMapIoSKey, 'time': ntpNow.millisecondsSinceEpoch});
      if (data == null) {
        re = await dio!.get(url, cancelToken: cancelToken);
      } else {
        re = await dio!.get(url, queryParameters: data!, cancelToken: cancelToken);
      }

      if (showLog) {
        logger.d('GET\n${url}\n$data\n$rs\n${re.data.toString()}');
      }
       {}
    } on d.DioException catch (e) {
      showDioE(e, fCallBack, url: url);
    }
  }

  void showDioE(d.DioException e, FCallBack fCallBack, {String? url}) {
    switch (e.type) {
      case d.DioExceptionType.connectionTimeout:
        fCallBack(e);
        EasyLoading.showToast('连接超时');
        break;
      case d.DioExceptionType.sendTimeout:
        fCallBack(e);
        EasyLoading.showToast('链接超时');
        break;
      case d.DioExceptionType.receiveTimeout:
        fCallBack(e);
        EasyLoading.showToast('接收超时');
        break;
      case d.DioExceptionType.badCertificate:
        fCallBack(e);
        EasyLoading.showToast('证书失效');
        break;
      case d.DioExceptionType.badResponse:
        fCallBack(e);
        EasyLoading.showToast('服务器异常');
        break;
      case d.DioExceptionType.cancel:
        fCallBack(e);
        EasyLoading.showToast('请求取消');
        break;
      case d.DioExceptionType.connectionError:
        fCallBack(e);
        EasyLoading.showToast('连接错误');
        break;
      default:
        fCallBack(e);
        EasyLoading.showToast('请求取消');
    }
  }

  Future<void> ask(String way, String url, data, SCallBack sCallBack, FCallBack fCallBack,
      {bool needToken = true, bool showLog = false, d.CancelToken? cancelToken}) async {
    switch (way) {
      case 'post':
        await post(url, data, sCallBack, fCallBack, needToken: needToken, showLog: showLog, cancelToken: cancelToken);
        break;
      case 'put':
        await put(url, data, sCallBack, fCallBack, needToken: needToken, showLog: showLog);
        break;
      case 'get':
        await get(url, data, sCallBack, fCallBack, needToken: needToken, showLog: showLog, cancelToken: cancelToken);
        break;
      default:
        break;
    }
  }
}
