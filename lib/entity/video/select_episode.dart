class SelectEpisodeEntity {

  String name;
  String url;


  SelectEpisodeEntity({required this.name,required this.url});

  Map<String, dynamic> toJson() => {
    'name': name,
    'url': url,
  };

  factory SelectEpisodeEntity.fromJson(Map<String, dynamic> json) => SelectEpisodeEntity(
    name: json['name'],
    url: json['url'],
  );

 @override
  String toString() {
    return 'SelectEpisodeEntity(name: $name, url: $url)';
  }
}

