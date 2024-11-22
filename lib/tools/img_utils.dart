import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

abstract final class ImgUtils {
// 构建图片
  static Widget buildImg(String imgUrl, String? rangk) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), // 设置圆角半径
            ),
            clipBehavior: Clip.antiAlias, // 确保子控件被裁剪
            child: CachedNetworkImage(
              imageUrl: imgUrl,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              placeholder: (context, url) => const Center(
                //加载效果
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          if (rangk != null && rangk.isNotEmpty) buildRankBadge(rangk),
        ],
      ),
    );
  }

// 构建排名角标的方法
  static Widget buildRankBadge(String rangk) {
    return Positioned(
      // 可以自定义位置
      child: Container(
        alignment: Alignment.center,
        height: 20,
        width: 19,
        padding: const EdgeInsets.all(3),
        decoration: _buildRankDecoration(rangk),
        child: Text(
          rangk, // 替换为你想要的文字或图标
          style: const TextStyle(
            color: Colors.white, // 文字颜色
            fontSize: 11, // 文字大小
          ),
        ),
      ),
    );
  }

// 榜单角标背景颜色
// 1 红色 2 橙色 3 黄色
  static Decoration _buildRankDecoration(String rank) {
    if (rank == '1') {
      return const BoxDecoration(
        color: Colors.red, // 角标背景颜色
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0), // 只设置左上角的圆角
        ),
      );
    } else if (rank == '2') {
      return const BoxDecoration(
        color: Color.fromRGBO(242, 98, 26, 1.000), // 角标背景颜色
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0), // 只设置左上角的圆角
        ),
      );
    } else {
      return const BoxDecoration(
        color: Color.fromRGBO(253, 142, 0, 1.000), // 角标背景颜色
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(5.0), // 只设置左上角的圆角
        ),
      );
    }
  }
}
