import 'package:fooddelivery/model/category.dart';
import 'package:fooddelivery/model/image.dart';
import 'package:fooddelivery/model/restaurant.dart';
import 'package:fooddelivery/model/topping.dart';

class Food {
  int? id;
  String? name;
  String? size;
  int? price;
  String? weight;
  String? ingredients;
  int? status;
  String? note;
  int? restaurantId;
  int? categoryId;
  List<Image>? images;
  List<Topping>? toppings;
  Restaurant? restaurant;
  Category? category;
  Pivot? pivot;

  Food(
      {this.id,
      this.name,
      this.size,
      this.price,
      this.weight,
      this.ingredients,
      this.status,
      this.note,
      this.restaurantId,
      this.categoryId,
      this.images,
      this.toppings,
      this.restaurant,
      this.category,
      this.pivot
      });

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    size = json['size'];
    price = json['price'];
    weight = json['weight'];
    ingredients = json['ingredients'];
    status = json['status'];
    note = json['note'];
    restaurantId = json['restaurant_id'];
    categoryId = json['category_id'];
    if (json['image'] != null) {
      images = new List.generate(0, (index) => new Image());
      json['image'].forEach((v) {
        images!.add(new Image.fromJson(v));
      });
    }
    if (json['toppings'] != null) {
      toppings = new List.generate(0, (index) => new Topping());
      json['toppings'].forEach((v) {
        toppings!.add(new Topping.fromJson(v));
      });
    }
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['size'] = this.size;
    data['price'] = this.price;
    data['weight'] = this.weight;
    data['ingredients'] = this.ingredients;
    data['status'] = this.status;
    data['note'] = this.note;
    data['restaurant_id'] = this.restaurantId;
    data['category_id'] = this.categoryId;
    if (this.images != null) {
      data['image'] = this.images!.map((v) => v.toJson()).toList();
    }
    if (this.toppings != null) {
      data['toppings'] = this.toppings!.map((v) => v.toJson()).toList();
    }
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    if (this.pivot != null) {
      data['pivot'] = this.pivot!.toJson();
    }
    return data;
  }
}
class Pivot {
  int? orderId;
  int? foodId;
  int? price;
  int? quantity;

  Pivot({this.orderId, this.foodId, this.price, this.quantity});

  Pivot.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    foodId = json['food_id'];
    price = json['price'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['food_id'] = this.foodId;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    return data;
  }
}
