import 'package:fooddelivery/model/topping.dart';

import 'food.dart';

class CardOrder {
  int? id;
  int? quantity;
  int? price;
  int? foodId;
  int? cartId;
  String? status;
  Food? food;
  List<Topping>? toppings;

  CardOrder({
    this.id,
    this.quantity,
    this.price,
    this.foodId,
    this.cartId,
    this.status,
    this.food,
    this.toppings,
  });

  CardOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    price = json['price'];
    foodId = json['food_id'];
    cartId = json['cart_id'];
    status = json['status'];
    food = json['food'] != null ? new Food.fromJson(json['food']) : null;
    if (json['toppings'] != null) {
      toppings = new List.generate(0, (index) => Topping());
      json['toppings'].forEach((v) {
        toppings!.add(new Topping.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['food_id'] = this.foodId;
    data['cart_id'] = this.cartId;
    data['status'] = this.status;
    if (this.food != null) {
      data['food'] = this.food!.toJson();
    }
    if (this.toppings != null) {
      data['toppings'] = this.toppings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
