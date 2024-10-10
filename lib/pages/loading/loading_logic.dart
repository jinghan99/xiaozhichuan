import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_scaffold/http/my_dio.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../tools/storage_tool.dart';
import 'loading_state.dart';

class LoadingLogic extends GetxController {
  final LoadingState state = LoadingState();

  @override
  void onReady() {
    super.onReady();
    readBox();
    MyDio().initDio();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }



  void checkServer() {
    // EasyLoading.show(dismissOnTap: false);

  }

  showD() {
    Get.defaultDialog(
      barrierDismissible: false,
      onWillPop: () async {
        return false;
      },
      title: '提示',
      titlePadding: EdgeInsets.symmetric(vertical: 20.w),
      titleStyle: TextStyle(color: Colors.black, fontSize: 16.sp),
      content: Text(
        '系统正在更新中，请稍后再使用…',
        style: TextStyle(color: Colors.black, fontSize: 14.sp),
      ),
      cancel: TextButton(
        onPressed: () async {
          if (GetPlatform.isIOS) {
            exit(0);
          }
          if (GetPlatform.isAndroid) {
            await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          }
        },
        child: Text(
          '关闭',
          style: TextStyle(color: Colors.red, fontSize: 14.sp),
        ),
      ),
      confirm: TextButton(
        onPressed: () async {
          Get.back();
          checkServer();
        },
        child: Text(
          '刷新',
          style: TextStyle(color: Colors.blue, fontSize: 14.sp),
        ),
      ),
    );
  }
}
