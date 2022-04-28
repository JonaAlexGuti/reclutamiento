class Results{
  late final String name;
  late final String url;

  Results(
      this.name,
      this.url,
      );

  Results.map(dynamic json){
    this.name = json['name'];
    this.url = json['url'];
  }

  Results.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}