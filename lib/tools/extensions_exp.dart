
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
