import 'package:fooddelivery/model/food.dart';

class ListFoods {
  List<Food>? listFood;

  ListFoods({this.listFood});

  ListFoods.fromJson(Map<String, dynamic> json) {
    if (json['foods'] != null) {
      listFood =
          new List<Food>.generate(0, (index) => new Food(), growable: true);
      json['foods'].forEach((v) {
        listFood!.add(new Food.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listFood != null) {
      data['foods'] = this.listFood!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
