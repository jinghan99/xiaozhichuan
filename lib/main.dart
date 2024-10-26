import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_scaffold/pages/loading/loading_view.dart';
import 'package:flutter_scaffold/pages/route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'colors/stf_colors.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 确保 Flutter 框架已初始化
  await _setPreferredOrientations(); // 设置屏幕方向
  runApp(_buildApp()); // 启动应用
}

// 设置应用的屏幕方向为竖屏模式
Future<void> _setPreferredOrientations() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
}

// 构建整个应用
Widget _buildApp() {
  return RefreshConfiguration(
    headerBuilder: () => MaterialClassicHeader(
      color: c7BBD9C, // 刷新头部的颜色
    ),
    footerBuilder: () => _buildCustomFooter(), // 自定义底部
    child: GetMaterialApp(//GetX自带的MaterialApp，配置路由表，管理路由入栈、出栈等操作
      debugShowCheckedModeBanner: false, // 关闭调试模式的横幅
      initialRoute: '/', // 初始路由
      title: '一个小纸船', // 应用标题
      theme: _buildAppTheme(), // 使用分离的方法构建主题
      defaultTransition: Transition.fade, // 默认过渡动画
      home: const LoadingPage(), // 应用的主页面
      localizationsDelegates: _buildLocalizationDelegates(), // 使用分离的方法构建本地化委托
      supportedLocales: const [
        Locale('zh'), // 支持的语言
      ],
      builder: (context, child) {
        _initApp(context); // 初始化应用
        return _buildMediaQuery(context,child); // 使用分离的方法构建 MediaQuery
      },
      getPages: routePage, // 路由配置
    ),
  );
}

// 构建应用主题
ThemeData _buildAppTheme() {
  return ThemeData(
    useMaterial3: true, // 使用 Material 3 风格
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0, // 滚动时的阴影高度
      backgroundColor: Colors.white, // AppBar 背景颜色
      centerTitle: true, // 标题居中
    ),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5), // Scaffold 背景颜色
  );
}

// 构建自定义底部组件
Widget _buildCustomFooter() {
  return CustomFooter(
    loadStyle: LoadStyle.ShowWhenLoading, // 加载时显示样式
    builder: (context, mode) {
      if (mode == LoadStatus.loading) {
        return const SizedBox(
          height: 60.0,
          child: SizedBox(
            height: 20.0,
            width: 20.0,
            child: CupertinoActivityIndicator(
              color: Colors.white, // 加载指示器颜色
            ),
          ),
        );
      } else {
        return Container(); // 非加载状态返回空容器
      }
    },
  );
}

// 构建本地化委托
List<LocalizationsDelegate<dynamic>> _buildLocalizationDelegates() {
  return const [
    RefreshLocalizations.delegate, // 下拉刷新本地化
    GlobalMaterialLocalizations.delegate, // Material 组件本地化
    GlobalCupertinoLocalizations.delegate, // iOS 组件本地化
    GlobalWidgetsLocalizations.delegate, // Widget 本地化
  ];
}

// 初始化应用的异步方法
Future<void> _initApp(BuildContext context) async {
  EasyLoading.init(); // 初始化 EasyLoading
  ScreenUtil.init(context, designSize: const Size(375, 667)); // 设计稿尺寸
}

// 构建 MediaQuery
Widget _buildMediaQuery(BuildContext context,Widget? child) {
  return MediaQuery(
    data: MediaQuery.of(context)
        .copyWith(textScaler: const TextScaler.linear(1.0)), // 设置文本缩放比例
    child: FlutterEasyLoading(
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 不因键盘弹出而调整页面
        body: GestureDetector(
          // 点击空白区域时隐藏键盘
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
              FocusManager.instance.primaryFocus?.unfocus(); // 隐藏键盘
            }
          },
          child: child, // 子组件
        ),
      ),
    ),
  );
}
