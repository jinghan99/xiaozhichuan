
import 'extensions_exp.dart';

export '/tools/m_colors.dart';
export 'package:flutter/material.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export '/http/my_dio.dart';
export 'package:get/get.dart';
export 'package:flutter_easyloading/flutter_easyloading.dart';
export 'package:flutter_scaffold/colors/stf_colors.dart';
export 'package:flutter_scaffold/tools/pattern.dart';


/// 添加单击事件的扩展
extension WidgetTapX on Widget {
  Widget onTap(VoidCallback onTapCallback) {
    return GestureDetector(
      onTap: onTapCallback,
      child: this,
    );
  }
}

// appbar
AppBar buildAppBar(String title) {
  return AppBar(
    leading: Container(
      padding: EdgeInsets.only(left: 10),
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        color: c7BBD9C,
        onPressed: () {
          Get.back();
        },
      ),
    ),
    backgroundColor: cEAF5EF,
    title: Container(
      width: 1.sw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: gr16b,
          ).paddingOnly(bottom: 5),
        ],
      ),
    ),
  );
}
