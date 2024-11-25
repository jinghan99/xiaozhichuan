import 'extensions_exp.dart';

export 'package:flutter/material.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export '/http/my_dio.dart';
export 'package:get/get.dart';
export 'package:flutter_easyloading/flutter_easyloading.dart';
export 'package:flutter_scaffold/colors/stf_colors.dart';
export 'package:flutter_scaffold/tools/pattern.dart';
export 'package:flutter_scaffold/tools/img_utils.dart';
export 'package:flutter_scaffold/tools/utils.dart';

/// 添加单击事件的扩展
extension WidgetTapX on Widget {

  Widget onTap(VoidCallback onTapCallback) {
    return GestureDetector(
      onTap: onTapCallback,
      child: this,
    );
  }

  // 双击事件
  Widget onDoubleTap(VoidCallback onDoubleTapCallback) {
    return GestureDetector(
      onDoubleTap: onDoubleTapCallback,
      child: this,
    );
  }
}

// appbar
AppBar buildAppBar(
  String title, {
  Color color = const Color(0xffE5F2EB),
  TextStyle textStyle = const TextStyle(
    color: Color(0xFF7BBD9C), //
    fontSize: 16, // 使用常量字体大小
    fontWeight: FontWeight.bold,
  ), //cE5F2EB
  Color backColor = const Color(0xFF7BBD9C),
}) {
  return AppBar(
    leading: Container(
      padding: EdgeInsets.only(left: 10),
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        color: backColor,
        onPressed: () {
          Get.back();
        },
      ),
    ),
    backgroundColor: color,
    title: Container(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: textStyle,
          ).paddingOnly(bottom: 5),
        ],
      ),
    ),
  );
}

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}
