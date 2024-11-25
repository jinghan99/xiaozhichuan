import 'package:flutter/services.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class StringUtils {
  // 辅助函数来格式化时长
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    final seconds = duration.inSeconds % 60;
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '$minutes:${seconds.toString().padLeft(2, '0')}';
    }
  }

  static String truncateText(String text, int maxLength) {
    // 截取文本并添加省略号
    if (text.length > maxLength) {
      return '${text.substring(0, maxLength)}...';
    }
    return text;
  }
}


class AppUtils {

  static void getFullScreen() {
    // 启用屏幕常亮
    WakelockPlus.enable();
    // 设置为全屏模式，隐藏状态栏
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    // 横屏
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
  // 恢复设置（例如竖屏、显示状态栏等）
  static void getExitFullScreen() {
    WakelockPlus.disable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
}
