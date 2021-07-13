import 'package:fooddelivery/model/food.dart';

class Restaurant {
  int? id;
  String? name;
  String? address;
  String? lattitude;
  String? longtitude;
  String? description;
  String? phone;
  String? rating;
  int? userId;
  String? image;
  List<Food>? foods;

  Restaurant({
    this.id,
    this.name,
    this.address,
    this.lattitude,
    this.longtitude,
    this.description,
    this.phone,
    this.rating,
    this.userId,
    this.image,
    this.foods,
  });

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    lattitude = json['lattitude'];
    longtitude = json['longtitude'];
    description = json['description'];
    phone = json['phone'];
    rating = json['rating'];
    userId = json['user_id'];
    image = json['image'];
    if (json['foods'] != null) {
      foods = new List.generate(0, (index) => new Food());
      json['foods'].forEach((v) {
        foods!.add(new Food.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['lattitude'] = this.lattitude;
    data['longtitude'] = this.longtitude;
    data['description'] = this.description;
    data['phone'] = this.phone;
    data['rating'] = this.rating;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    if (this.foods != null) {
      data['foods'] = this.foods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
