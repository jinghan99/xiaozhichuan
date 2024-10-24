import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_scaffold/tools/extensions_exp.dart';

import 'handheld_barrage_logic.dart';
import 'handheld_barrage_state.dart';

class HandheldBarragePage extends StatelessWidget {
  const HandheldBarragePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HandheldBarrageLogic logic = Get.put(HandheldBarrageLogic());
    final HandheldBarrageState state = Get.find<HandheldBarrageLogic>().state;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                      controller: state.textController,
                      decoration: InputDecoration(
                          labelText: "请输入弹幕内容",
                          labelStyle: gr16,
                          hintStyle: TextStyle(color: cB9B9B9),
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          // 不显示默认的边框
                          border: InputBorder.none,
                          // 当文本字段未获得焦点时的样式
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          // 当文本字段获得焦点时的样式
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ))).marginSymmetric(horizontal: 30, vertical: 20),
                  wordSize(state),
                  scrollSpeed(state),
                  colorSelected(context, state),
                  screenDisplay(context, state),
                ],
              ),
            ),
          ),
          Container(
                  margin: EdgeInsets.only(bottom: 30),
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: cEAF5EF,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 50,
                  width: 0.8.sw,
                  child: Text("显示弹幕", style: gr16b))
              .onTap(() {
            logic.showBarrage();
          })
        ],
      ),
    );
  }

  Widget wordSize(HandheldBarrageState state) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.format_size,
          size: 20,
          color: c7BBD9C,
        ).marginOnly(
          right: 10,
        ),
        Text(
          "字体大小",
          style: b16,
        ).marginOnly(
          right: 10,
        ),
        Obx(() {
          return Expanded(
            child: Slider(
              value: state.wordSize.value,
              onChanged: (value) {
                state.wordSize.value = value;
              },
              min: 20,
              max: 180,
              activeColor: c7BBD9C,
              inactiveColor: CDEEFE7, // 背景颜色
            ),
          );
        }),
      ],
    ).marginSymmetric(horizontal: 30, vertical: 20);
  }

  Widget scrollSpeed(HandheldBarrageState state) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.format_color_text,
          size: 20,
          color: c7BBD9C,
        ).marginOnly(
          right: 10,
        ),
        Text(
          "滚动速度",
          style: b16,
        ).marginOnly(
          right: 10,
        ),
        Obx(() {
          return Expanded(
            child: Slider(
              value: state.scrollSpeed.value.toDouble(),
              onChanged: (value) {
                state.scrollSpeed.value = value.toInt();
              },
              min: 1,
              max: 10,
              activeColor: c7BBD9C,
              inactiveColor: CDEEFE7, // 背景颜色
            ),
          );
        }),
      ],
    ).marginSymmetric(horizontal: 30, vertical: 20);
  }

  // 颜色选择按钮
  Widget colorSelected(BuildContext context, HandheldBarrageState state) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: 0.36.sw,
            height: 35.h,
            decoration: BoxDecoration(
              color: cF5,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lens,
                  size: 16,
                  color: state.textColor.value,
                ).marginOnly(right: 10),
                Text(
                  "文本颜色",
                  style: b14,
                ),
              ],
            ),
          ).onTap(() {
            _openColorPickerDialog(context, state.textColor);
          }),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: 0.36.sw,
            height: 35.h,
            decoration: BoxDecoration(
              color: cF5,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.lens,
                  size: 16,
                  color: state.backgroundColor.value,
                ).marginOnly(right: 10),
                Text(
                  "背景色",
                  style: b14,
                ),
              ],
            ),
          ).onTap(() {
            _openColorPickerDialog(context, state.backgroundColor);
          }),
        ],
      ).marginSymmetric(horizontal: 30, vertical: 20);
    });
  }

  Widget screenDisplay(BuildContext context, HandheldBarrageState state) {
    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: 0.36.sw,
            height: 35.h,
            decoration: BoxDecoration(
              color: cF5,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 14.w,
                  child: Radio<bool>(
                    value: false,
                    groupValue: state.isPortrait.value,
                    activeColor: Colors.green, // 设置选中时的颜色为绿色
                    onChanged: (value) {
                      if (value != null) {
                        state.isPortrait.value = value; // 选择竖屏
                      }
                    },
                  ),
                ).marginSymmetric(horizontal: 8),
                Text(
                  "横屏显示",
                  style: b14,
                ),
              ],
            ),
          ).onTap(() {
            state.isPortrait.value = false; // 选择竖屏
          }),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: 0.36.sw,
            height: 35.h,
            decoration: BoxDecoration(
              color: cF5,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 14.w,
                  child: Radio<bool>(
                    value: true,
                    groupValue: state.isPortrait.value,
                    activeColor: Colors.green, // 设置选中时的颜色为绿色
                    onChanged: (value) {
                      if (value != null) {
                        state.isPortrait.value = value; // 选择竖屏
                      }
                    },
                  ),
                ).marginSymmetric(horizontal: 8),
                Text(
                  "竖屏显示",
                  style: b14,
                ),
              ],
            ),
          ).onTap(() {
            state.isPortrait.value = true; // 选择竖屏
          }),
        ],
      ).marginSymmetric(horizontal: 30, vertical: 20);
    });
  }

  AppBar buildAppBar() {
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
              "手持弹幕",
              style: gr16b,
            ).paddingOnly(bottom: 5),
          ],
        ),
      ),
    );
  }

  // 颜色选择器
  void _openColorPickerDialog(BuildContext context, Rx<Color> selectedColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '选择颜色',
            style: b16b,
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: selectedColor.value, // 当前颜色
              onColorChanged: (Color color) {
                selectedColor.value = color; // 更新选中的颜色
              },
              pickerAreaHeightPercent: 0.8, // 颜色选择器的高度占比
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text(
                '确定',
                style: gr16b,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }
}
