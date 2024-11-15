

class AppCategories {
  // 静态资源 Map
  static final Map<String, List<Map<String, dynamic>>> categories = {
    '小工具': [
      {'name': '手持弹幕', 'route': '/handheldBarrage'},
      {'name': '时间屏幕', 'route': '/timeScreen'},
      {'name': '倒计时', 'route': '/countDown'},
      {'name': '记分牌', 'route': '/scoreCard'},
    ],
    '食物百科': [
      {'name': '营养成分', 'route': '/foodNutritional'},
    ],
    '休闲娱乐': [
      {'name': '五子棋', 'route': '/gobang'},
    ],
  };
}

