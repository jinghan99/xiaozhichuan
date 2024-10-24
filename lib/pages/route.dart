import 'package:flutter_scaffold/pages/root/root_binding.dart';
import 'package:flutter_scaffold/pages/root/root_view.dart';
import 'package:get/get.dart';
import 'category/category_binding.dart';
import 'category/category_view.dart';
import 'functions/handheld_barrage/handheld_barrage_binding.dart';
import 'functions/handheld_barrage/handheld_barrage_view.dart';
import 'functions/time_screen/time_screen_binding.dart';
import 'functions/time_screen/time_screen_view.dart';
import 'home/home_binding.dart';
import 'home/home_view.dart';
import 'line/line_binding.dart';
import 'line/line_view.dart';
import 'loading/loading_binding.dart';
import 'loading/loading_view.dart';

const String loading = '/'; //loading页
const String root = '/root'; //index页
const String home = '/home'; //index页
const String category = '/category'; //category
const String line = '/line'; //category
const String handheldBarrage = '/handheldBarrage'; //手持弹幕
const String timeScreen = '/timeScreen'; //时间屏幕

List<GetPage> routePage = [
  GetPage(name: loading, page: () => const LoadingPage(), binding: LoadingBinding()),
  GetPage(name: root, page: () => const RootPage(), binding: RootBinding()),
  GetPage(name: home, page: () => const HomePage(), binding: HomeBinding()),
  GetPage(name: category, page: () => const CategoryPage(), binding: CategoryBinding()),
  GetPage(name: line, page: () => const LinePage(), binding: LineBinding()),
  GetPage(name: handheldBarrage, page: () => const HandheldBarragePage(), binding: HandheldBarrageBinding()),
  GetPage(name: timeScreen, page: () => const TimeScreenPage(), binding: TimeScreenBinding()),
];
