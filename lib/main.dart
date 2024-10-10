import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_scaffold/pages/loading/loading_view.dart';
import 'package:flutter_scaffold/pages/route.dart';
import 'package:flutter_scaffold/tools/m_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();//确保 Flutter 框架已初始化
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);//设置应用的屏幕方向为竖屏模式
  runApp( RefreshConfiguration(
    headerBuilder: () => const MaterialClassicHeader(
      color: c141630,
    ),
    footerBuilder: () => CustomFooter(
      loadStyle: LoadStyle.ShowWhenLoading,
      builder: (context, mode) {
        if (mode == LoadStatus.loading) {
          return const SizedBox(
            height: 60.0,
            child: SizedBox(
              height: 20.0,
              width: 20.0,
              child: CupertinoActivityIndicator(
                color: Colors.white,
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    ),
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      title: '智游飘',
      theme: ThemeData(
          useMaterial3: true,
          appBarTheme:
          const AppBarTheme(scrolledUnderElevation: 0, backgroundColor: Colors.white, centerTitle: true),
          scaffoldBackgroundColor: const Color(0xFFF5F5F5)),
      defaultTransition: Transition.fade,
      home: const LoadingPage(),
      localizationsDelegates: const [
        RefreshLocalizations.delegate,
        // GlobalMaterialLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh'),
      ],
      builder: (context, child) {
        initApp(context);
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: FlutterEasyLoading(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: GestureDetector(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }
                },
                child: child,
              ),
            ),
          ),
        );
      },
      getPages: routePage,
    ),
  ),);


}

Future<void> initApp(BuildContext context) async {
  EasyLoading.init();
  ScreenUtil.init(context, designSize: const Size(375, 667));//设计稿尺寸
}


