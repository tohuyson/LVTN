import 'package:fooddelivery/model/pivot_food_topping.dart';

class Topping {
  int? id;
  String? name;
  int? price;
  String? status;
  PivotFoodTopping? pivot;

  Topping({this.id, this.name, this.price, this.status, this.pivot});

  Topping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    status = json['status'];
    pivot = json['pivot'] != null
        ? new PivotFoodTopping.fromJson(json['pivot'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['status'] = this.status;
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}
