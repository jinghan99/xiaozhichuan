

class AppCategories {
  // 静态资源 Map
  static final Map<String, List<Map<String, dynamic>>> categories = {
    '常用应用': [
      {'name': '手持弹幕', 'route': '/handheldBarrage'},
      {'name': '时间屏幕', 'route': '/timeScreen'},
      {'name': '五子棋', 'route': '/gobang'},
      {'name': '抖音', 'route': '/douyin'},
      {'name': '微博', 'route': '/weibo'},
    ],
    '查询应用': [
      {'name': '百度地图', 'route': '/baidumap'},
      {'name': '高德地图', 'route': '/gaodemap'},
      {'name': '美团', 'route': '/meituan'},
      {'name': '大众点评', 'route': '/dianping'},
      {'name': '携程旅行', 'route': '/ctrip'},
    ],
    '计算应用': [
      {'name': '计算器', 'route': '/calculator'},
      {'name': '单位转换器', 'route': '/unitconverter'},
      {'name': '科学计算器', 'route': '/scientificcalculator'},
      {'name': '房贷计算器', 'route': '/loancalculator'},
    ],
    '图片应用': [
      {'name': '美图秀秀', 'route': '/meitu'},
      {'name': 'PicsArt', 'route': '/picsart'},
      {'name': 'Snapseed', 'route': '/snapseed'},
      {'name': 'VSCO', 'route': '/vsco'},
      {'name': 'Adobe Lightroom', 'route': '/lightroom'},
    ],
    '文字应用': [
      {'name': 'WPS Office', 'route': '/wps'},
      {'name': 'Microsoft Word', 'route': '/word'},
      {'name': '印象笔记', 'route': '/evernote'},
      {'name': '有道云笔记', 'route': '/youdaonote'},
      {'name': '石墨文档', 'route': '/shimowenku'},
    ],
    '设备应用': [
      {'name': '手机管家', 'route': '/phoneguard'},
      {'name': '电池优化', 'route': '/batteryoptimizer'},
      {'name': '清理大师', 'route': '/cleanmaster'},
      {'name': '安全卫士', 'route': '/securityguard'},
      {'name': '文件管理器', 'route': '/filemanager'},
    ],
    '文件应用': [
      {'name': '百度网盘', 'route': '/baiducloud'},
      {'name': 'Google Drive', 'route': '/googledrive'},
      {'name': 'Dropbox', 'route': '/dropbox'},
      {'name': 'OneDrive', 'route': '/onedrive'},
      {'name': '坚果云', 'route': '/jianguoyun'},
    ],
    '其他应用': [
      {'name': '天气通', 'route': '/weather'},
      {'name': '新闻客户端', 'route': '/news'},
      {'name': '健康宝', 'route': '/healthkit'},
      {'name': '运动记录', 'route': '/fitness'},
      {'name': '日历', 'route': '/calendar'},
    ],
  };
}