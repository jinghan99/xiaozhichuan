import 'package:get/get.dart';
import 'loading/loading_binding.dart';
import 'loading/loading_view.dart';

const String loading = '/'; //loading页

List<GetPage> routePage = [
  GetPage(name: loading, page: () => const LoadingPage(), binding: LoadingBinding()),
];
