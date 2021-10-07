import 'package:fooddelivery/model/slider.dart';

class ListSliders {
  late final List<Sliders>? listSliders;

  ListSliders({this.listSliders});

  ListSliders.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      listSliders = new List<Sliders>.filled(0, new Sliders(), growable: true);
      json['sliders'].forEach((v) {
        listSliders!.add(new Sliders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listSliders != null) {
      data['sliders'] = this.listSliders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
