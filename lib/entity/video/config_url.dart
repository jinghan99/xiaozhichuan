class ConfigSourcesUrl {
  String name;
  String url;

  ConfigSourcesUrl({required this.name,required this.url});

  Map<String, dynamic> toJson() => {
    'name': name,
    'url': url,
  };

  factory ConfigSourcesUrl.fromJson(Map<String, dynamic> json) => ConfigSourcesUrl(
    name: json['name'],
    url: json['url'],
  );
}
