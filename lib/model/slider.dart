class Sliders {
  late final int? id;
  late final String? url;

  Sliders({this.id, this.url});

  Sliders.fromJson(
    Map<String, dynamic> json,
  ) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}
