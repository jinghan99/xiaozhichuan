import 'package:flutter/material.dart';
import 'package:flutter_scaffold/pages/hot/hot_view.dart';
import 'package:flutter_scaffold/pages/root/root_logic.dart';
import 'package:flutter_scaffold/pages/root/root_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../colors/stf_colors.dart';
import '../category/category_view.dart';
import '../home/home_view.dart';
import '../line/line_view.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RootLogic logic = Get.find<RootLogic>();
    final RootState state = Get.find<RootLogic>().state;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (f, didPop) async {
        if (f) return;
        // 拦截返回键
      },
      child: Scaffold(
          body: PageView(
            controller: state.controller,
            physics: const NeverScrollableScrollPhysics(),
            children: const [HomePage(), HotPage(), LinePage()],
          ),
          bottomNavigationBar: Obx(() => BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: state.index.value,
                selectedItemColor: Color(0xff7bbd9c),
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                selectedFontSize: 10,
                unselectedFontSize: 10,
                selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
                showUnselectedLabels: true,
                onTap: (i) {
                  state.index.value = i;
                  state.controller.jumpToPage(state.index.value);
                },
                items: state.navigation.map((e) {
                  String type = e['type'];
                  return BottomNavigationBarItem(
                      icon: type == 'svg'
                          ? SvgPicture.asset(
                              e['icon'][state.index.value == state.navigation.indexOf(e) ? 1 : 0],
                              height: 24.w,
                              width: 24.w,
                              colorFilter: ColorFilter.mode(
                                state.index.value == state.navigation.indexOf(e) ? c7BBD9C : Colors.grey,
                                BlendMode.srcIn,
                              ),
                            )
                          : Icon(
                              e['icon'],
                              color: state.index.value == state.navigation.indexOf(e) ? c7BBD9C : Colors.grey,
                            ),
                      label: e['name']);
                }).toList(),
              ))),
    );
  }
}
